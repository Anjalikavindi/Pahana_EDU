package com.myapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.PrintWriter;


import com.myapp.dao.ItemDAO;
import com.myapp.model.ItemBean;

@WebServlet("/UpdateItemServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 10 * 1024 * 1024
)
public class UpdateItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String UPLOAD_DIR = "uploaded_images";
    
    public UpdateItemServlet() {
        super();
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Set request encoding to handle UTF-8 characters
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        String jsonResponse = null;

        try {
            // Get form parameters with detailed logging
            String itemIdStr = request.getParameter("itemId");
            String itemName = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String quantityStr = request.getParameter("quantity");
            String description = request.getParameter("description");
            
            // Debug logging (remove in production)
            System.out.println("UpdateItemServlet - Received parameters:");
            System.out.println("itemId: " + itemIdStr);
            System.out.println("name: " + itemName);
            System.out.println("price: " + priceStr);
            System.out.println("quantity: " + quantityStr);
            System.out.println("description: " + description);
            
            // Validate required fields
            if (itemIdStr == null || itemIdStr.trim().isEmpty() || 
                itemName == null || itemName.trim().isEmpty() || 
                priceStr == null || priceStr.trim().isEmpty() || 
                quantityStr == null || quantityStr.trim().isEmpty()) {
                
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse = "{\"success\": false, \"message\": \"All required fields must be filled.\"}";
            } else {
                try {
                    int itemId = Integer.parseInt(itemIdStr.trim());
                    double price = Double.parseDouble(priceStr.trim());
                    int quantity = Integer.parseInt(quantityStr.trim());

                    // Validate numeric values
                    if (price < 0) {
                        jsonResponse = "{\"success\": false, \"message\": \"Price cannot be negative.\"}";
                    } else if (quantity < 0) {
                        jsonResponse = "{\"success\": false, \"message\": \"Quantity cannot be negative.\"}";
                    } else {
                        String imagePath = null;
                        
                        // Handle image upload if new file is provided
                        try {
                            Part filePart = request.getPart("itemImage");
                            
                            if (filePart != null && filePart.getSize() > 0) {
                                String submittedFileName = filePart.getSubmittedFileName();
                                
                                if (submittedFileName != null && !submittedFileName.trim().isEmpty()) {
                                    // Validate file type
                                    String lowerFileName = submittedFileName.toLowerCase();
                                    if (lowerFileName.endsWith(".jpg") || lowerFileName.endsWith(".jpeg") || 
                                        lowerFileName.endsWith(".png") || lowerFileName.endsWith(".gif")) {
                                        
                                        String ext = submittedFileName.substring(submittedFileName.lastIndexOf("."));
                                        String fileName = "item_" + System.currentTimeMillis() + ext;

                                        // Use same upload directory as AddItemServlet
                                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                                        File uploadDir = new File(uploadPath);
                                        if (!uploadDir.exists()) {
                                            uploadDir.mkdirs();
                                        }

                                        String fullFilePath = uploadPath + File.separator + fileName;
                                        filePart.write(fullFilePath);
                                        imagePath = UPLOAD_DIR + "/" + fileName;
                                        
                                        System.out.println("New image uploaded: " + imagePath);
                                    } else {
                                        jsonResponse = "{\"success\": false, \"message\": \"Invalid file type. Only JPG, PNG, and GIF are allowed.\"}";
                                    }
                                }
                            }
                        } catch (Exception fileException) {
                            System.out.println("File upload error (continuing without new image): " + fileException.getMessage());
                            // Continue without updating image if there's a file upload error
                        }
                        
                        if (jsonResponse == null) { // No validation errors so far
                            // Create ItemBean with updated values
                            ItemBean item = new ItemBean();
                            item.setItemId(itemId);
                            item.setItemName(itemName.trim());
                            item.setPrice(price);
                            item.setQuantity(quantity);
                            item.setItemDescription(description != null ? description.trim() : "");
                            
                            // Only set imagePath if a new file was uploaded
                            if (imagePath != null && !imagePath.trim().isEmpty()) {
                                item.setImagePath(imagePath);
                            }

                            System.out.println("Calling DAO to update item with ID: " + itemId);
                            
                            ItemDAO dao = new ItemDAO();
                            boolean updated = dao.updateItem(item);

                            if (updated) {
                                response.setStatus(HttpServletResponse.SC_OK);
                                jsonResponse = "{\"success\": true, \"message\": \"Item updated successfully!\"}";
                                System.out.println("Item updated successfully in database");
                            } else {
                                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                                jsonResponse = "{\"success\": false, \"message\": \"Failed to update item in database.\"}";
                                System.out.println("Database update failed");
                            }
                        }
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    jsonResponse = "{\"success\": false, \"message\": \"Price and quantity must be valid numbers.\"}";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            String safeMsg = e.getMessage() != null ? 
                e.getMessage().replace("\"", "\\\"").replace("\n", " ").replace("\r", " ") : 
                "Unknown error occurred";
            jsonResponse = "{\"success\": false, \"message\": \"Server error: " + safeMsg + "\"}";
        }

        // Send response
        if (jsonResponse != null) {
            out.print(jsonResponse);
            out.flush();
        }
        out.close();
    }
}