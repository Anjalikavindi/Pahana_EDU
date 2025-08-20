<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.myapp.model.UserBean" %>
<%@ include file="Sidebar.jsp" %>

<%
    // Use the implicit 'session' object directly
    UserBean user = null;
    String errorMessage = null;
    if (session != null) {
        user = (UserBean) session.getAttribute("loggedInUser");
    }
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Views/Login.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Profile</title>
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { 
        background-color: #F5EEDC; 
        min-height: 100vh; 
        }
        .content { 
        padding: 2rem; margin-left: 90px; 
        width: calc(100% - 90px); 
        }
        
        .profile-card {
        max-width: 600px; 
        margin: 2rem auto;
	  	background-color: rgba(192, 216, 192, 0.5);
	  	padding: 2rem;
	  	border-radius: 20px;
	  	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
		}
		.profile-card h2 {
      	text-align: center;
      	font-weight: bold;
      	margin-bottom: 1.5rem;
    	}

    	.profile-card .form-control {
    	background-color: #ffffff;
		opacity: .4;
      	border: none;
      	border-radius: 40px;
      	box-shadow: none;
      	font-size: 1rem;
    	}

	    .profile-card .form-control:focus {
	      border-color: #00A686;
	      box-shadow: none;
	    }

	    .profile-card .btn1 {
	      background-color: #DD4A48;
	      border: none;
	      width: 100%;
	      padding: 0.5rem;
	      font-weight: bold;
	      color: #ffffff;
	      border-radius: 30px;
	      transition: background-color 0.3s ease;
	    }

	    .profile-card .btn1:hover {
	      background-color: #00B3A6;
	    }

	    .profile-card .form-label {
	      font-weight: 500;
	      font-size: 0.85rem;
	      color: #33333;
	    }
	    .profile-card .form-input {
	      font-weight: 900;
	      color: #33333;
	    }
    </style>
</head>
<body>
	<div class="container-fluid">
    <div class="content">
        <jsp:include page="Header.jsp" />

        <div class="profile-card">
            <h2 class="mb-4">My Profile</h2>

            <% if (errorMessage != null) { %>
                <div class="alert alert-danger"><%= errorMessage %></div>
            <% } %>

            <form action="<%= request.getContextPath() %>/UpdateEmployeeServlet" method="post">
                <!-- Hidden field for user ID -->
                <input type="hidden" name="userId" value="<%= user.getUserId() %>">

                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" 
                           value="<%= user.getUsername() %>" required>
                </div>

                <div class="mb-3">
                    <label for="fullName" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" 
                           value="<%= user.getFullName() != null ? user.getFullName() : "" %>" required>
                </div>

                <div class="mb-3">
                    <label for="role" class="form-label">Role</label>
                    <input type="text" class="form-control" id="role" name="role" 
                           value="<%= user.getRole() != null ? user.getRole().getRoleName() : "Unknown" %>" readonly>
                </div>

                <div class="mb-5">
                    <label for="status" class="form-label">Status</label>
                    <input type="text" class="form-control" id="status" name="status" 
                           value="<%= user.getStatus() != null ? user.getStatus() : "Unknown" %>" readonly>
                </div>

                <button type="submit" class="btn1">Update Profile</button>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>