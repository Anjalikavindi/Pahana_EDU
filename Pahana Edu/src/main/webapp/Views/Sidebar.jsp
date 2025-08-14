<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myapp.model.UserBean" %>
<%
    UserBean currentUser = (UserBean) session.getAttribute("loggedInUser");
    String userRole = (currentUser != null && currentUser.getRole() != null) ? currentUser.getRole().getRoleName() : "";
%>

<style>
  .sidebar {
    position: fixed;
    top: 50%;
    left: 10px;
    transform: translateY(-50%);
    width: 80px;
    height: 85vh;
    background-color: #97BFB4;
    border-radius: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0.8rem;
    z-index: 1000;
  }

  .sidebar ul {
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center; /* vertical centering */
    align-items: center;
    padding-left: 0;
    margin-bottom: 0;
  }

  .sidebar .nav-link {
    color: #404040;
    font-size: 1.2rem;
    margin: 1rem 0;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 0.8rem;
    width: 100%;
    transition: background-color 0.5s ease;
  }

  .sidebar .nav-link:hover {
    background-color: rgba(221, 74, 72, 0.4);
    border-radius: 15px;
    color: #ffffff;
  }

  .sidebar .nav-link.active {
    background-color: #DD4A48;
    border-radius: 15px;
    color: #ffffff;
  }
</style>

<!-- Sidebar -->
<nav class="sidebar">
  <ul class="nav flex-column text-center w-100">
    <!-- Dashboard - Available to all roles -->
    <li class="nav-item">
      <a class="nav-link <%= request.getRequestURI().contains("Dashboard.jsp") ? "active" : "" %>" href="<%= request.getContextPath() %>/Views/Dashboard.jsp">
        <i class="bi bi-house-door-fill"></i>
      </a>
    </li>
    
    <!-- Bill - Available to Admin and Cashier -->
    <% if ("Admin".equals(userRole) || "Cashier".equals(userRole)) { %>
    <li class="nav-item">
      <a class="nav-link <%= request.getRequestURI().contains("Bill.jsp") ? "active" : "" %>" href="<%= request.getContextPath() %>/Views/Bill.jsp">
        <i class="bi bi-calculator-fill"></i>
      </a>
    </li>
    <% } %>
    
    <!-- Manage Customers - Available to Admin and Cashier -->
    <% if ("Admin".equals(userRole) || "Cashier".equals(userRole)) { %>
    <li class="nav-item">
      <a class="nav-link <%= request.getRequestURI().contains("ManageCustomers.jsp") ? "active" : "" %>" href="<%= request.getContextPath() %>/Views/ManageCustomers.jsp">
        <i class="bi bi-person-fill-gear"></i>
      </a>
    </li>
    <% } %>
    
    <!-- Manage Items - Available to Admin and Inventory Manager -->
    <% if ("Admin".equals(userRole) || "Inventory Manager".equals(userRole)) { %>
    <li class="nav-item">
      <a class="nav-link <%= request.getRequestURI().contains("ManageItems.jsp") ? "active" : "" %>" href="<%= request.getContextPath() %>/Views/ManageItems.jsp">
        <i class="bi bi-file-earmark-plus-fill"></i>
      </a>
    </li>
    <% } %>
    
    <!-- User Management (formerly Manage Employees) - Available to Admin only -->
    <% if ("Admin".equals(userRole)) { %>
    <li class="nav-item">
      <a class="nav-link <%= request.getRequestURI().contains("ManageEmployees.jsp") ? "active" : "" %>" href="<%= request.getContextPath() %>/Views/ManageEmployees.jsp">
        <i class="bi bi-people-fill"></i>
      </a>
    </li>
    <% } %>
    
    <!-- Help - Available to all roles -->
    <li class="nav-item">
      <a class="nav-link <%= request.getRequestURI().contains("Help.jsp") ? "active" : "" %>" href="<%= request.getContextPath() %>/Views/Help.jsp">
        <i class="bi bi-info-circle-fill"></i>
      </a>
    </li>
  </ul>
</nav>