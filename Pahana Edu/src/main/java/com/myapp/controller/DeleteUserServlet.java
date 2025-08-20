package com.myapp.controller;

import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.myapp.dao.UserDAO;
import com.myapp.dao.RoleDAO;
import com.myapp.model.UserBean;
import com.myapp.model.RoleBean;
import com.myapp.util.PasswordUtil;
import com.myapp.util.JsonUtil;


@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;
    private RoleDAO roleDAO;

    public void init() {
        userDAO = new UserDAO();
        roleDAO = new RoleDAO();
    }

    
    public DeleteUserServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Check if user is admin
        if (!isAdmin(request)) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        String action = request.getParameter("action");
        
        try {
            if ("list".equals(action)) {
                List<UserBean> users = userDAO.getAllUsers();
                out.print(JsonUtil.toJson(users));
            } else if ("get".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                UserBean user = userDAO.getUserById(userId);
                if (user != null) {
                    out.print(JsonUtil.toJson(user));
                } else {
                    out.print(JsonUtil.createJsonResponse(false, "User not found"));
                }
            } else if ("roles".equals(action)) {
                List<RoleBean> roles = roleDAO.getAllRoles();
                out.print(JsonUtil.roleListToJson(roles));
            }
        } catch (Exception e) {
            out.print(JsonUtil.createJsonResponse(false, "Error: " + e.getMessage()));
        }
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Check if user is admin
        if (!isAdmin(request)) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        String action = request.getParameter("action");
        String result;
        
        // Debug logging to see what parameters are received
        System.out.println("UserManagementServlet - doPost called");
        System.out.println("Action parameter: '" + action + "'");
        System.out.println("All parameters:");
        java.util.Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            String paramValue = request.getParameter(paramName);
            System.out.println("  " + paramName + " = '" + paramValue + "'");
        }
        
        try {
            if ("add".equals(action)) {
                String username = request.getParameter("username");
                String fullName = request.getParameter("fullName");
                String password = request.getParameter("password");
                int roleId = Integer.parseInt(request.getParameter("roleId"));
                String status = request.getParameter("status");
                
                // Check if username already exists
                if (userDAO.getUserByUsername(username) != null) {
                    result = JsonUtil.createJsonResponse(false, "Username already exists");
                } else {
                    UserBean newUser = new UserBean();
                    newUser.setUsername(username);
                    newUser.setFullName(fullName);
                    newUser.setPasswordHash(password); 
                    newUser.setRoleId(roleId);
                    newUser.setStatus(status);
                    
                    boolean success = userDAO.addUser(newUser);
                    result = JsonUtil.createJsonResponse(success, success ? "User added successfully" : "Failed to add user");
                }
                
            } else if ("update".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                String username = request.getParameter("username");
                String fullName = request.getParameter("fullName");
                String password = request.getParameter("password");
                int roleId = Integer.parseInt(request.getParameter("roleId"));
                String status = request.getParameter("status");
                
                UserBean user = userDAO.getUserById(userId);
                if (user != null) {
                    user.setUsername(username);
                    user.setFullName(fullName);
                    if (password != null && !password.trim().isEmpty()) {
                        user.setPasswordHash(password); 
                    }
                    user.setRoleId(roleId);
                    user.setStatus(status);
                    
                    boolean success = userDAO.updateUser(user);
                    result = JsonUtil.createJsonResponse(success, success ? "User updated successfully" : "Failed to update user");
                } else {
                    result = JsonUtil.createJsonResponse(false, "User not found");
                }
                
            } else if ("delete".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                
                // Prevent deleting the current logged-in user
                HttpSession session = request.getSession();
                UserBean currentUser = (UserBean) session.getAttribute("loggedInUser");
                if (currentUser != null && currentUser.getUserId() == userId) {
                    result = JsonUtil.createJsonResponse(false, "Cannot delete your own account");
                } else {
                    boolean success = userDAO.deleteUser(userId);
                    result = JsonUtil.createJsonResponse(success, success ? "User deleted successfully" : "Failed to delete user");
                }
                
            } else if ("updateStatus".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                String status = request.getParameter("status");
                
                UserBean user = userDAO.getUserById(userId);
                if (user != null) {
                    user.setStatus(status);
                    boolean success = userDAO.updateUser(user);
                    result = JsonUtil.createJsonResponse(success, success ? "User status updated successfully" : "Failed to update user status");
                } else {
                    result = JsonUtil.createJsonResponse(false, "User not found");
                }
            } else {
                result = JsonUtil.createJsonResponse(false, "Invalid action");
            }
            
        } catch (Exception e) {
            result = JsonUtil.createJsonResponse(false, "Error: " + e.getMessage());
        }
        
        out.print(result);
	}
	
	private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;
        
        UserBean user = (UserBean) session.getAttribute("loggedInUser");
        return user != null && "Admin".equals(user.getRole().getRoleName());
    }

}
