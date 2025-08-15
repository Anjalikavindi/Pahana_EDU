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
       
    
    public UpdateItemServlet() {
        super();
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String jsonResponse;

        try {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            String itemName = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String description = request.getParameter("description");

            String imagePath = null;
            Part filePart = request.getPart("itemImage");
            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = filePart.getSubmittedFileName();
                String ext = submittedFileName.substring(submittedFileName.lastIndexOf("."));
                String fileName = "item_" + System.currentTimeMillis() + ext;

                String uploadPath = getServletContext().getRealPath("") + File.separator + "Images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                filePart.write(uploadPath + File.separator + fileName);
                imagePath = "Images/" + fileName;
            }

            ItemBean item = new ItemBean();
            item.setItemId(itemId);
            item.setItemName(itemName);
            item.setPrice(price);
            item.setQuantity(quantity);
            item.setItemDescription(description);
            item.setImagePath(imagePath); // Can be null if no new image

            ItemDAO dao = new ItemDAO();
            boolean updated = dao.updateItem(item);

            if (updated) {
                jsonResponse = "{\"success\": true, \"message\": \"Item updated successfully!\"}";
            } else {
                jsonResponse = "{\"success\": false, \"message\": \"Failed to update item.\"}";
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse = "{\"success\": false, \"message\": \"Error: " + e.getMessage().replace("\"", "\\\"") + "\"}";
        }

        out.print(jsonResponse);
        out.flush();
    }

}
