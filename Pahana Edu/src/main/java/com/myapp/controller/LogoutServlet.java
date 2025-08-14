package com.myapp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	public LogoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		performLogout(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		performLogout(request, response);
	}
	
	private void performLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			System.out.println("LogoutServlet: Logout request received");
			
			HttpSession session = request.getSession(false);
			if (session != null) {
				System.out.println("LogoutServlet: Invalidating session for user");
				session.invalidate();
			} else {
				System.out.println("LogoutServlet: No active session found");
			}
			
			// Clear any cookies if needed
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", 0);
			
			System.out.println("LogoutServlet: Redirecting to login page");
			response.sendRedirect(request.getContextPath() + "/Views/Login.jsp");
		} catch (Exception e) {
			System.err.println("LogoutServlet: Error during logout: " + e.getMessage());
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/Views/Login.jsp");
		}
	}

}
