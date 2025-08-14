package com.myapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.myapp.dao.CustomerDAO;
import com.myapp.model.CustomerBean;

@WebServlet("/SaveCustomerServlet")
public class SaveCustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private CustomerDAO customerDAO;
    
    @Override
    public void init() {
        customerDAO = new CustomerDAO();
    }
    
    public SaveCustomerServlet() {
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
            // Get form parameters
            String accountNumber = request.getParameter("accountNumber");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String contact = request.getParameter("contact");
            String address = request.getParameter("address");
            
            // Validate required fields
            if (accountNumber == null || accountNumber.trim().isEmpty() ||
                firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                contact == null || contact.trim().isEmpty() ||
                address == null || address.trim().isEmpty()) {
                
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("All fields are required");
                return;
            }
            
            // Check if customer with this account number already exists
            CustomerBean existingCustomer = customerDAO.getCustomerByAccountNumber(accountNumber.trim());
            if (existingCustomer != null) {
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                response.getWriter().write("Customer with account number " + accountNumber + " already exists");
                return;
            }
            
            // Create new customer
            CustomerBean customer = new CustomerBean();
            customer.setAccountNumber(accountNumber.trim());
            customer.setFirstName(firstName.trim());
            customer.setLastName(lastName.trim());
            customer.setEmail(email.trim());
            customer.setContactNumber(contact.trim());
            customer.setAddress(address.trim());
            customer.setRemainingUnits(0); // Default value for new customers
            
            // Save customer to database
            boolean success = customerDAO.addCustomer(customer);
            
            if (success) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Customer added successfully");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Failed to add customer");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error: " + e.getMessage());
        }
	}

}
