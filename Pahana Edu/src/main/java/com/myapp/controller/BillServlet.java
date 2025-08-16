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

import com.myapp.dao.BillDAO;
import com.myapp.dao.CustomerDAO;
import com.myapp.dao.ItemDAO;
import com.myapp.model.BillBean;
import com.myapp.model.CustomerBean;
import com.myapp.model.UserBean;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;


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
    	 String accountNumber = request.getParameter("accountNumber");
         CustomerBean customer = customerDAO.getCustomerByAccountNumber(accountNumber);

         String[] items = request.getParameterValues("item[]");
         String[] quantities = request.getParameterValues("quantity[]");
         String[] prices = request.getParameterValues("price[]");
         String[] totals = request.getParameterValues("total[]");

         String subtotal = request.getParameter("subtotal");
         String grandTotal = request.getParameter("grandTotal");
         String amountPaid = request.getParameter("amountPaid");
         String loyaltyPointsUsed = request.getParameter("loyaltyPoints");
         String balance = request.getParameter("balance");

         // ===== Update Item Quantities =====
         if (items != null && quantities != null) {
             for (int i = 0; i < items.length; i++) {
                 String itemName = items[i];
                 int qty = Integer.parseInt(quantities[i]);

                 int currentStock = itemDAO.getItemStock(itemName);
                 if (qty > currentStock) {
                     throw new ServletException("Not enough stock for item: " + itemName);
                 }

                 boolean updated = itemDAO.reduceItemQuantity(itemName, qty);
                 if (!updated) {
                     throw new ServletException("Failed to update stock for item: " + itemName);
                 }
             }
         }

         response.setContentType("application/pdf");
         response.setHeader("Content-Disposition", "attachment; filename=bill.pdf");

         try {
             Document document = new Document();
             PdfWriter.getInstance(document, response.getOutputStream());
             document.open();

             // Add Logo
             try {
                 String logoPath = getServletContext().getRealPath("/Images/Logo.png");
                 Image logo = Image.getInstance(logoPath);
                 logo.scaleToFit(120, 120);
                 logo.setAlignment(Element.ALIGN_CENTER);
                 document.add(logo);
                 document.add(new Paragraph(" "));
             } catch (Exception imgEx) {
                 System.out.println("Logo not found: " + imgEx.getMessage());
             }

             // Title
             Font bold = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD);
             Paragraph title = new Paragraph("Invoice", bold);
             title.setAlignment(Element.ALIGN_CENTER);
             document.add(title);
             document.add(new Paragraph(" "));

             // Customer Details
             document.add(new Paragraph("Customer: " + customer.getFirstName() + " " + customer.getLastName()));
             document.add(new Paragraph("Account No: " + customer.getAccountNumber()));
             document.add(new Paragraph("Email: " + customer.getEmail()));
             document.add(new Paragraph("Contact: " + customer.getContactNumber()));
             document.add(new Paragraph(" "));

             // Current Date
             DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
             String currentDate = dtf.format(LocalDateTime.now());
             document.add(new Paragraph("Date: " + currentDate));

             // Cashier from Session
             HttpSession session = request.getSession(false);
             String cashierName = "";
             if (session != null) {
                 UserBean cashier = (UserBean) session.getAttribute("loggedInUser");
                 if (cashier != null) {
                     cashierName = cashier.getFullName();
                     document.add(new Paragraph("Cashier: " + cashierName));
                     document.add(new Paragraph(" "));
                 }
             }

             // Table for Items
             PdfPTable table = new PdfPTable(4);
             table.setWidthPercentage(100);

             // Header Line
             PdfPCell topLineCell = new PdfPCell(new Phrase(""));
             topLineCell.setColspan(4);
             topLineCell.setBorderWidthBottom(1f);
             topLineCell.setBorder(Rectangle.BOTTOM);
             table.addCell(topLineCell);

             // Table Headers
             String[] headers = {"Item", "Quantity", "Unit Price", "Total"};
             for (String header : headers) {
                 PdfPCell cell = new PdfPCell(new Phrase(header));
                 cell.setBorder(PdfPCell.NO_BORDER);
                 cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                 table.addCell(cell);
             }

             // Bottom Line Header
             PdfPCell bottomLineCell = new PdfPCell(new Phrase(""));
             bottomLineCell.setColspan(4);
             bottomLineCell.setBorderWidthTop(1f);
             bottomLineCell.setBorder(Rectangle.TOP);
             table.addCell(bottomLineCell);

             // Table Content
             if (items != null) {
                 for (int i = 0; i < items.length; i++) {
                     table.addCell(new PdfPCell(new Phrase(items[i])));
                     table.addCell(new PdfPCell(new Phrase(quantities[i])));
                     table.addCell(new PdfPCell(new Phrase(prices[i])));
                     table.addCell(new PdfPCell(new Phrase(totals[i])));
                 }
             }
             document.add(table);
             document.add(new Paragraph(" "));

             // Loyalty Points Calculation
             int earnedPoints = 0;
             if (grandTotal != null && !grandTotal.isEmpty()) {
                 earnedPoints = (int) (Double.parseDouble(grandTotal) / 100);
                 int usedPoints = (loyaltyPointsUsed != null && !loyaltyPointsUsed.isEmpty()) ? Integer.parseInt(loyaltyPointsUsed) : 0;
                 int newPoints = customer.getRemainingUnits() - usedPoints + earnedPoints;
                 if (newPoints < 0) newPoints = 0;
                 // Update in DB
                 customerDAO.updateLoyaltyPoints(accountNumber, newPoints);
             }

             // Summary
             document.add(new Paragraph("Subtotal: Rs. " + subtotal));
             document.add(new Paragraph("Grand Total: Rs. " + grandTotal));
             document.add(new Paragraph("Amount Paid: Rs. " + amountPaid));
             document.add(new Paragraph("Loyalty Points Used: " + loyaltyPointsUsed));
             document.add(new Paragraph("Loyalty Points Earned: " + earnedPoints));
             document.add(new Paragraph("Balance: Rs. " + balance));
             document.add(new Paragraph(" "));

             // Thank You Note
             Font italic = new Font(Font.FontFamily.HELVETICA, 12, Font.ITALIC);
             Paragraph thankYou = new Paragraph("Thank you. Please come again!", italic);
             thankYou.setAlignment(Element.ALIGN_CENTER);
             document.add(thankYou);

             // Save Bill to Database
             BillBean bill = new BillBean();
             bill.setCustomerId(customer.getCustomerId());
             bill.setSubtotal(Double.parseDouble(subtotal));
             bill.setGrandTotal(Double.parseDouble(grandTotal));
             bill.setAmountPaid(Double.parseDouble(amountPaid));
             bill.setLoyaltyPointsUsed((loyaltyPointsUsed != null && !loyaltyPointsUsed.isEmpty()) ? Double.parseDouble(loyaltyPointsUsed) : 0.0);
             bill.setBalance(Double.parseDouble(balance));
             bill.setCreatedBy(cashierName);

             BillDAO billDAO = new BillDAO();
             billDAO.saveBill(bill);

             document.close();

         } catch (Exception e) {
             e.printStackTrace();
         }
     }
 }