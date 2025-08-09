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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserBean user = userDAO.getUserByUsername(username);

        if (user != null && "active".equalsIgnoreCase(user.getStatus()) &&
            PasswordUtil.checkPassword(password, user.getPasswordHash())) {

            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);

            response.sendRedirect(request.getContextPath() + "/Views/Dashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("/Views/Login.jsp").forward(request, response);
        }
    }

}
