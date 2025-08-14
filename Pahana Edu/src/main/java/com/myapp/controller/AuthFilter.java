package com.myapp.controller;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import com.myapp.model.UserBean;

@WebFilter("/Views/*")
public class AuthFilter implements Filter {
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("loggedInUser") != null);
        String loginURI = request.getContextPath() + "/Views/Login.jsp";
        String requestURI = request.getRequestURI();

        // Allow access to login page and login servlet
        if (requestURI.equals(loginURI) || requestURI.contains("/LoginServlet")) {
            chain.doFilter(request, response);
            return;
        }

        // Check if user is logged in
        if (!loggedIn) {
            response.sendRedirect(loginURI);
            return;
        }

        // Get user and check role-based access
        UserBean user = (UserBean) session.getAttribute("loggedInUser");
        String userRole = user.getRole().getRoleName();
        
        // Check if user has access to the requested page
        if (hasAccess(userRole, requestURI)) {
            chain.doFilter(request, response);
        } else {
            // Redirect to unauthorized page or dashboard
            response.sendRedirect(request.getContextPath() + "/Views/Dashboard.jsp?error=unauthorized");
        }
    }
    
    private boolean hasAccess(String userRole, String requestURI) {
        // Admin has access to everything
        if ("Admin".equals(userRole)) {
            return true;
        }
        
        // Define role-based access rules
        if ("Cashier".equals(userRole)) {
            List<String> cashierPages = Arrays.asList(
                "Dashboard.jsp", "Bill.jsp", "ManageCustomers.jsp", "Help.jsp",
                "AddCustomer.jsp", "DisplayCustomerDetails.jsp", "UpdateCustomerDetails.jsp"
            );
            return cashierPages.stream().anyMatch(page -> requestURI.contains(page));
        }
        
        if ("Inventory Manager".equals(userRole)) {
            List<String> inventoryPages = Arrays.asList(
                "Dashboard.jsp", "ManageItems.jsp", "Help.jsp",
                "AddNewItem.jsp", "DisplayItemDetails.jsp", "UpdateItemDetails.jsp"
            );
            return inventoryPages.stream().anyMatch(page -> requestURI.contains(page));
        }
        
        // Default deny access
        return false;
    }
}