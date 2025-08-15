<!-- File: addcustomer.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- SweetAlert2 CSS -->
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">

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
      
      <form id="addCustomerForm" action="<%= request.getContextPath() %>/AddCustomerServlet" method="post">
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
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
          </div>
          
          <div class="mb-3">
            <label for="contact" class="form-label">Contact Number</label>
            <input type="tel" class="form-control" id="contact" name="contact" required pattern="[0-9]{10}">
          </div>
          
          <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <textarea class="form-control" id="address" name="address" rows="2" required></textarea>
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

<!-- SweetAlert2 CSS & JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('addCustomerForm').addEventListener('submit', function(e) {
      e.preventDefault();

      const formData = new FormData(this);

      fetch(this.action, {
    	    method: 'POST',
    	    body: formData
    	})
    	.then(response => {
    	    return response.json().then(data => ({ status: response.status, body: data }));
    	})
    	.then(({ status, body }) => {
    	    if (status === 200 && body.status === "success") {
    	        const modal = bootstrap.Modal.getInstance(document.getElementById('addCustomerModal'));
    	        modal.hide();
    	        Swal.fire({
    	            icon: 'success',
    	            title: 'Added!',
    	            text: body.message,
    	            confirmButtonColor: '#DD4A48'
    	        }).then(() => {
    	            location.reload();
    	        });
    	    }
    	    else if (status === 409) {
    	        Swal.fire({
    	            icon: 'warning',
    	            title: 'Duplicate Account Number',
    	            text: body.message,
    	            confirmButtonColor: '#DD4A48'
    	        });
    	    }
    	    else if (status === 400) {
    	        Swal.fire({
    	            icon: 'error',
    	            title: 'Missing Fields',
    	            text: body.message,
    	            confirmButtonColor: '#DD4A48'
    	        });
    	    }
    	    else if (status === 401) {
    	        Swal.fire({
    	            icon: 'error',
    	            title: 'Unauthorized',
    	            text: body.message,
    	            confirmButtonColor: '#DD4A48'
    	        });
    	    }
    	    else {
    	        Swal.fire({
    	            icon: 'error',
    	            title: 'Error!',
    	            text: body.message || 'Something went wrong.',
    	            confirmButtonColor: '#DD4A48'
    	        });
    	    }
    	})
    	.catch(err => {
    	    console.error('Add customer error:', err);
    	    Swal.fire({
    	        icon: 'error',
    	        title: 'Error!',
    	        text: 'Error occurred while adding customer.',
    	        confirmButtonColor: '#DD4A48'
    	    });
    	});

    });

    // Reset form when modal is closed
    document.getElementById('addCustomerModal').addEventListener('hidden.bs.modal', function () {
      document.getElementById('addCustomerForm').reset();
    });
  });
</script>