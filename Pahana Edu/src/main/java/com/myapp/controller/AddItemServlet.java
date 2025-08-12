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
import java.io.InputStream;

import com.myapp.dao.ItemDAO;
import com.myapp.model.ItemBean;


@WebServlet("/AddItemServlet")
@MultipartConfig(maxFileSize = 16177215) 
public class AddItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private ItemDAO itemDAO;
	
	@Override
    public void init() {
        itemDAO = new ItemDAO();
    }
    
    public AddItemServlet() {
        super();
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Retrieve logged-in user's name from session
        HttpSession session = request.getSession(false);
        String createdBy = (session != null) ? (String) session.getAttribute("username") : "Unknown";

        // Create ItemBean
        ItemBean item = new ItemBean();
        item.setItemName(request.getParameter("itemName"));
        item.setUnitPrice(Double.parseDouble(request.getParameter("price")));
        item.setStockQuantity(Integer.parseInt(request.getParameter("quantity")));
        item.setDescription(request.getParameter("description"));
        item.setCreatedBy(createdBy);

        // Process uploaded file
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream inputStream = filePart.getInputStream()) {
                byte[] imageBytes = inputStream.readAllBytes();
                item.setImage(imageBytes);
            }
        }

        // Save to DB
        boolean success = itemDAO.saveItem(item);

        if (success) {
            request.setAttribute("message", "Item added successfully!");
        } else {
            request.setAttribute("message", "Failed to add item.");
        }

        // Forward to a JSP (or redirect)
        request.getRequestDispatcher("/Views/ManageItems.jsp").forward(request, response);
    }

}
