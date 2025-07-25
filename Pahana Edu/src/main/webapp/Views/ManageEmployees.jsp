<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="Sidebar.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Employee Management</title>

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
    padding: 15px 15px;
  }

  .toggle-switch {
    position: relative;
    display: inline-block;
    width: 45px;
    height: 21px;
  }
  .toggle-switch input {
    opacity: 0;
    width: 0;
    height: 0;
  }
  .toggle-slider {
    position: absolute;
    cursor: pointer;
    top: 0; left: 0; right: 0; bottom: 0;
    background-color: #ccc;
    transition: .4s;
    border-radius: 34px;
  }
  .toggle-slider:before {
    position: absolute;
    content: "";
    height: 15px;
    width: 15px;
    left: 3px;
    bottom: 3px;
    background-color: white;
    transition: .4s;
    border-radius: 50%;
  }

  /* Active Toggle - Success Green */
  .toggle-switch input:checked + .toggle-slider {
    background-color: #28a745;
    
  }
  .toggle-switch input:checked + .toggle-slider:before {
    transform: translateX(24px);
  }

  /* Inactive Toggle - Danger Red */
  .toggle-switch input:not(:checked) + .toggle-slider {
    background-color: #dc3545;
    
  }

  .emp-img {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    object-fit: cover;
  }
</style>

</head>

<body>
<div class="container-fluid">
  <div class="row">
    <main class="content" style="margin-left: 90px; width: calc(100% - 90px);">
      <div class="d-flex flex-column pb-2 mb-3">
        <jsp:include page="AdminHeader.jsp" />

        <!-- Welcome Message -->
        <div class="ps-3 rounded-3 welcome-box" style="background-color: rgba(249, 155, 125, 0.7); margin-top: 100px;">
          <div class="row align-items-center">
            <div class="col-md-6 mb-3 mb-md-0">
              <h1 class="h2">Manage Employees</h1>
              <p class="text-muted">
                Here’s a quick overview of your system performance and recent activity.<br>
			    Use the sidebar to manage customers, items, and billing efficiently.
              </p>
              <button class="btn btn-danger me-3" id="openAddEmployeeBtn">Add Employee</button>
            </div>
            <div class="col-md-6 text-end" style="margin-top: -150px;">
              <img src="<%= request.getContextPath() %>/Images/dashboardimg.png" class="rounded-circle img-fluid" alt="hero image" style="max-width: 75%; height: auto;">
            </div>
          </div>
        </div>
      </div>
      

	  <!-- Search Bar to filter employees by Username -->
		<div class="row mt-5 mb-5 justify-content-end">
		  <div class="col-md-3">
		    <div class="input-group">
		      <span class="input-group-text border-end-0 bg-danger">
		        <i class="bi bi-search text-white"></i>
		      </span>
		      <input
		        type="text"
		        id="searchUsernameInput"
		        class="form-control border-start-0"
		        placeholder="Search by Username"
		        aria-label="Search"
		        onkeyup="filterEmployeesByUsername()"
		      />
		    </div>
		  </div>
		</div>

	  

      <!-- Employee Table -->
      <div class="table-responsive table-wrapper mt-4">
        <table class="table table-striped mb-0">
          <thead>
            <tr>
              <th>ID</th>
              <th>Image</th>
              <th>Username</th>
              <th>Role</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <!-- Sample Static Rows - Replace with dynamic content -->
            <tr>
              <td>EMP001</td>
              <td>
			      <%
			        String emp1Img = ""; // Example: image exists
			        if (emp1Img != null && !emp1Img.trim().isEmpty()) {
			      %>
			        <img src="<%= request.getContextPath() %>/<%= emp1Img %>" class="emp-img" alt="emp1">
			      <%
			        } else {
			      %>
			        <i class="bi bi-person-circle fs-2 text-secondary"></i>
			      <%
			        }
			      %>
			  </td>
              <td>johndoe</td>
              <td>Admin</td>
              <td>
                <label class="toggle-switch">
                  <input type="checkbox" checked onchange="toggleStatus('EMP001')">
                  <span class="toggle-slider"></span>
                </label>
              </td>
            </tr>
            <tr>
              <td>EMP002</td>
              <td>
			      <%
			        String emp2Img = ""; // Simulate no image
			        if (emp2Img != null && !emp2Img.trim().isEmpty()) {
			      %>
			        <img src="<%= request.getContextPath() %>/<%= emp2Img %>" class="emp-img" alt="emp2">
			      <%
			        } else {
			      %>
			        <i class="bi bi-person-circle fs-2 text-secondary"></i>
			      <%
			        }
			      %>
			  </td>
              <td>janesmith</td>
              <td>Staff</td>
              <td>
                <label class="toggle-switch">
                  <input type="checkbox" onchange="toggleStatus('EMP002')">
                  <span class="toggle-slider"></span>
                </label>
              </td>
            </tr>
            <!-- More dynamic rows here -->
          </tbody>
        </table>
      </div>
    </main>
  </div>
</div>

<!-- Placeholder for Add Employee Modal -->
<div id="addEmployeeModalContainer"></div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  document.getElementById('openAddEmployeeBtn').addEventListener('click', function () {
    fetch('<%= request.getContextPath() %>/Views/AddEmployee.jsp')
      .then(response => response.text())
      .then(html => {
        document.getElementById('addEmployeeModalContainer').innerHTML = html;
        const modal = new bootstrap.Modal(document.getElementById('addEmployeeModal'));
        modal.show();
      })
      .catch(err => console.error('Failed to load modal:', err));
  });

  function toggleStatus(empId) {
    const isActive = event.target.checked;
    console.log(`Toggled employee ${empId} to ${isActive ? 'Active' : 'Inactive'}`);
    // TODO: Add AJAX request to update status in DB
  }
  
  
  
  //Search employee function
  function filterEmployeesByUsername() {
  const input = document.getElementById('searchUsernameInput').value.toLowerCase();
  const tableRows = document.querySelectorAll('.table tbody tr');

  tableRows.forEach(row => {
    const username = row.cells[2]?.textContent.toLowerCase(); // Adjust index if needed
    row.style.display = username.includes(input) ? '' : 'none';
  });
	}

</script>
</body>
</html>
