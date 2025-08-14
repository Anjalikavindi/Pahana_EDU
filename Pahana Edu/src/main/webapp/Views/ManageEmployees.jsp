<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.myapp.dao.UserDAO" %>
<%@ page import="com.myapp.model.UserBean" %>
<%@ include file="Sidebar.jsp" %>

<%
    // Fetch all users from database with error handling
    List<UserBean> users = new ArrayList<>();
    String errorMessage = null;
    try {
        UserDAO userDAO = new UserDAO();
        users = userDAO.getAllUsers();
        if (users == null) {
            users = new ArrayList<>();
        }
    } catch (Exception e) {
        errorMessage = "Error loading users: " + e.getMessage();
        e.printStackTrace();
        users = new ArrayList<>();
    }
%>

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
        <jsp:include page="Header.jsp" />

        <!-- Welcome Message -->
        <div class="ps-3 rounded-3 welcome-box" style="background-color: rgba(249, 155, 125, 0.7); margin-top: 100px;">
          <div class="row align-items-center">
            <div class="col-md-6 mb-3 mb-md-0">
              <h1 class="h2">Manage Employees</h1>
              <p class="text-muted">
                Here's a quick overview of your system performance and recent activity.<br>
			    Use the sidebar to manage customers, items, and billing efficiently.
              </p>
              <button class="btn btn-danger me-3" id="openAddEmployeeBtn">Add Employee</button>
            </div>
            <div class="col-md-6 text-end" style="margin-top: -150px;">
              <img src="<%= request.getContextPath() %>/Images/dashboardimg.png" class="rounded-circle img-fluid" alt="hero image" style="max-width: 75%; height: auto;">
            </div>
          </div>
        </div>
        
        <!-- Error Message Display -->
        <% if (errorMessage != null) { %>
        <div class="alert alert-danger mt-3" role="alert">
          <i class="bi bi-exclamation-triangle"></i> <%= errorMessage %>
        </div>
        <% } %>
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
              <th>Full Name</th>
              <th>Role</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <%
              if (users != null && !users.isEmpty()) {
                for (UserBean user : users) {
                  // Debug logging for user data
                  System.out.println("JSP Debug - User ID: " + user.getUserId() + ", Username: " + user.getUsername());
            %>
            <tr>
              <td><%= user.getUserId() %></td>
              <td>
                <%
                  String userImg = user.getImage();
                  if (userImg != null && !userImg.trim().isEmpty()) {
                %>
                  <img src="<%= request.getContextPath() %>/<%= userImg %>" class="emp-img" alt="<%= user.getUsername() %>">
                <%
                  } else {
                %>
                  <i class="bi bi-person-circle fs-2 text-secondary"></i>
                <%
                  }
                %>
              </td>
              <td><%= user.getUsername() %></td>
              <td><%= user.getFullName() != null ? user.getFullName() : "N/A" %></td>
              <td><%= user.getRole() != null ? user.getRole().getRoleName() : "Unknown" %></td>
              <td>
                <label class="toggle-switch">
                  <input type="checkbox" <%= "active".equalsIgnoreCase(user.getStatus()) ? "checked" : "" %> 
                         onchange="toggleStatus('<%= user.getUserId() %>')">
                  <span class="toggle-slider"></span>
                </label>
              </td>
              <td>
                <!-- Action buttons (Edit, Delete) -->
                <div class="btn-group" role="group">
                  <button type="button" class="btn btn-sm btn-primary" onclick="editUser('<%= user.getUserId() %>')">
                    <i class="bi bi-pencil"></i> Edit
                  </button>
                  <button type="button" class="btn btn-sm btn-danger" onclick="deleteUser('<%= user.getUserId() %>')" data-user-id="<%= user.getUserId() %>">
                    <i class="bi bi-trash"></i> Delete
                  </button>
                </div>
              </td>
            </tr>
            <%
                }
              } else {
            %>
            <tr>
              <td colspan="7" class="text-center text-muted">No users found</td>
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

<!-- Placeholder for Add Employee Modal -->
<div id="addEmployeeModalContainer"></div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Debug: Check user IDs when page loads
  document.addEventListener('DOMContentLoaded', function() {
    console.log('Page loaded, checking user IDs in table...');
    const deleteButtons = document.querySelectorAll('button[data-user-id]');
    console.log('Found', deleteButtons.length, 'delete buttons');
    deleteButtons.forEach((btn, index) => {
      const userId = btn.getAttribute('data-user-id');
      console.log('Delete button ' + (index + 1) + ': userId = \'' + userId + '\' (type: ' + typeof userId + ')');
    });
  });
  
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

  // Add the handleAddEmployee function globally so it's accessible when modal is loaded
  function handleAddEmployee(event) {
    if (event) event.preventDefault();
    
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    
    // Validate passwords
    if (password !== confirmPassword) {
        alert('Passwords do not match!');
        return false;
    }
    
    if (password.length < 6) {
        alert('Password must be at least 6 characters long!');
        return false;
    }
    
    // Disable submit button to prevent double submission
    const submitBtn = document.getElementById('addEmployeeBtn');
    submitBtn.disabled = true;
    submitBtn.textContent = 'Adding...';
    
    // Send AJAX request to SaveEmployeeServlet instead
    fetch('<%= request.getContextPath() %>/SaveEmployeeServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest',
        },
        body: 'username=' + document.getElementById('username').value +
        '&fullName=' + document.getElementById('fullName').value +
        '&password=' + password +
        '&confirmPassword=' + password +
        '&role=' + document.getElementById('roleId').options[document.getElementById('roleId').selectedIndex].text
    })
    .then(response => {
        console.log('Response status:', response.status);
        console.log('Response headers:', response.headers);
        
        if (!response.ok) {
            throw new Error('HTTP error! status: ' + response.status);
        }
        
        return response.text(); // Get as text first to see what we're receiving
    })
    .then(text => {
        console.log('Response text:', text);
        
        try {
            const data = JSON.parse(text);
            if (data.success) {
                alert('Employee added successfully!');
                // Close modal
                const modal = bootstrap.Modal.getInstance(document.getElementById('addEmployeeModal'));
                if (modal) modal.hide();
                // Refresh the page to show the new employee
                location.reload();
            } else {
                alert('Failed to add employee: ' + data.message);
            }
        } catch (parseError) {
            console.error('JSON parse error:', parseError);
            console.error('Response was:', text);
            alert('Error: Invalid response from server');
        }
    })
    .catch(error => {
        console.error('Fetch error details:', error);
        alert('Error adding employee: ' + error.message + '. Please check the console for details.');
    })
    .finally(() => {
        // Re-enable submit button
        submitBtn.disabled = false;
        submitBtn.textContent = 'Add Employee';
    });
    
    return false;
  }

  function toggleStatus(userId) {
    const isActive = event.target.checked;
    const status = isActive ? 'active' : 'inactive';
    
    // Send AJAX request to update user status
    fetch('<%= request.getContextPath() %>/UserManagementServlet', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'action=updateStatus&userId=' + userId + '&status=' + status
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        console.log('User ' + userId + ' status updated to ' + status);
        // Optionally show a success message
      } else {
        console.error('Failed to update user status:', data.message);
        // Revert the toggle if update failed
        event.target.checked = !isActive;
        alert('Failed to update user status. Please try again.');
      }
    })
    .catch(error => {
      console.error('Error updating user status:', error);
      // Revert the toggle if request failed
      event.target.checked = !isActive;
      alert('Error updating user status. Please try again.');
    });
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

  // Edit user function
  function editUser(userId) {
    // This will redirect to an edit page or open an edit modal
    // For now, let's redirect to a simple edit page
    window.location.href = '<%= request.getContextPath() %>/Views/UpdateEmployeeDetails.jsp?userId=' + userId;
  }

  // Delete user function
  function deleteUser(userId) {
    // Debug logging
    console.log('deleteUser called with userId:', userId);
    console.log('userId type:', typeof userId);
    
    // Validate userId
    if (!userId || userId === '' || userId === 'null' || userId === 'undefined') {
      alert('Error: Invalid user ID. Cannot delete employee.');
      console.error('Invalid userId:', userId);
      return;
    }
    
    if (confirm('Are you sure you want to delete this employee? This action cannot be undone.')) {
      const requestBody = 'action=delete&userId=' + userId;
      console.log('Request body:', requestBody);
      
      fetch('<%= request.getContextPath() %>/UserManagementServlet', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: requestBody
      })
      .then(response => {
        console.log('Response status:', response.status);
        return response.json();
      })
      .then(data => {
        console.log('Response data:', data);
        if (data.success) {
          alert('Employee deleted successfully!');
          // Reload the page to refresh the table
          location.reload();
        } else {
          alert('Failed to delete employee: ' + data.message);
        }
      })
      .catch(error => {
        console.error('Error deleting employee:', error);
        alert('Error deleting employee. Please try again.');
      });
    }
  }
</script>
</body>
</html>
