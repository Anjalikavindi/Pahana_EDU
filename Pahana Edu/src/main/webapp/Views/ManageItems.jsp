<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Directive Tags -->
<%@ page import="java.util.List"%>
<%@ page import="com.myapp.model.ItemBean"%>
<%@ page import="com.myapp.dao.ItemDAO"%>
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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

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
	        <jsp:include page="Header.jsp" />

	        <!-- Welcome Message -->
	        <div class="ps-3 py-2 rounded-3 welcome-box" style="background-color: rgba(249, 155, 125, 0.7); margin-top: 60px;">
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
			    <div class="col-md-6 text-end" style="margin-top: -30px; margin-bottom: 30px;">
			      <img src="<%= request.getContextPath() %>/Images/books.png" class="img-fluid" alt="hero image" style="max-width: 45%; height: auto;">
			    </div>
			  </div>
			</div>
	      </div>
	      
	      <!-- Search Bar aligned left with colored search icon -->
			<div class="row mt-5 mb-4 justify-content-end">
			  <div class="col-md-3">
			    <div class="input-group">
			      <span class="input-group-text border-end-0 bg-danger">
			        <i class="bi bi-search text-white"></i>
			      </span>
			      <input
			        type="text"
			        id="itemSearchInput"
			        class="form-control border-start-0"
			        placeholder="Search by Item Code"
			        aria-label="Search"
			      />
			    </div>
			  </div>
			</div>

	      
	      <!-- Cards Grid -->
			<div class="row g-4 mt-3">
			<%
			  ItemDAO itemDAO = new ItemDAO();
			  List<ItemBean> items = itemDAO.getAllItems();
			  for (ItemBean item : items) {
			%>
			<div class="col-lg-3 col-md-4 col-sm-6">
			  <div class="card h-100">
			    <img src="<%= request.getContextPath() %>/<%= item.getImagePath() %>" class="card-img-top" alt="item image">
			    <div class="card-body">
			      <h5 class="card-title"><%= item.getItemName() %></h5>
			      <p class="card-text text-muted mb-0 item-code">Item code: <%= item.getItemCode() %></p>
			      <p class="card-text text-muted mb-0">Qtty: <%= item.getQuantity() %></p>
			    </div>
			    <div class="card-footer bg-white border-top-0 pb-3 card-icons">
			      <a href="#" title="View" class="view-circle icon-circle viewItemBtn"
			         data-code="<%= item.getItemCode() %>"
			         data-name="<%= item.getItemName() %>"
			         data-price="<%= item.getPrice() %>"
			         data-quantity="<%= item.getQuantity() %>"
			         data-description="<%= item.getItemDescription() %>"
			         data-added_by="<%= item.getCreatedBy() %>"
			         data-added_at="<%= item.getCreatedAt() %>"
			         data-image="<%= request.getContextPath() %>/<%= item.getImagePath() %>">
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
			<% } %>
			</div>
           </main>
           <div id="addItemModalContainer"></div>
           <div id="viewItemModalContainer"></div>
        </div>
      </div>
      

<!-- Bootstrap JS (Optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>

  //Add new item popup
  document.getElementById("openAddItemBtn").addEventListener("click", function () {
    fetch("AddNewItem.jsp")
      .then(response => response.text())
      .then(html => {
        document.getElementById("addItemModalContainer").innerHTML = html;
        var addItemModal = new bootstrap.Modal(document.getElementById("addItemModal"));
        addItemModal.show();
     // Attach event listener to the form AFTER the modal content is loaded
        document.getElementById("addItemForm").addEventListener("submit", function(e) {
            e.preventDefault(); // Prevent default form submission

            const form = this;
            const formData = new FormData(form);

            fetch(form.action, {
                method: "POST",
                body: formData
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    // Show success SweetAlert
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: data.message
                    }).then(() => {
                        // Get the modal element
                        const addItemModalEl = document.getElementById("addItemModal");
                        // Get the existing modal instance
                        const addItemModal = bootstrap.Modal.getInstance(addItemModalEl);
                        if (addItemModal) {
                            // Close the modal after the user closes the alert
                            addItemModal.hide();
                        }
                        // Reload the page
                        window.location.reload();
                    });
                } else {
                    // Show error SweetAlert
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: data.message
                    });
                }
            })
            .catch(err => {
                console.error(err);
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Something went wrong while processing your request!'
                });
            });
        });
      })
      .catch(error => console.error('Error loading modal:', error));
  });
  
  
	//Search functionality by item code
	document.getElementById("itemSearchInput").addEventListener("input", function () {
	    const searchCode = this.value.trim().toLowerCase();
	
	    document.querySelectorAll(".card").forEach(card => {
	        const itemCodeElement = card.querySelector(".item-code");
	        if (itemCodeElement) {
	            const itemCode = itemCodeElement.innerText.replace("Item code: ", "").toLowerCase();
	            if (itemCode.includes(searchCode)) {
	                card.closest(".col-lg-3").style.display = "";
	            } else {
	                card.closest(".col-lg-3").style.display = "none";
	            }
	        }
	    });
	});


  
	//View item popup
	document.querySelectorAll(".viewItemBtn").forEach(btn => {
	  btn.addEventListener("click", function (e) {
	    e.preventDefault();

	    const params = new URLSearchParams({
	      code: this.dataset.code,
	      name: this.dataset.name,
	      price: this.dataset.price,
	      quantity: this.dataset.quantity,
	      description: this.dataset.description,
	      added_by: this.dataset.added_by,
	      added_at: this.dataset.added_at,
	      image: this.dataset.image
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
  
	//Delete item popup
	  document.querySelectorAll(".delete-circle").forEach(btn => {
	      btn.addEventListener("click", function (e) {
	          e.preventDefault();
	          const itemCode = this.closest(".card").querySelector(".viewItemBtn").dataset.code;
	
	          Swal.fire({
	              title: 'Are you sure?',
	              text: "This will permanently delete the item!",
	              icon: 'warning',
	              showCancelButton: true,
	              confirmButtonColor: '#d33',
	              cancelButtonColor: '#6c757d',
	              confirmButtonText: 'Yes, delete!'
	          }).then((result) => {
	              if (result.isConfirmed) {
	                  fetch(`DeleteItemServlet?itemCode=${encodeURIComponent(itemCode)}`, {
	                      method: 'POST'
	                  })
	                  .then(response => response.json())
	                  .then(data => {
	                      if (data.success) {
	                          Swal.fire(
	                              'Deleted!',
	                              data.message,
	                              'success'
	                          ).then(() => {
	                              window.location.reload();
	                          });
	                      } else {
	                          Swal.fire(
	                              'Error!',
	                              data.message,
	                              'error'
	                          );
	                      }
	                  })
	                  .catch(err => {
	                      console.error(err);
	                      Swal.fire('Error!', 'Something went wrong.', 'error');
	                  });
	              }
	          });
	      });
	  });

</script>


</body>
</html>
