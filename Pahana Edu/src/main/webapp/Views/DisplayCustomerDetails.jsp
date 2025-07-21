<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String accountNo = request.getParameter("accountNo");
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String contact = request.getParameter("contact");
    String units = request.getParameter("units");
%>

<!-- Customer Details Modal -->
<div class="modal fade" id="customerDetailsModal" tabindex="-1" aria-labelledby="customerDetailsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content" style="background-color: #e1ecff;">
      <div class="modal-header">
        <h5 class="modal-title text-primary" id="customerDetailsModalLabel">Customer Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <div class="modal-body">
        <dl class="row">
          <dt class="col-sm-4">Account Number</dt>
          <dd class="col-sm-8"><%= accountNo %></dd>

          <dt class="col-sm-4">Name</dt>
          <dd class="col-sm-8"><%= name %></dd>

          <dt class="col-sm-4">Address</dt>
          <dd class="col-sm-8"><%= address %></dd>

          <dt class="col-sm-4">Contact</dt>
          <dd class="col-sm-8"><%= contact %></dd>

          <dt class="col-sm-4">Units Consumed</dt>
          <dd class="col-sm-8"><%= units %></dd>
        </dl>
      </div>
    </div>
  </div>
</div>
