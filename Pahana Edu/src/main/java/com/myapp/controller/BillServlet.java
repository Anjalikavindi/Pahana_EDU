package com.myapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;   
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.io.ByteArrayOutputStream;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.util.ByteArrayDataSource;
import javax.activation.*;

import com.myapp.model.BillItemBean;
import com.myapp.dao.BillDAO;
import com.myapp.dao.CustomerDAO;
import com.myapp.dao.ItemDAO;
import com.myapp.model.BillBean;
import com.myapp.model.CustomerBean;
import com.myapp.model.UserBean;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import java.util.Properties;



@WebServlet("/BillServlet")
public class BillServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CustomerDAO customerDAO;
	private ItemDAO itemDAO;

	
	@Override
    public void init() {
        customerDAO = new CustomerDAO();
        itemDAO = new ItemDAO();
    }
       
    public BillServlet() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String accountNumber = request.getParameter("accountNumber");
        if (accountNumber != null && !accountNumber.isEmpty()) {
            CustomerBean customer = customerDAO.getCustomerByAccountNumber(accountNumber);
            if (customer != null) {
                request.setAttribute("selectedCustomer", customer);
            }
        }
        request.getRequestDispatcher("/Views/Bill.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false);

        String accountNumber = request.getParameter("accountNumber");
        CustomerBean customer = customerDAO.getCustomerByAccountNumber(accountNumber);
        if (customer == null) {
            setErrorAndRedirect(request, response, "Please select a valid customer before generating the bill.");
            return;
        }

        String[] items = request.getParameterValues("item[]");
        String[] quantities = request.getParameterValues("quantity[]");
        String[] prices = request.getParameterValues("price[]");
        String[] totals = request.getParameterValues("total[]");

        String subtotalStr = request.getParameter("subtotal");
        String grandTotalStr = request.getParameter("grandTotal");
        String amountPaidStr = request.getParameter("amountPaid");
        String loyaltyPointsUsedStr = request.getParameter("loyaltyPoints");
        String balanceStr = request.getParameter("balance");

        // ===== Validate items =====
        if (!hasValidItem(items, quantities)) {
            setErrorAndRedirect(request, response, "Please select at least one item with a quantity greater than 0.");
            return;
        }

        double subtotal = parseDouble(subtotalStr);
        double grandTotal = parseDouble(grandTotalStr);
        double amountPaid = parseDouble(amountPaidStr);
        double loyaltyPointsUsed = parseDouble(loyaltyPointsUsedStr);
        double balance = parseDouble(balanceStr);

        if ((amountPaid + loyaltyPointsUsed) < grandTotal) {
            setErrorAndRedirect(request, response, "Payment (Amount + Loyalty Points) must be greater than or equal to the Grand Total.");
            return;
        }

        // ===== Update Item Stock =====
        if (!updateStock(items, quantities, request, response)) return;

        // ===== Prepare BillBean =====
        String cashierName = "";
        if (session != null) {
            UserBean cashier = (UserBean) session.getAttribute("loggedInUser");
            if (cashier != null) cashierName = cashier.getFullName();
        }

        BillBean bill = new BillBean();
        bill.setCustomerId(customer.getCustomerId());
        bill.setSubtotal(subtotal);
        bill.setGrandTotal(grandTotal);
        bill.setAmountPaid(amountPaid);
        bill.setLoyaltyPointsUsed(loyaltyPointsUsed);
        bill.setBalance(balance);
        bill.setCreatedBy(cashierName);

        List<BillItemBean> billItems = new ArrayList<>();
        if (items != null && quantities != null && prices != null) {
            for (int i = 0; i < items.length; i++) {
                BillItemBean billItem = new BillItemBean();
                int itemId = itemDAO.getItemIdByName(items[i]);
                billItem.setItemId(itemId);
                billItem.setQuantity(parseInt(quantities[i]));
                billItem.setUnitPrice(parseDouble(prices[i]));
                billItem.setTotalPrice(parseDouble(totals[i]));
                billItems.add(billItem);
            }
        }
        bill.setItems(billItems);

        // ===== Save Bill =====
        BillDAO billDAO = new BillDAO();
        boolean saved = billDAO.saveBill(bill);
        if (!saved) {
            setErrorAndRedirect(request, response, "Failed to save bill to database.");
            return;
        }

        // ===== Generate PDF and update loyalty points =====
        try {
            int earnedPoints = (int) (grandTotal / 100);
            int newPoints = Math.max(0, customer.getRemainingUnits() - (int) loyaltyPointsUsed + earnedPoints);

            customerDAO.updateLoyaltyPoints(accountNumber, newPoints);

            ByteArrayOutputStream baos = generatePDF(customer, cashierName, items, quantities, prices, totals, subtotal, grandTotal, amountPaid, loyaltyPointsUsed, earnedPoints, balance);

            // Send email (but don't block the response if it fails)
            try {
                sendEmailWithAttachment(customer.getEmail(), "Your Invoice", "Please find attached your invoice.", baos.toByteArray());
            } catch (Exception emailException) {
                System.err.println("Failed to send email: " + emailException.getMessage());
                // Continue with PDF download even if email fails
            }

            // Send PDF to browser - this commits the response
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=bill_" + customer.getAccountNumber() + ".pdf");
            response.getOutputStream().write(baos.toByteArray());
            response.getOutputStream().flush();
            
            // REMOVED: Cannot redirect after response is committed
            // The PDF download itself serves as the success indicator
            // If you need success tracking, use AJAX or a different approach

        } catch (Exception e) {
            e.printStackTrace();
            // Only redirect if response hasn't been committed yet
            if (!response.isCommitted()) {
                setErrorAndRedirect(request, response, "Error generating or sending bill: " + e.getMessage());
            } else {
                // Log the error since we can't redirect
                System.err.println("Error after response committed: " + e.getMessage());
            }
        }
    }

    private boolean hasValidItem(String[] items, String[] quantities) {
        if (items == null || quantities == null) return false;
        for (int i = 0; i < items.length; i++) {
            if (items[i] != null && !items[i].isEmpty()) {
                int qty = parseInt(quantities[i]);
                if (qty > 0) return true;
            }
        }
        return false;
    }

    private boolean updateStock(String[] items, String[] quantities, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        for (int i = 0; i < items.length; i++) {
            String itemName = items[i];
            int qty = parseInt(quantities[i]);
            int currentStock = itemDAO.getItemStock(itemName);
            if (qty > currentStock) {
                setErrorAndRedirect(request, response, "Not enough stock for item: " + itemName);
                return false;
            }
            boolean updated = itemDAO.reduceItemQuantity(itemName, qty);
            if (!updated) {
                setErrorAndRedirect(request, response, "Failed to update stock for item: " + itemName);
                return false;
            }
        }
        return true;
    }

    private ByteArrayOutputStream generatePDF(CustomerBean customer, String cashierName, String[] items, String[] quantities, String[] prices, String[] totals,
                                              double subtotal, double grandTotal, double amountPaid, double loyaltyPointsUsed, int loyaltyPointsEarned, double balance) throws Exception {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Document document = new Document();
        PdfWriter.getInstance(document, baos);
        document.open();

        try {
            String logoPath = getServletContext().getRealPath("/Images/Logo.png");
            Image logo = Image.getInstance(logoPath);
            logo.scaleToFit(120, 120);
            logo.setAlignment(Element.ALIGN_CENTER);
            document.add(logo);
            document.add(new Paragraph(" "));
        } catch (Exception e) {
            System.out.println("Logo not found: " + e.getMessage());
        }

        Font bold = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD);
        Paragraph title = new Paragraph("Invoice", bold);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);
        document.add(new Paragraph(" "));

        document.add(new Paragraph("Customer: " + customer.getFirstName() + " " + customer.getLastName()));
        document.add(new Paragraph("Account No: " + customer.getAccountNumber()));
        document.add(new Paragraph("Email: " + customer.getEmail()));
        document.add(new Paragraph("Contact: " + customer.getContactNumber()));
        document.add(new Paragraph(" "));

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        String currentDate = dtf.format(LocalDateTime.now());
        document.add(new Paragraph("Date: " + currentDate));
        document.add(new Paragraph("Cashier: " + cashierName));
        document.add(new Paragraph(" "));

        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);
        String[] headers = {"Item", "Quantity", "Unit Price", "Total"};
        for (String header : headers) {
            PdfPCell cell = new PdfPCell(new Phrase(header));
            cell.setBorder(PdfPCell.NO_BORDER);
            table.addCell(cell);
        }

        if (items != null) {
            for (int i = 0; i < items.length; i++) {
                table.addCell(new PdfPCell(new Phrase(items[i]))).setBorder(PdfPCell.NO_BORDER);
                table.addCell(new PdfPCell(new Phrase(quantities[i]))).setBorder(PdfPCell.NO_BORDER);
                table.addCell(new PdfPCell(new Phrase(prices[i]))).setBorder(PdfPCell.NO_BORDER);
                table.addCell(new PdfPCell(new Phrase(totals[i]))).setBorder(PdfPCell.NO_BORDER);
            }
        }
        document.add(table);
        document.add(new Paragraph(" "));

        document.add(new Paragraph("Subtotal: Rs. " + subtotal));
        document.add(new Paragraph("Grand Total: Rs. " + grandTotal));
        document.add(new Paragraph("Amount Paid: Rs. " + amountPaid));
        document.add(new Paragraph("Loyalty Points Used: " + loyaltyPointsUsed));
        document.add(new Paragraph("Loyalty Points Earned: " + loyaltyPointsEarned));
        document.add(new Paragraph("Balance: Rs. " + balance));
        document.add(new Paragraph(" "));

        Font italic = new Font(Font.FontFamily.HELVETICA, 12, Font.ITALIC);
        Paragraph thankYou = new Paragraph("Thank you. Please come again!", italic);
        thankYou.setAlignment(Element.ALIGN_CENTER);
        document.add(thankYou);

        document.close();
        return baos;
    }

    private void sendEmailWithAttachment(String toEmail, String subject, String body, byte[] pdfBytes) throws Exception {
        final String fromEmail = "anjalikavindy@gmail.com";
        final String password = "ojeb laeu amrx lpcj";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        session.setDebug(true);

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);

        MimeBodyPart textPart = new MimeBodyPart();
        textPart.setText(body);

        MimeBodyPart attachmentPart = new MimeBodyPart();
        DataSource source = new ByteArrayDataSource(pdfBytes, "application/pdf");
        attachmentPart.setDataHandler(new DataHandler(source));
        attachmentPart.setFileName("Invoice.pdf");

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(textPart);
        multipart.addBodyPart(attachmentPart);

        message.setContent(multipart);
        Transport.send(message);
    }

    private void setErrorAndRedirect(HttpServletRequest request, HttpServletResponse response, String message) throws IOException {
        HttpSession session = request.getSession();
        session.setAttribute("billError", message);
        response.sendRedirect(request.getContextPath() + "/BillServlet");
    }

    private int parseInt(String str) {
        try {
            return Integer.parseInt(str);
        } catch (Exception e) {
            return 0;
        }
    }

    private double parseDouble(String str) {
        try {
            return Double.parseDouble(str);
        } catch (Exception e) {
            return 0.0;
        }
    }
}