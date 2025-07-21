<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Directive Tags -->
<%@ include file="Sidebar.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Customer Management</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

  <style>
    body {
      min-height: 100vh;
	  background-color: #F5EEDC;
    }
	.content {
	  padding: 2rem;
	}
	.welcome-box {
	  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.25); 
	}
	.table-wrapper {
	  border-radius: 15px;
	  overflow: hidden;
	  margin-top: 60px;
	  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.25);
	}
    .table thead th {
      background-color: #8d97d2;
      color: #ffffff;
      
    }
    .table tbody tr:nth-child(odd) {
	  background-color: #f2c1bf; 
	}
	
	.table tbody tr:nth-child(even) {
	  background-color: #f9d7d6;
	}
	.table tbody tr:hover {
	  background-color: #f8b1ae;
	}
	
	.table td, .table th {
	  vertical-align: middle;
	  padding: 15px 8px;
	}
	
	.action-buttons span {
	  display: inline-flex;
	  align-items: center;
	  justify-content: center;
	  border-radius: 50%;
	  width: 36px;
	  height: 36px;
	  margin: 0 5px;
	  transition: background-color 0.3s ease;
	  cursor: pointer;
	}
	
	.action-buttons .view-icon {
	  background-color: #e1ecff; 
	}
	
	.action-buttons .view-icon:hover {
	  background-color: #c1d8ff;
	}
	
	.action-buttons .edit-icon {
	  background-color: #d1f5e8; 
	}
	
	.action-buttons .edit-icon:hover {
	  background-color: #aeeed7;
	}
	
	.action-buttons i {
	  font-size: 1rem;
	  color: inherit;
	}
    .card {
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
    }
    
    
  </style>
</head>

<body>

<div class="container-fluid">
  <div class="row">
    

	    <!-- Main Content -->
	    <main class="content" style="margin-left: 90px; width: calc(100% - 90px);">

	      <div class="d-flex flex-column pb-2 mb-3">

	        <!-- Include Admin Header -->
	        <jsp:include page="AdminHeader.jsp" />

	        <!-- Welcome Message -->
	        <div class="ps-3 rounded-3 welcome-box" style="background-color: rgba(249, 155, 125, 0.7); margin-top: 100px;">
			  <div class="row align-items-center">
			    <div class="col-md-6 mb-3 mb-md-0">
			      <h1 class="h2">Manage Customers</h1>
			      <p class="text-muted">
			        Here’s a quick overview of your system performance and recent activity.<br>
			        Use the sidebar to manage customers, items, and billing efficiently.
			      </p>
			      <div class="d-flex align-items-right">
			        <button class="btn btn-danger me-3" id="openAddCustomerBtn">Add Customers</button>
			      </div>
			    </div>
			    <div class="col-md-6 text-end" style="margin-top: -150px;">
			      <img src="<%= request.getContextPath() %>/Images/dashboardimg.png" class="rounded-circle img-fluid" alt="hero image" style="max-width: 75%; height: auto;">
			    </div>
			  </div>
			</div>
	      </div>
	      
          <div class="table-responsive table-wrapper">
            <table class="table table-striped mb-0">
              <thead>
                <tr>
                  <th>Account No</th>
                  <th>Name</th>
                  <th>Address</th>
                  <th>Contact</th>
                  <th>Units Consumed</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <!-- Sample rows -->
                <tr>
                  <td>1001</td>
                  <td>John Doe</td>
                  <td>123 Main Street, Colombo</td>
                  <td>0771234567</td>
                  <td>240</td>
                  <td class="action-buttons">
				      <span class="view-icon"
					      data-account="<%=1001%>" 
					      data-name="John Doe" 
					      data-address="123 Main Street, Colombo" 
					      data-contact="0771234567" 
					      data-units="240">
					   <i class="bi bi-eye-fill text-primary" title="View"></i>
					 </span>
				     <span class="edit-icon"
					      data-account="<%=1001%>"
					      data-name="John Doe"
					      data-address="123 Main Street, Colombo"
					      data-contact="0771234567"
					      data-units="240">
					  <i class="bi bi-pencil-fill text-success" title="Edit"></i>
					</span>

				  </td>
                </tr>
                <tr>
                  <td>1002</td>
                  <td>Jane Smith</td>
                  <td>456 Queen's Road, Kandy</td>
                  <td>0719876543</td>
                  <td>310</td>
                  <td class="action-buttons">
				      <span class="view-icon"
					      data-account="<%=1002%>" 
					      data-name="Jane Smith" 
					      data-address="456 Queen's Road, Kandy" 
					      data-contact="0719876543" 
					      data-units="310">
					   <i class="bi bi-eye-fill text-primary" title="View"></i>
					 </span>
				     <span class="edit-icon"
					      data-account="<%=1002%>"
					      data-name="Jane Smith"
					      data-address="456 Queen's Road, Kandy"
					      data-contact="0719876543"
					      data-units="310">
					  <i class="bi bi-pencil-fill text-success" title="Edit"></i>
					</span>

				  </td>
                </tr>
                <!-- Add dynamic rows here using scriptlet/JSTL if data is fetched from DB -->
              </tbody>
            </table>
          </div>
           </main>
        </div>
      </div>
      
<!-- Placeholder for modal -->
<div id="addCustomerModalContainer"></div>

<!-- Bootstrap JS (Optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  document.getElementById('openAddCustomerBtn').addEventListener('click', function () {
    // Load modal content from addcustomer.jsp
    fetch('<%= request.getContextPath() %>/Views/AddCustomer.jsp')
      .then(response => response.text())
      .then(html => {
        document.getElementById('addCustomerModalContainer').innerHTML = html;

        // Show modal
        const modal = new bootstrap.Modal(document.getElementById('addCustomerModal'));
        modal.show();
      })
      .catch(err => console.error('Failed to load modal:', err));
  });
  
  
  //View details popup
  document.querySelectorAll('.view-icon').forEach(function(icon) {
    icon.addEventListener('click', function () {
      const params = new URLSearchParams({
        accountNo: this.dataset.account,
        name: this.dataset.name,
        address: this.dataset.address,
        contact: this.dataset.contact,
        units: this.dataset.units
      });

      fetch('<%= request.getContextPath() %>/Views/DisplayCustomerDetails.jsp?' + params.toString())
        .then(response => response.text())
        .then(html => {
          const modalContainer = document.getElementById('addCustomerModalContainer');
          modalContainer.innerHTML = html;

          const modal = new bootstrap.Modal(document.getElementById('customerDetailsModal'));
          modal.show();
        })
        .catch(err => console.error('Failed to load customer details:', err));
    });
  });
  
  
	//Edit details popup
	document.querySelectorAll('.edit-icon').forEach(function(icon) {
  icon.addEventListener('click', function () {
    const params = new URLSearchParams({
      accountNo: this.dataset.account,
      name: this.dataset.name,
      address: this.dataset.address,
      contact: this.dataset.contact,
      units: this.dataset.units
    });

    fetch('<%= request.getContextPath() %>/Views/UpdateCustomerDetails.jsp?' + params.toString())
      .then(response => response.text())
      .then(html => {
        const modalContainer = document.getElementById('addCustomerModalContainer');
        modalContainer.innerHTML = html;

        const modal = new bootstrap.Modal(document.getElementById('updateCustomerModal'));
        modal.show();
      })
      .catch(err => console.error('Failed to load update modal:', err));
  });
});
</script>


</body>
</html>
