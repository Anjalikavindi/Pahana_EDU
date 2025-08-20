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
    	response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String jsonResponse;

        try {
            // Get form parameters
            String itemIdStr = request.getParameter("itemId");
            String itemName = request.getParameter("name");
            String priceStr = request.getParameter("price");
            String quantityStr = request.getParameter("quantity");
            String description = request.getParameter("description");
            
            // Validate required fields
            if (itemIdStr == null || itemIdStr.trim().isEmpty() || itemName == null || itemName.trim().isEmpty() || 
                priceStr == null || priceStr.trim().isEmpty() || quantityStr == null || quantityStr.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse = "{\"success\": false, \"message\": \"All required fields must be filled.\"}";
            } else {
                int itemId;
                double price;
                int quantity;
                
                try {
                    itemId = Integer.parseInt(itemIdStr.trim());
                    price = Double.parseDouble(priceStr.trim());
                    quantity = Integer.parseInt(quantityStr.trim());

                    String imagePath = null;
                    Part filePart = request.getPart("itemImage");

                    // Only process if file exists and size > 0
                    if (filePart != null && filePart.getSize() > 0) {
                        String submittedFileName = filePart.getSubmittedFileName();
                        String ext = submittedFileName.substring(submittedFileName.lastIndexOf("."));
                        String fileName = "item_" + System.currentTimeMillis() + ext;

                        String uploadPath = getServletContext().getRealPath("") + File.separator + "Images";
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdir();
                        }

                        filePart.write(uploadPath + File.separator + fileName);
                        imagePath = "Images/" + fileName;
                    }

                    ItemBean item = new ItemBean();
                    item.setItemId(itemId);
                    item.setItemName(itemName.trim());
                    item.setPrice(price);
                    item.setQuantity(quantity);
                    item.setItemDescription(description != null ? description.trim() : "");
                    
                    // The fix: only set imagePath if a new file was uploaded
                    if (imagePath != null) {
                        item.setImagePath(imagePath);
                    }

                    ItemDAO dao = new ItemDAO();
                    boolean updated = dao.updateItem(item);

                    if (updated) {
                        response.setStatus(HttpServletResponse.SC_OK);
                        jsonResponse = "{\"success\": true, \"message\": \"Item updated successfully!\"}";
                    } else {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        jsonResponse = "{\"success\": false, \"message\": \"Failed to update item.\"}";
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
            String safeMsg = e.getMessage() != null ? e.getMessage().replace("\"", "\\\"") : "Unknown error";
            jsonResponse = "{\"success\": false, \"message\": \"An internal server error occurred: " + safeMsg + "\"}";
        }

        if (jsonResponse != null) {
            out.print(jsonResponse);
            out.flush();
        }
    }
}