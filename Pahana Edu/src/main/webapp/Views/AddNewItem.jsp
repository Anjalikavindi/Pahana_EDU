<!-- AddNewItem.jsp -->
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


<div class="modal fade" id="addItemModal" tabindex="-1" aria-labelledby="addItemModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <form action="${pageContext.request.contextPath}/AddItemServlet" method="post" enctype="multipart/form-data">
        <div class="modal-header">
          <h5 class="modal-title" id="addItemModalLabel">Add New Item</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body row g-3">
          <div class="col-md-6">
            <label for="itemName" class="form-label">Item Name</label>
            <input type="text" class="form-control" id="itemName" name="itemName" required>
          </div>

          <div class="col-md-6">
            <label for="price" class="form-label">Price (LKR)</label>
            <input type="number" class="form-control" id="price" name="price" step="0.01" required>
          </div>

          <div class="col-md-6">
            <label for="image" class="form-label">Upload Image</label>
            <input type="file" class="form-control" id="image" name="image" accept="image/*" required>
          </div>

          <div class="col-md-6">
            <label for="quantity" class="form-label">Quantity</label>
            <input type="number" class="form-control" id="quantity" name="quantity" min="1" required>
          </div>
          
          <div class="col-12">
		    <label for="description" class="form-label">Description</label>
		    <textarea class="form-control" id="description" name="description" rows="3" placeholder="Enter item description..."></textarea>
		  </div>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-1" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-2">Add Item</button>
        </div>
      </form>
    </div>
  </div>
</div>
