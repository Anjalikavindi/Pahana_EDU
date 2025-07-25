<!-- File: addemployee.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

      <!-- Add enctype for file upload -->
      <form action="SaveEmployeeServlet" method="post" enctype="multipart/form-data">
        <div class="modal-body mt-4">

          <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" required>
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
            <label for="role" class="form-label">Role</label>
            <select class="form-control" id="role" name="role" required>
              <option value="">-- Select Role --</option>
              <option value="admin">Admin</option>
              <option value="staff">Staff</option>
              <option value="manager">Manager</option>
            </select>
          </div>

          <!-- Image Upload Field -->
          <div class="mb-3">
            <label for="employeeImage" class="form-label">Employee Image</label>
            <input type="file" class="form-control" id="employeeImage" name="employeeImage" accept="image/*">
          </div>

        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-1" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-2">Add Employee</button>
        </div>
      </form>

    </div>
  </div>
</div>
