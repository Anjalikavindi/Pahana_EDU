<!-- DisplayItemDetails.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String quantity = request.getParameter("quantity");
    String imagePath = request.getParameter("image");
    String description = request.getParameter("description");
    String addedBy = request.getParameter("added_by");     
    String addedAt = request.getParameter("added_at");
%>

<div class="modal fade" id="viewItemModal" tabindex="-1" aria-labelledby="viewItemModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content" style="background-color: #e1ecff;">
      <div class="modal-header">
        <h5 class="modal-title text-primary" id="viewItemModalLabel"><%= name %></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body row g-3">
        <div class="col-md-6 text-center">
          <img src="<%= imagePath %>" alt="Item Image" class="img-fluid rounded shadow" style="max-height: 250px;">
        </div>
        <div class="col-md-6">
          <h6>Name: <span class="text-muted"><%= name %></span></h6>
          <h6>Item Code: <span class="text-muted"><%= request.getParameter("code") %></span></h6>
          <h6>Price: <span class="text-muted">LKR <%= price %></span></h6>
          <h6>Quantity: <span class="text-muted"><%= quantity %></span></h6>
          <h6>Description: <span class="text-muted"><%= description %></span></h6> 
          <h6>Added By: <span class="text-muted"><%= addedBy %></span></h6>
          <h6>Date: <span class="text-muted"><%= addedAt %></span></h6>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
