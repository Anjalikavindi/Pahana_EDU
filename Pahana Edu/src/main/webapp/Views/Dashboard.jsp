<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Directive Tags -->
<%@ include file="Sidebar.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Dashboard</title>
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	
	<style>
	body {
	  min-height: 100vh;
	  background-color: #F5EEDC;
	}
	.content {
	  padding: 2rem;
	}
	main .row .col-md-3 .card{
	  background-color: rgba(221, 74, 72, 0.7);
	  color: #ffffff;
	  border: none;
	  box-shadow: 2px 4px 8px 0 rgba(0, 0, 0, 0.5);
	  transition: transform 0.2s ease, box-shadow 0.2s ease;
	  cursor: pointer;
	}
	main .row .col-md-3 .card:hover {
	  transform: translateY(-7px);
	  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.25); 
	}
	.welcome-box {
	  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.25); 
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
			      <h1 class="h2">Welcome back, Admin!</h1>
			      <p class="text-muted">
			        Here’s a quick overview of your system performance and recent activity.<br>
			        Use the sidebar to manage customers, items, and billing efficiently.
			      </p>
			      <div class="d-flex align-items-right">
			        <button class="btn btn-danger me-3" onclick="window.location.href='<%= request.getContextPath() %>/Views/Bill.jsp'">Calculate Bill</button>
			      </div>
			    </div>
			    <div class="col-md-6 text-end" style="margin-top: -100px;">
			      <img src="<%= request.getContextPath() %>/Images/dashboardimg.png" class="rounded-circle img-fluid" alt="hero image" style="max-width: 75%; height: auto;">
			    </div>
			  </div>
			</div>
	      </div>

	      <!-- Cards Row -->
	      <div class="row">
	        <div class="col-md-3 mb-4 mt-5">
	          <div class="card">
	            <div class="card-body">
	              <h6 class="card-title">Earnings (Monthly)</h6>
	              <h4>$4,390</h4>
	              <p class="text-success">▲ 12%</p>
	            </div>
	          </div>
	        </div>
	        <div class="col-md-3 mb-4 mt-5">
	          <div class="card">
	            <div class="card-body">
	              <h6 class="card-title">Average Sale Price</h6>
	              <h4>$27.00</h4>
	              <p class="text-danger">▼ 3%</p>
	            </div>
	          </div>
	        </div>
	        <div class="col-md-3 mb-4 mt-5">
	          <div class="card">
	            <div class="card-body">
	              <h6 class="card-title">Clicks</h6>
	              <h4>11,291</h4>
	              <p class="text-success">▲ 12%</p>
	            </div>
	          </div>
	        </div>
	        <div class="col-md-3 mb-4 mt-5">
	          <div class="card">
	            <div class="card-body">
	              <h6 class="card-title">Conversion Rate</h6>
	              <h4>1.23%</h4>
	              <p class="text-danger">▼ 1%</p>
	            </div>
	          </div>
	        </div>
	      </div>

	      <!-- Placeholder Section -->
	      <div class="card mt-4 shadow-sm">
	        <div class="card-body">
	          <h5 class="card-title">Report Generation</h5>
	          <p class="card-text">Ready to get started? You can start building your reports using this panel.</p>
	        </div>
	      </div>
	    </main>
	  </div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
