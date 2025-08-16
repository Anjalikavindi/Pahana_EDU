<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String itemId = request.getParameter("itemId");
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String quantity = request.getParameter("quantity");
    String description = request.getParameter("description");
    String imagePath = request.getParameter("image");
%>

<style>
	.modal-body input.form-control,
	.modal-body textarea.form-control {
		background-color: rgba(255, 255, 255, 0.55); 
		border: none;
	}
	.modal-footer .btn-2:hover{
		background-color: #d1f5e8;
		color: #198754;
	}
</style>

<div class="modal fade" id="editItemModal" tabindex="-1" aria-labelledby="editItemModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content" style="background-color: #d1f5e8;">
      <div class="modal-header">
        <h5 class="modal-title text-success" id="editItemModalLabel">Edit Item - <%= name %></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="UpdateItemServlet" method="post" enctype="multipart/form-data" id="updateItemForm">
        <div class="modal-body row g-3 px-3">
          <div class="col-md-6 text-center">
            <img src="<%= imagePath %>" alt="Item Image" class="img-fluid rounded shadow" style="max-height: 250px;">
            <div class="mt-3">
              <label for="itemImage" class="form-label">Change Image</label>
              <input type="file" class="form-control" id="itemImage" name="itemImage">
            </div>
          </div>
          <div class="col-md-6">
          	<input type="hidden" name="itemId" value="<%= itemId %>">
            <div class="mb-3">
              <label for="itemName" class="form-label">Item Name</label>
              <input type="text" class="form-control" id="itemName" name="name" value="<%= name %>" required>
            </div>
            <div class="mb-3">
              <label for="itemPrice" class="form-label">Price (LKR)</label>
              <input type="number" class="form-control" id="itemPrice" name="price" value="<%= price %>" step="0.01" required>
            </div>
            <div class="mb-3">
              <label for="itemQuantity" class="form-label">Quantity</label>
              <input type="number" class="form-control" id="itemQuantity" name="quantity" value="<%= quantity %>" required>
            </div>
            <div class="mb-3">
			  <label for="itemDescription" class="form-label">Description</label>
			  <textarea class="form-control" id="itemDescription" name="description" rows="3"><%= description %></textarea>
			</div>
          </div>
        </div>
        <div class="modal-footer px-3">
          <button type="button" class="btn btn-outline-success" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-2 btn-success">Update Item</button>
        </div>
      </form>
    </div>
  </div>
</div>
