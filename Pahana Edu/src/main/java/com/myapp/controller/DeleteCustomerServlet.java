package com.myapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.myapp.dao.CustomerDAO;

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private CustomerDAO customerDAO;
    
    @Override
    public void init() {
        customerDAO = new CustomerDAO();
    }
    
    public DeleteCustomerServlet() {
        super();
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Redirect GET requests to the manage customers page
        response.sendRedirect(request.getContextPath() + "/Views/ManageCustomers.jsp");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
            // Get account number parameter
            String accountNumber = request.getParameter("accountNumber");
            
            // Debug logging
            System.out.println("DeleteCustomerServlet - Received accountNumber: '" + accountNumber + "'");
            System.out.println("DeleteCustomerServlet - Parameter names: " + java.util.Collections.list(request.getParameterNames()));
            
            // Validate required field
            if (accountNumber == null || accountNumber.trim().isEmpty()) {
                System.out.println("DeleteCustomerServlet - Account number validation failed");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Account number is required");
                return;
            }
            
            // Check if customer exists
            if (customerDAO.getCustomerByAccountNumber(accountNumber.trim()) == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Customer not found");
                return;
            }
            
            // Delete customer from database
            boolean success = customerDAO.deleteCustomer(accountNumber.trim());
            
            if (success) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Customer deleted successfully");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Failed to delete customer");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error: " + e.getMessage());
        }
	}

}
