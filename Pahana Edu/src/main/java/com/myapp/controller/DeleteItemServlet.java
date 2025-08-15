package com.myapp.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.myapp.dao.ItemDAO;

@WebServlet("/DeleteItemServlet")
public class DeleteItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private ItemDAO itemDAO;
	
	@Override
    public void init() {
        itemDAO = new ItemDAO();
    }
	
    public DeleteItemServlet() {
        super();
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("application/json");
    	response.setContentType("application/json");
        String jsonResponse;

        try {
            String itemIdStr = request.getParameter("item_id");
            if (itemIdStr == null || itemIdStr.trim().isEmpty()) {
                jsonResponse = "{\"success\": false, \"message\": \"Item ID is missing\"}";
                response.getWriter().write(jsonResponse);
                return;
            }

            int itemId = Integer.parseInt(itemIdStr);

            boolean deleted = itemDAO.deleteItem(itemId);
            if (deleted) {
                jsonResponse = "{\"success\": true, \"message\": \"Item deleted successfully\"}";
            } else {
                jsonResponse = "{\"success\": false, \"message\": \"Failed to delete item\"}";
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse = "{\"success\": false, \"message\": \"Error: " + e.getMessage().replace("\"", "\\\"") + "\"}";
        }

        response.getWriter().write(jsonResponse);
    }
}
