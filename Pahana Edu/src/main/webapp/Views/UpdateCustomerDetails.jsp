<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.modal-body input.form-control,
	.modal-body textarea.form-control {
		background-color: rgba(255, 255, 255, 0.55); 
		border: none;
	}
	.modal-footer .btn-1:hover{
		background-color: #d1f5e8;
		color: #198754;
	}
</style>


<%
    String accountNo = request.getParameter("accountNo");
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String contact = request.getParameter("contact");
    String email = request.getParameter("email");
%>

<!-- Update Customer Modal -->
<div class="modal fade" id="updateCustomerModal" tabindex="-1" aria-labelledby="updateCustomerModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content" style="background-color: #d1f5e8;">
      <div class="modal-header">
        <h5 class="modal-title text-success" id="updateCustomerModalLabel">Update Customer Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <form id="updateCustomerForm">
        <div class="modal-body px-4">
          <div class="mb-3">
            <label for="accountNo" class="form-label">Account Number</label>
            <input type="text" class="form-control" id="accountNo" name="accountNo" value="<%= accountNo %>" readonly>
          </div>
          <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="name" name="name" value="<%= name %>" required>
          </div>
          <div class="mb-3">
            <label for="contact" class="form-label">Contact</label>
            <input type="text" class="form-control" id="contact" name="contact" value="<%= contact %>" required>
          </div>
          <div class="mb-3">
            <label for="email" class="form-label">Email Address</label>
            <input type="email" class="form-control" id="email" name="email" value="<%= email %>" required>
          </div>
          <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <textarea class="form-control" id="address" name="address" rows="2" required><%= address %></textarea>
          </div>
        </div>
        <div class="modal-footer px-4">
          <button type="button" class="btn btn-outline-success" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-1 btn-success">Save Changes</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Optional JS for handling form submission (can be moved to main page if needed) -->
<script>
  document.getElementById('updateCustomerForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const formData = new FormData(this);

    // Example: send updated data to servlet (replace URL accordingly)
    fetch('<%= request.getContextPath() %>/UpdateCustomerServlet', {
      method: 'POST',
      body: formData
    })
    .then(res => {
      if (res.ok) {
        alert('Customer updated successfully!');
        location.reload(); // reload ManageCustomers.jsp
      } else {
        alert('Failed to update customer.');
      }
    })
    .catch(err => console.error('Update error:', err));
  });
</script>