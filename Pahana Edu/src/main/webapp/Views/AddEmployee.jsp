<!-- File: addemployee.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.myapp.dao.RoleDAO" %>
<%@ page import="com.myapp.model.RoleBean" %>

<%
    // Load roles for the dropdown
    RoleDAO roleDAO = new RoleDAO();
    List<RoleBean> roles = roleDAO.getAllRoles();
    request.setAttribute("roles", roles);
%>

<style>
  .modal-content {
    background-color: #fcc7b6;
  }
  .modal-title {
    color: #DD4A48;
  }
  .modal-footer .btn-1 {
    background-color: transparent;
    border: 2px solid #DD4A48;
    color: #DD4A48;
    transition: background-color 0.5s ease;
  }
  .modal-footer .btn-1:hover {
    background-color: #DD4A48;
    color: #ffffff;
  }
  .modal-footer .btn-2 {
    background-color: #DD4A48;
    color: #ffffff;
    transition: background-color 0.5s ease;
  }
  .modal-footer .btn-2:hover {
    background-color: transparent;
    border: 2px solid #DD4A48;
    color: #DD4A48;
  }
  .modal-body input.form-control,
  .modal-body select.form-control {
    background-color: rgba(255, 255, 255, 0.25); 
    border: none;
  }
</style>

<!-- Add Employee Modal -->
<div class="modal fade" id="addEmployeeModal" tabindex="-1" aria-labelledby="addEmployeeLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content p-1">

      <div class="modal-header">
        <h5 class="modal-title" id="addEmployeeLabel">Add New Employee</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- Updated form to use AJAX submission -->
      <form id="addEmployeeForm" method="post" action="#" onsubmit="handleAddEmployee(event); return false;">
        <div class="modal-body mt-4">

          <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" required>
          </div>

          <div class="mb-3">
            <label for="fullName" class="form-label">Full Name</label>
            <input type="text" class="form-control" id="fullName" name="fullName" required>
          </div>

          <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
          </div>

          <div class="mb-3">
            <label for="confirmPassword" class="form-label">Confirm Password</label>
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
          </div>

          <div class="mb-3">
            <label for="roleId" class="form-label">Role</label>
            <select class="form-control" id="roleId" name="roleId" required>
                <option value="">-- Select Role --</option>
                <c:forEach var="role" items="${roles}">
                    <option value="${role.roleId}">${role.roleName}</option>
                </c:forEach>
            </select>
          </div>

        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-1" data-bs-dismiss="modal">Cancel</button>
          <button type="button" class="btn btn-2" id="addEmployeeBtn" onclick="handleAddEmployee(event)">Add Employee</button>
        </div>
      </form>

    </div>
  </div>
</div>