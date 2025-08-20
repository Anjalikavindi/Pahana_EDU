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

@WebServlet("/UpdateEmployeeServlet")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class UpdateEmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private UserDAO userDAO;
    private RoleDAO roleDAO;
    
    @Override
    public void init() {
        userDAO = new UserDAO();
        roleDAO = new RoleDAO();
    }
    
    public UpdateEmployeeServlet() {
        super();
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/Views/Login.jsp");
            return;
        }
        
        UserBean loggedInUser = (UserBean) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() == null || 
            !"Admin".equals(loggedInUser.getRole().getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/Views/Login.jsp");
            return;
        }
        
        try {
            // Get form parameters
            String userIdParam = request.getParameter("userId");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String fullName = request.getParameter("fullName");
            String roleParam = request.getParameter("role");
            String status = request.getParameter("status");
            
            int userId = Integer.parseInt(userIdParam);
            
            // Validate passwords if provided
            if (password != null && !password.trim().isEmpty()) {
                if (!password.equals(confirmPassword)) {
                    request.setAttribute("errorMessage", "Passwords do not match!");
                    request.getRequestDispatcher("/Views/Profile.jsp?userId=" + userId).forward(request, response);
                    return;
                }
            }
            
            // Get existing user
            UserBean existingUser = userDAO.getUserById(userId);
            if (existingUser == null) {
                request.setAttribute("errorMessage", "User not found!");
                response.sendRedirect(request.getContextPath() + "/Views/ManageEmployees.jsp");
                return;
            }
            
            // Get role ID
            int roleId = 0;
            if ("Admin".equalsIgnoreCase(roleParam)) {
                roleId = 1;
            } else if ("Cashier".equalsIgnoreCase(roleParam)) {
                roleId = 2;
            } else if ("Inventory Manager".equalsIgnoreCase(roleParam)) {
                roleId = 3;
            } else {
                request.setAttribute("errorMessage", "Invalid role selected! Valid roles are: Admin, Cashier, Inventory Manager");
                request.getRequestDispatcher("/Views/Profile.jsp?userId=" + userId).forward(request, response);
                return;
            }
            
            // Handle image upload
            String imagePath = existingUser.getImage(); // Keep existing image by default
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
                    
                    // Delete old image if it exists
                    if (existingUser.getImage() != null && !existingUser.getImage().trim().isEmpty()) {
                        try {
                            Path oldImagePath = Paths.get(getServletContext().getRealPath("/"), existingUser.getImage());
                            Files.deleteIfExists(oldImagePath);
                        } catch (Exception e) {
                            // Log but don't fail the update if old image deletion fails
                            System.out.println("Could not delete old image: " + e.getMessage());
                        }
                    }
                }
            }
            
            // Update UserBean
            UserBean userToUpdate = new UserBean();
            userToUpdate.setUserId(userId);
            userToUpdate.setUsername(username);
            userToUpdate.setFullName(fullName);
            userToUpdate.setRoleId(roleId);
            userToUpdate.setStatus(status);
            userToUpdate.setImage(imagePath);
            
            // Only update password if provided
            if (password != null && !password.trim().isEmpty()) {
                userToUpdate.setPasswordHash(PasswordUtil.hashPassword(password));
            }
            
            // Update in database
            boolean success = userDAO.updateUser(userToUpdate);
            
            if (success) {
                request.setAttribute("successMessage", "Employee updated successfully!");
                request.getRequestDispatcher("/Views/Profile.jsp?userId=" + userId).forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Failed to update employee. Username might already exist.");
                request.getRequestDispatcher("/Views/Profile.jsp?userId=" + userId).forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while updating the employee: " + e.getMessage());
            String userIdParam = request.getParameter("userId");
            if (userIdParam != null) {
                request.getRequestDispatcher("/Views/Profile.jsp?userId=" + userIdParam).forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/Views/ManageEmployees.jsp");
            }
        }
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
