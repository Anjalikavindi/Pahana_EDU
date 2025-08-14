package com.myapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.myapp.model.UserBean;
import com.myapp.dao.UserDAO;
import com.myapp.util.PasswordUtil;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect GET requests to login page
        response.sendRedirect(request.getContextPath() + "/Views/Login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            System.out.println("LoginServlet: POST request received");
            
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            System.out.println("LoginServlet: Username = " + username);
            System.out.println("LoginServlet: Password provided = " + (password != null && !password.isEmpty()));

            UserBean user = userDAO.getUserByUsername(username);
            System.out.println("LoginServlet: User found = " + (user != null));

            if (user != null && "active".equalsIgnoreCase(user.getStatus()) &&
                PasswordUtil.checkPassword(password, user.getPasswordHash())) {

                System.out.println("LoginServlet: Authentication successful for user: " + username);
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", user);

                response.sendRedirect(request.getContextPath() + "/Views/Dashboard.jsp");
            } else {
                System.out.println("LoginServlet: Authentication failed for user: " + username);
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.getRequestDispatcher("/Views/Login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("LoginServlet: Error during login process: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred during login. Please try again.");
            request.getRequestDispatcher("/Views/Login.jsp").forward(request, response);
        }
    }

}
