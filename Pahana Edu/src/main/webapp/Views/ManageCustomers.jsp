<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Directive Tags -->
<%@ page import="java.util.List" %>
<%@ page import="com.myapp.dao.CustomerDAO" %>
<%@ page import="com.myapp.model.CustomerBean" %>
<!-- Directive Tags -->
<%@ include file="Sidebar.jsp" %>

<%
    // Fetch all customers from database
    CustomerDAO customerDAO = new CustomerDAO();
    List<CustomerBean> customers = null;
    String errorMessage = null;
    
    try {
        customers = customerDAO.getAllCustomers();
    } catch (Exception e) {
        errorMessage = "Error loading customers: " + e.getMessage();
        e.printStackTrace();
    }
%>

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
	  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.25);
	}
    .table thead th {
      background-color: #DD4A48;
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
	        <jsp:include page="Header.jsp" />

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
	      
	      
	      <!-- Error Message Display -->
	      <% if (errorMessage != null) { %>
	        <div class="alert alert-danger alert-dismissible fade show" role="alert">
	          <i class="bi bi-exclamation-triangle-fill me-2"></i>
	          <%= errorMessage %>
	          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	        </div>
	      <% } %>
	      
	      <!-- Search Bar to filter customers by Account Number -->
			<div class="row mt-5 mb-5 justify-content-end">
			  <div class="col-md-3">
			    <div class="input-group">
			      <span class="input-group-text border-end-0 bg-danger">
			        <i class="bi bi-search text-white"></i>
			      </span>
			      <input
			        type="text"
			        id="searchAccountInput"
			        class="form-control border-start-0"
			        placeholder="Search by Account Number"
			        aria-label="Search"
			      />
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
                  <th>Remaining Units</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <%
                  if (customers != null && !customers.isEmpty()) {
                    for (CustomerBean customer : customers) {
                      String fullName = customer.getFirstName() + " " + customer.getLastName();
                %>
                <tr>
                  <td><%= customer.getAccountNumber() %></td>
                  <td><%= fullName %></td>
                  <td><%= customer.getAddress() != null ? customer.getAddress() : "N/A" %></td>
                  <td><%= customer.getContactNumber() != null ? customer.getContactNumber() : "N/A" %></td>
                  <td><%= customer.getRemainingUnits() %></td>
                  <td class="action-buttons">
				      <span class="view-icon"
					      data-account="<%= customer.getAccountNumber() %>" 
					      data-name="<%= fullName %>" 
					      data-address="<%= customer.getAddress() != null ? customer.getAddress() : "N/A" %>" 
					      data-contact="<%= customer.getContactNumber() != null ? customer.getContactNumber() : "N/A" %>" 
					      data-units="<%= customer.getRemainingUnits() %>"
					      data-email="<%= customer.getEmail() != null ? customer.getEmail() : "N/A" %>">
					   <i class="bi bi-eye-fill text-primary" title="View"></i>
					 </span>
				     <span class="edit-icon"
					      data-account="<%= customer.getAccountNumber() %>"
					      data-name="<%= fullName %>"
					      data-address="<%= customer.getAddress() != null ? customer.getAddress() : "N/A" %>"
					      data-contact="<%= customer.getContactNumber() != null ? customer.getContactNumber() : "N/A" %>"
					      data-units="<%= customer.getRemainingUnits() %>"
					      data-email="<%= customer.getEmail() != null ? customer.getEmail() : "N/A" %>">
					  <i class="bi bi-pencil-fill text-success" title="Edit"></i>
					</span>
					<span class="delete-icon"
					      data-account="<%= customer.getAccountNumber() %>"
					      data-name="<%= fullName %>">
					  <i class="bi bi-trash-fill text-danger" title="Delete"></i>
					</span>
				  </td>
                </tr>
                <%
                    }
                  } else {
                %>
                <tr>
                  <td colspan="6" class="text-center text-muted">
                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                    No customers found. <a href="#" id="addFirstCustomerBtn">Add your first customer</a>
                  </td>
                </tr>
                <%
                  }
                %>
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
  // Function to open add customer modal
  function openAddCustomerModal() {
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
  }

  // Event listener for main "Add Customers" button
  document.getElementById('openAddCustomerBtn').addEventListener('click', openAddCustomerModal);
  
  // Event listener for "Add your first customer" link (if it exists)
  document.addEventListener('click', function(e) {
    if (e.target && e.target.id === 'addFirstCustomerBtn') {
      e.preventDefault();
      openAddCustomerModal();
    }
  });
  
  
  //Search customers
  document.getElementById('searchAccountInput').addEventListener('input', function () {
    const searchTerm = this.value.trim().toLowerCase();
    const rows = document.querySelectorAll('.table tbody tr');

    rows.forEach(row => {
      const accountCell = row.querySelector('td');
      if (accountCell) {
        const accountNo = accountCell.textContent.trim().toLowerCase();
        row.style.display = accountNo.includes(searchTerm) ? '' : 'none';
      }
    });
  });
  
  
  //View details popup
  document.querySelectorAll('.view-icon').forEach(function(icon) {
    icon.addEventListener('click', function () {
      const params = new URLSearchParams({
        accountNo: this.dataset.account,
        name: this.dataset.name,
        address: this.dataset.address,
        contact: this.dataset.contact,
        units: this.dataset.units,
        email: this.dataset.email
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
      units: this.dataset.units,
      email: this.dataset.email
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

  //Delete customer functionality
  document.querySelectorAll('.delete-icon').forEach(function(icon) {
    icon.addEventListener('click', function () {
      const accountNumber = this.dataset.account;
      const customerName = this.dataset.name;
      
      console.log('Delete clicked for account:', accountNumber); // Debug log
      console.log('Account number type:', typeof accountNumber); // Debug log
      console.log('Account number length:', accountNumber ? accountNumber.length : 'null/undefined'); // Debug log
      console.log('All dataset attributes:', this.dataset); // Debug log
      
      if (confirm('Are you sure you want to delete customer "' + customerName + '" (Account: ' + accountNumber + ')? This action cannot be undone.')) {
        const formData = new FormData();
        formData.append('accountNumber', accountNumber);
        
        console.log('FormData contents:'); // Debug log
        for (let [key, value] of formData.entries()) {
          console.log(key, ':', value); // Debug log
        }
        
        fetch('<%= request.getContextPath() %>/DeleteCustomerServlet', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: 'accountNumber=' + encodeURIComponent(accountNumber)
        })
        .then(response => {
          console.log('Delete response status:', response.status); // Debug log
          if (response.ok) {
            alert('Customer deleted successfully!');
            location.reload(); // Reload the page to refresh the customer list
          } else {
            return response.text().then(text => {
              alert('Failed to delete customer: ' + text);
            });
          }
        })
        .catch(err => {
          console.error('Delete error:', err);
          alert('Error occurred while deleting customer.');
        });
      }
    });
  });
</script>


</body>
</html>
