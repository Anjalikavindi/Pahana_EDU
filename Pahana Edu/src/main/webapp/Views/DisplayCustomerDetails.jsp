<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myapp.dao.CustomerDAO"%>
<%@ page import="com.myapp.model.CustomerBean"%>
<%
	String accountNoParam = request.getParameter("accountNo");
	CustomerDAO customerDAO = new CustomerDAO();
	CustomerBean customer = customerDAO.getCustomerByAccountNumber(accountNoParam);
	
	String accountNo = (customer != null) ? customer.getAccountNumber() : "N/A";
	String name = (customer != null) ? customer.getFirstName() + " " + customer.getLastName() : "N/A";
	String units = (customer != null) ? String.valueOf(customer.getRemainingUnits()) : "N/A";
	String createdBy = (customer != null) ? customer.getCreatedBy() : "N/A";
	String regDate = (customer != null && customer.getCreatedAt() != null) ? customer.getCreatedAt().toString() : "N/A";
	String email = (customer != null) ? customer.getEmail() : "N/A";
	String contact = (customer != null) ? customer.getContactNumber() : "N/A";
	String address = (customer != null) ? customer.getAddress() : "N/A";
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
          
          <dt class="col-sm-4">Remaining Units</dt>
          <dd class="col-sm-8"><%= units %></dd>
          
          <dt class="col-sm-4">Added By</dt>
          <dd class="col-sm-8"><%= createdBy %></dd> 
          
          <dt class="col-sm-4">Registration Date</dt>
          <dd class="col-sm-8"><%= regDate %></dd> 
          
          <dt class="col-sm-4">Email</dt>
          <dd class="col-sm-8"><%= email %></dd>
          
          <dt class="col-sm-4">Contact</dt>
          <dd class="col-sm-8"><%= contact %></dd>

          <dt class="col-sm-4">Address</dt>
          <dd class="col-sm-8"><%= address %></dd>

        </dl>
      </div>
    </div>
  </div>
</div>
