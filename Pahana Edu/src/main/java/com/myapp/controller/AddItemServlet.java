package com.myapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;

import com.myapp.dao.ItemDAO;
import com.myapp.model.ItemBean;


@WebServlet("/AddItemServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
maxFileSize = 1024 * 1024 * 10,       // 10MB
maxRequestSize = 1024 * 1024 * 50)    // 50MB
public class AddItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static final String UPLOAD_DIR = "uploaded_images";
    
    public AddItemServlet() {
        super();
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json"); // JSON response
        response.setCharacterEncoding("UTF-8");
        
        // Get logged-in user from session
        HttpSession session = request.getSession(false);
        String createdBy = "Unknown"; // default in case user not found
        if (session != null && session.getAttribute("loggedInUser") != null) {
            // Assuming you store a UserBean object in session
            createdBy = ((com.myapp.model.UserBean) session.getAttribute("loggedInUser")).getUsername();
        }

        String itemName = request.getParameter("itemName");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        String description = request.getParameter("description");
        Part filePart = request.getPart("image");

        double price = 0;
        int quantity = 0;

        try {
            price = Double.parseDouble(priceStr);
            quantity = Integer.parseInt(quantityStr);
        } catch (NumberFormatException e) {
        	// Sending JSON for a specific error
        	response.getWriter().write("{\"success\":false, \"message\":\"Invalid price or quantity.\"}");
            return;
        }

        // Handle image upload
        String fileName = new File(filePart.getSubmittedFileName()).getName();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Create ItemBean
        ItemBean item = new ItemBean();
        item.setItemName(itemName);
        item.setPrice(price);
        item.setQuantity(quantity);
        item.setItemDescription(description);
        item.setImagePath(UPLOAD_DIR + "/" + fileName);
        item.setCreatedBy(createdBy); 

        // Add to DB
        ItemDAO dao = new ItemDAO();
        boolean added = dao.addItem(item);

        if (added) {
            // Sending JSON for success
            response.getWriter().write("{\"success\":true, \"message\":\"Item added successfully!\"}");
        } else {
            // Sending JSON for a generic failure
            response.getWriter().write("{\"success\":false, \"message\":\"Failed to add item. Try again!\"}");
        }
    }
    
//    private void sendError(HttpServletResponse response, String message) throws IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        response.getWriter().println(
//            "<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>" +
//            "<script>" +
//            "Swal.fire({ icon: 'error', title: 'Error', text: '" + message + "' });" +
//            "</script>"
//        );
//    }

}
