<!-- File: addcustomer.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.modal-content{
		background-color: #fcc7b6;
	}
	.modal-title{
		color: #DD4A48;
	}
	.modal-footer .btn-1{
		background-color: transparent;
		border: 2px solid #DD4A48;
		color: #DD4A48;
		transition: background-color 0.5s ease;
	}
	.modal-footer .btn-1:hover{
		background-color: #DD4A48;
		color: #ffffff;
	}
	.modal-footer .btn-2{
		background-color: #DD4A48;
		color: #ffffff;
		transition: background-color 0.5s ease;
	}
	.modal-footer .btn-2:hover{
		background-color: transparent;
		border: 2px solid #DD4A48;
		color: #DD4A48;
	}
	.modal-body input.form-control,
	.modal-body textarea.form-control {
		background-color: rgba(255, 255, 255, 0.25); 
		border: none;
	}
	
	
	
</style>

<!-- Add Customer Modal -->
<div class="modal fade" id="addCustomerModal" tabindex="-1" aria-labelledby="addCustomerLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content p-1">
    
      <div class="modal-header">
        <h5 class="modal-title" id="addCustomerLabel">Add New Customer</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <form action="SaveCustomerServlet" method="post">
        <div class="modal-body mt-4">
        
          <div class="mb-3">
            <label for="accountNumber" class="form-label">Account Number</label>
            <input type="text" class="form-control" id="accountNumber" name="accountNumber" required>
          </div>
          
          <div class="row mb-3">
            <div class="col-md-6">
              <label for="firstName" class="form-label">First Name</label>
              <input type="text" class="form-control" id="firstName" name="firstName" required>
            </div>
            <div class="col-md-6">
              <label for="lastName" class="form-label">Last Name</label>
              <input type="text" class="form-control" id="lastName" name="lastName" required>
            </div>
          </div>
          
          <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <textarea class="form-control" id="address" name="address" rows="2" required></textarea>
          </div>
          
          <div class="mb-3">
            <label for="contact" class="form-label">Contact Number</label>
            <input type="tel" class="form-control" id="contact" name="contact" required pattern="[0-9]{10}">
          </div>
          
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-1" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-2">Add Customer</button>
        </div>
      </form>
      
    </div>
  </div>
</div>
