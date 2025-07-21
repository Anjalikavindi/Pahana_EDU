<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Directive Tags -->
<%@ include file="Sidebar.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Item Management</title>

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
	.card {
	  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.25); 
	}
	.card-img-top {
      max-height: 200px;
      object-fit: contain;
      background-color: #f7e1d9;
      padding: 20px 0; 
    }
    .card-icons {
      display: flex;
      justify-content: end;
      gap: 0.4rem;
      font-size: 1rem;
    }
    .card-icons a {
      color: #404040;
      transition: color 0.3s ease;
    }
    .card-icons a:hover {
      color: #DD4A48;
    }    
    .icon-circle {
	  width: 36px;
	  height: 36px;
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  border-radius: 50%;
	  transition: background-color 0.3s ease;
	}
	
	.view-circle {
	  background-color: #e1ecff;
	}
	.view-circle:hover {
	  background-color: #c1d8ff;
	}
	.edit-circle {
	  background-color: #d1f5e8;
	}
	.edit-circle:hover {
	  background-color: #aeeed7;
	}
	.delete-circle {
	  background-color: #ffe0e0;
	}
	.delete-circle:hover {
	  background-color: #ffcccc;
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
			      <h1 class="h2">Manage Items</h1>
			      <p class="text-muted">
			        Here’s a quick overview of your system performance and recent activity.<br>
			        Use the sidebar to manage customers, items, and billing efficiently.
			      </p>
			      <div class="d-flex align-items-right">
			        <button class="btn btn-danger me-3" id="openAddItemBtn">Add New Item</button>
			      </div>
			    </div>
			    <div class="col-md-6 text-end" style="margin-top: -150px;">
			      <img src="<%= request.getContextPath() %>/Images/dashboardimg.png" class="rounded-circle img-fluid" alt="hero image" style="max-width: 75%; height: auto;">
			    </div>
			  </div>
			</div>
	      </div>
	      
	      <!-- Cards Grid -->
			<div class="row g-4 mt-3">
			  <div class="col-lg-3 col-md-4 col-sm-6">
			    <div class="card h-100">
			      <img src="<%= request.getContextPath() %>/Remove/Book1.jpg" class="card-img-top" alt="book image">
			      <div class="card-body">
			        <h5 class="card-title">Deathly Hollows</h5>
			        <p class="card-text text-muted mb-0">Item code: 001</p>
			        <p class="card-text text-muted mb-0">Qtty: 2</p>
			      </div>
			      <div class="card-footer bg-white border-top-0 pb-3 card-icons">
					  <a href="#" title="View"
						   class="view-circle icon-circle viewItemBtn"
						   data-name="Deathly Hollows"
						   data-price="1200.00"
						   data-quantity="2"
						   data-image="<%= request.getContextPath() %>/Remove/Book1.jpg">
						   <i class="bi bi-eye-fill text-primary"></i>
					  </a>
					  <a href="#" title="Edit" class="edit-circle icon-circle">
					    <i class="bi bi-pencil-fill text-success"></i>
					  </a>
					  <a href="#" title="Delete" class="delete-circle icon-circle">
					    <i class="bi bi-trash-fill text-danger"></i>
					  </a>
				 </div>
			    </div>
			  </div>
			
			  <div class="col-lg-3 col-md-4 col-sm-6">
			    <div class="card h-100">
			      <img src="<%= request.getContextPath() %>/Remove/Book2.jpg" class="card-img-top" alt="book image">
			      <div class="card-body">
			        <h5 class="card-title">Harry Potter</h5>
			        <p class="card-text text-muted mb-0">Item code: 002</p>
			        <p class="card-text text-muted mb-0">Qtty: 100</p>
			      </div>
			      <div class="card-footer bg-white border-top-0 pb-3 card-icons">
					  <a href="#" title="View"
						   class="view-circle icon-circle viewItemBtn"
						   data-name="Harry Potter"
						   data-price="2500.00"
						   data-quantity="100"
						   data-image="<%= request.getContextPath() %>/Remove/Book2.jpg">
						   <i class="bi bi-eye-fill text-primary"></i>
					  </a>
					  <a href="#" title="Edit" class="edit-circle icon-circle">
					    <i class="bi bi-pencil-fill text-success"></i>
					  </a>
					  <a href="#" title="Delete" class="delete-circle icon-circle">
					    <i class="bi bi-trash-fill text-danger"></i>
					  </a>
				 </div>
			    </div>
			  </div>
			
			  <div class="col-lg-3 col-md-4 col-sm-6">
			    <div class="card h-100">
			      <img src="<%= request.getContextPath() %>/Remove/Book3.jpg" class="card-img-top" alt="book image">
			      <div class="card-body">
			        <h5 class="card-title">Sorcerer's Stone</h5>
			        <p class="card-text text-muted mb-0">Item code: 003</p>
			        <p class="card-text text-muted mb-0">Qtty: 23</p>
			      </div>
			      <div class="card-footer bg-white border-top-0 pb-3 card-icons">
					  <a href="#" title="View"
						   class="view-circle icon-circle viewItemBtn"
						   data-name="Sorcerer's Stone"
						   data-price="1800.00"
						   data-quantity="23"
						   data-image="<%= request.getContextPath() %>/Remove/Book3.jpg">
						   <i class="bi bi-eye-fill text-primary"></i>
					  </a>
					  <a href="#" title="Edit" class="edit-circle icon-circle">
					    <i class="bi bi-pencil-fill text-success"></i>
					  </a>
					  <a href="#" title="Delete" class="delete-circle icon-circle">
					    <i class="bi bi-trash-fill text-danger"></i>
					  </a>
				 </div>
			    </div>
			  </div>
			
			  <div class="col-lg-3 col-md-4 col-sm-6">
			    <div class="card h-100">
			      <img src="<%= request.getContextPath() %>/Remove/Book4.jpg" class="card-img-top" alt="book image">
			      <div class="card-body">
			        <h5 class="card-title">Half Blood Prince</h5>
			        <p class="card-text text-muted mb-0">Item code: 004</p>
			        <p class="card-text text-muted mb-0">Qtty: 58</p>
			      </div>
			      <div class="card-footer bg-white border-top-0 pb-3 card-icons">
					  <a href="#" title="View"
						   class="view-circle icon-circle viewItemBtn"
						   data-name="Half Blood Prince"
						   data-price="3800.00"
						   data-quantity="58"
						   data-image="<%= request.getContextPath() %>/Remove/Book4.jpg">
						   <i class="bi bi-eye-fill text-primary"></i>
					  </a>
					  <a href="#" title="Edit" class="edit-circle icon-circle">
					    <i class="bi bi-pencil-fill text-success"></i>
					  </a>
					  <a href="#" title="Delete" class="delete-circle icon-circle">
					    <i class="bi bi-trash-fill text-danger"></i>
					  </a>
				  </div>
			    </div>
			  </div>
			
			  <div class="col-lg-3 col-md-4 col-sm-6">
			    <div class="card h-100">
			      <img src="<%= request.getContextPath() %>/Remove/Book5.jpg" class="card-img-top" alt="book image">
			      <div class="card-body">
			        <h5 class="card-title">Philosopher's Stone</h5>
			        <p class="card-text text-muted mb-0">Item code: 005</p>
			        <p class="card-text text-muted mb-0">Qtty: 203</p>
			      </div>
			      <div class="card-footer bg-white border-top-0 pb-3 card-icons">
					  <a href="#" title="View"
						   class="view-circle icon-circle viewItemBtn"
						   data-name="Philosopher's Stone"
						   data-price="1800.00"
						   data-quantity="203"
						   data-image="<%= request.getContextPath() %>/Remove/Book5.jpg">
						   <i class="bi bi-eye-fill text-primary"></i>
					  </a>
					  <a href="#" title="Edit" class="edit-circle icon-circle">
					    <i class="bi bi-pencil-fill text-success"></i>
					  </a>
					  <a href="#" title="Delete" class="delete-circle icon-circle">
					    <i class="bi bi-trash-fill text-danger"></i>
					  </a>
				  </div>
			    </div>
			  </div>
			
			  <div class="col-lg-3 col-md-4 col-sm-6">
			    <div class="card h-100">
			      <img src="<%= request.getContextPath() %>/Remove/Book6.jpg" class="card-img-top" alt="book image">
			      <div class="card-body">
			        <h5 class="card-title">Prisoner of Azkaban</h5>
			        <p class="card-text text-muted mb-0">Item code: 006</p>
			        <p class="card-text text-muted mb-0">Qtty: 345</p>
			      </div>
			      <div class="card-footer bg-white border-top-0 pb-3 card-icons">
					  <a href="#" title="View"
						   class="view-circle icon-circle viewItemBtn"
						   data-name="Prisoner of Azkaban"
						   data-price="1300.00"
						   data-quantity="345"
						   data-image="<%= request.getContextPath() %>/Remove/Book6.jpg">
						   <i class="bi bi-eye-fill text-primary"></i>
					  </a>
					  <a href="#" title="Edit" class="edit-circle icon-circle">
					    <i class="bi bi-pencil-fill text-success"></i>
					  </a>
					  <a href="#" title="Delete" class="delete-circle icon-circle">
					    <i class="bi bi-trash-fill text-danger"></i>
					  </a>
				  </div>
			    </div>
			  </div>
			</div>
	      
          
           </main>
           <div id="addItemModalContainer"></div>
           <div id="viewItemModalContainer"></div>
        </div>
      </div>
      

<!-- Bootstrap JS (Optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>

  //Add new item popup
  document.getElementById("openAddItemBtn").addEventListener("click", function () {
    fetch("AddNewItem.jsp")
      .then(response => response.text())
      .then(html => {
        document.getElementById("addItemModalContainer").innerHTML = html;
        var addItemModal = new bootstrap.Modal(document.getElementById("addItemModal"));
        addItemModal.show();
      })
      .catch(error => console.error('Error loading modal:', error));
  });
  
  
  //View item popup
  document.querySelectorAll(".viewItemBtn").forEach(btn => {
    btn.addEventListener("click", function (e) {
      e.preventDefault();

      const name = this.dataset.name;
      const price = this.dataset.price;
      const quantity = this.dataset.quantity;
      const image = this.dataset.image;

      const params = new URLSearchParams({
        name,
        price,
        quantity,
        image
      });

      fetch("DisplayItemDetails.jsp?" + params.toString())
        .then(res => res.text())
        .then(html => {
          document.getElementById("viewItemModalContainer").innerHTML = html;
          const modal = new bootstrap.Modal(document.getElementById("viewItemModal"));
          modal.show();
        })
        .catch(err => console.error("Failed to load item modal:", err));
    });
  });
  
  //Edit item popup
  document.querySelectorAll(".card-icons .edit-circle").forEach(btn => {
    btn.addEventListener("click", function (e) {
      e.preventDefault();

      const card = this.closest(".card");
      const name = card.querySelector(".card-title").innerText;
      const quantity = card.querySelector(".card-text:nth-child(3)").innerText.replace("Qtty: ", "");
      const price = this.closest(".card-icons").querySelector(".viewItemBtn").dataset.price;
      const image = this.closest(".card-icons").querySelector(".viewItemBtn").dataset.image;

      const params = new URLSearchParams({ name, price, quantity, image });

      fetch("UpdateItemDetails.jsp?" + params.toString())
        .then(res => res.text())
        .then(html => {
          document.getElementById("viewItemModalContainer").innerHTML = html;
          const modal = new bootstrap.Modal(document.getElementById("editItemModal"));
          modal.show();
        })
        .catch(err => console.error("Failed to load edit modal:", err));
    });
  });
</script>


</body>
</html>
