package com.myapp.controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.myapp.dao.UserDAO;
import com.myapp.dao.RoleDAO;
import com.myapp.model.UserBean;
import com.myapp.util.PasswordUtil;


@WebServlet("/SaveEmployeeServlet")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class SaveEmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private UserDAO userDAO;
    private RoleDAO roleDAO;
    
    @Override
    public void init() {
        userDAO = new UserDAO();
        roleDAO = new RoleDAO();
    }
   
    public SaveEmployeeServlet() {
        super();
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Redirect GET requests to the manage employees page
        response.sendRedirect(request.getContextPath() + "/Views/ManageEmployees.jsp");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null) {
            if (isAjaxRequest(request)) {
                sendJsonResponse(response, false, "Session expired. Please login again.");
            } else {
                response.sendRedirect(request.getContextPath() + "/Views/Login.jsp");
            }
            return;
        }
        
        UserBean loggedInUser = (UserBean) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() == null || 
            !"Admin".equals(loggedInUser.getRole().getRoleName())) {
            if (isAjaxRequest(request)) {
                sendJsonResponse(response, false, "Access denied. Admin privileges required.");
            } else {
                response.sendRedirect(request.getContextPath() + "/Views/Login.jsp");
            }
            return;
        }
        
        try {
            // Get form parameters
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String fullName = request.getParameter("fullName");
            String roleParam = request.getParameter("role");
            
            // Validate passwords match
            if (!password.equals(confirmPassword)) {
                String errorMsg = "Passwords do not match!";
                if (isAjaxRequest(request)) {
                    sendJsonResponse(response, false, errorMsg);
                } else {
                    request.setAttribute("errorMessage", errorMsg);
                    request.getRequestDispatcher("/Views/ManageEmployees.jsp").forward(request, response);
                }
                return;
            }
            
            // Get role ID
            int roleId = 0;
            if ("admin".equalsIgnoreCase(roleParam) || "Admin".equalsIgnoreCase(roleParam)) {
                roleId = 1;
            } else if ("cashier".equalsIgnoreCase(roleParam) || "Cashier".equalsIgnoreCase(roleParam)) {
                roleId = 2;
            } else if ("inventory manager".equalsIgnoreCase(roleParam) || "Inventory Manager".equalsIgnoreCase(roleParam)) {
                roleId = 3;
            } else {
                String errorMsg = "Invalid role selected! Valid roles are: Admin, Cashier, Inventory Manager";
                if (isAjaxRequest(request)) {
                    sendJsonResponse(response, false, errorMsg);
                } else {
                    request.setAttribute("errorMessage", errorMsg);
                    request.getRequestDispatcher("/Views/ManageEmployees.jsp").forward(request, response);
                }
                return;
            }
            
            // Handle image upload (only for multipart requests)
            String imagePath = null;
            String contentType = request.getContentType();
            if (contentType != null && contentType.toLowerCase().contains("multipart/form-data")) {
                Part filePart = request.getPart("employeeImage");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = extractFileName(filePart);
                    if (fileName != null && !fileName.isEmpty()) {
                        // Create unique filename
                        String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                        String uniqueFileName = System.currentTimeMillis() + "_" + username + fileExtension;
                        
                        // Save to Images directory
                        String uploadPath = getServletContext().getRealPath("/Images");
                        Path uploadDir = Paths.get(uploadPath);
                        if (!Files.exists(uploadDir)) {
                            Files.createDirectories(uploadDir);
                        }
                        
                        Path filePath = uploadDir.resolve(uniqueFileName);
                        try (InputStream inputStream = filePart.getInputStream()) {
                            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
                        }
                        
                        imagePath = "Images/" + uniqueFileName;
                    }
                }
            }
            
            // Create UserBean
            UserBean user = new UserBean();
            user.setUsername(username);
            user.setPasswordHash(PasswordUtil.hashPassword(password)); // Hash the password
            user.setFullName(fullName != null ? fullName : username);
            user.setRoleId(roleId);
            user.setStatus("active");
            user.setImage(imagePath);
            
            // Save to database
            boolean success = userDAO.addUser(user);
            
            if (success) {
                if (isAjaxRequest(request)) {
                    sendJsonResponse(response, true, "Employee added successfully!");
                } else {
                    request.setAttribute("successMessage", "Employee added successfully!");
                    response.sendRedirect(request.getContextPath() + "/Views/ManageEmployees.jsp");
                }
            } else {
                String errorMsg = "Failed to add employee. Username might already exist.";
                if (isAjaxRequest(request)) {
                    sendJsonResponse(response, false, errorMsg);
                } else {
                    request.setAttribute("errorMessage", errorMsg);
                    response.sendRedirect(request.getContextPath() + "/Views/ManageEmployees.jsp");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            String errorMsg = "An error occurred while adding the employee: " + e.getMessage();
            if (isAjaxRequest(request)) {
                sendJsonResponse(response, false, errorMsg);
            } else {
                request.setAttribute("errorMessage", errorMsg);
                response.sendRedirect(request.getContextPath() + "/Views/ManageEmployees.jsp");
            }
        }
	}

	private boolean isAjaxRequest(HttpServletRequest request) {
        String requestedWith = request.getHeader("X-Requested-With");
        String contentType = request.getContentType();
        return "XMLHttpRequest".equals(requestedWith) || 
               (contentType != null && contentType.contains("application/x-www-form-urlencoded"));
    }
    
    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"success\":" + success + ",\"message\":\"" + message + "\"}");
    }
    
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return null;
    }
}
