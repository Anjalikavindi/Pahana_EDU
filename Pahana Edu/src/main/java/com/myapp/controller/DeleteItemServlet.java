package com.myapp.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.myapp.util.DBConnection;


@WebServlet("/DeleteItemServlet")
public class DeleteItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public DeleteItemServlet() {
        super();
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 request.setCharacterEncoding("UTF-8");
         response.setContentType("text/html;charset=UTF-8");

         String itemIdParam = request.getParameter("item_id");

         if (itemIdParam == null || itemIdParam.isEmpty()) {
             response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing item_id parameter");
             return;
         }

         int itemId;
         try {
             itemId = Integer.parseInt(itemIdParam);
         } catch (NumberFormatException e) {
             response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid item_id parameter");
             return;
         }

         // Delete item from DB
         try (Connection conn = DBConnection.getConnection();
              PreparedStatement ps = conn.prepareStatement("DELETE FROM items WHERE item_id = ?")) {

             ps.setInt(1, itemId);
             int rowsAffected = ps.executeUpdate();

             if (rowsAffected > 0) {
                 // Redirect or send success JSON/message
                 response.sendRedirect("itemList.jsp?msg=deleted");
             } else {
                 response.sendRedirect("itemList.jsp?msg=notfound");
             }

         } catch (SQLException e) {
             throw new ServletException("Database error while deleting item", e);
         }
     }

}
