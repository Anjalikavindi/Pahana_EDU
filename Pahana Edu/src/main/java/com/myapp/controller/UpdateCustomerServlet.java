package com.myapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.myapp.dao.CustomerDAO;
import com.myapp.model.CustomerBean;

@WebServlet("/UpdateCustomerServlet")
public class UpdateCustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private CustomerDAO customerDAO;
    
    @Override
    public void init() {
        customerDAO = new CustomerDAO();
    }
       
    public UpdateCustomerServlet() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Redirect GET requests to the manage customers page
        response.sendRedirect(request.getContextPath() + "/Views/ManageCustomers.jsp");
	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
		try {
            // Get form parameters
            String accountNumber = request.getParameter("accountNo");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String contact = request.getParameter("contact");
            String address = request.getParameter("address");
            
            // Debug: Log received parameters
            System.out.println("UpdateCustomerServlet - Received parameters:");
            System.out.println("accountNo: " + accountNumber);
            System.out.println("name: " + name);
            System.out.println("email: " + email);
            System.out.println("contact: " + contact);
            System.out.println("address: " + address);
            
            // Validate required fields
            if (accountNumber == null || accountNumber.trim().isEmpty() ||
                name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                contact == null || contact.trim().isEmpty() ||
                address == null || address.trim().isEmpty()) {
                
            	response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"message\": \"All fields are required.\"}");
                return;
            }
            
            // Check if customer exists
            CustomerBean existingCustomer = customerDAO.getCustomerByAccountNumber(accountNumber.trim());
            if (existingCustomer == null) {
            	response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"message\": \"Customer not found.\"}");
                return;
            }
            
            // Parse the full name into first and last name
            String[] nameParts = name.trim().split("\\s+", 2);
            String firstName = nameParts[0];
            String lastName = nameParts.length > 1 ? nameParts[1] : "";
            
            // Update customer information
            CustomerBean customer = new CustomerBean();
            customer.setAccountNumber(accountNumber.trim());
            customer.setFirstName(firstName);
            customer.setLastName(lastName);
            customer.setEmail(email.trim());
            customer.setContactNumber(contact.trim());
            customer.setAddress(address.trim());
            customer.setRemainingUnits(existingCustomer.getRemainingUnits()); // Keep existing units
            
            // Update customer in database
            System.out.println("Attempting to update customer: " + customer.getAccountNumber());
            boolean success = customerDAO.updateCustomer(customer);
            System.out.println("Update result: " + success);
            
            if (success) {
            	response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"message\": \"Customer updated successfully.\"}");
            } else {
            	response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"message\": \"Failed to update customer.\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"message\": \"Error: " + e.getMessage() + "\"}");
        }
	}

}
