<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="Sidebar.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Billing Form</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

  <style>
    body {
      padding: 20px;
      background-color: #f8f9fa;
    }
    .billing-card {
      background-color: white;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
    }
    .form-section-title {
      font-weight: 600;
      font-size: 1.2rem;
      margin-bottom: 15px;
    }
  </style>
</head>
<body>

<div class="container">
  <div class="billing-card">
    <h3 class="mb-4 text-center">Billing Form</h3>

    <!-- Customer Details -->
    <div class="form-section-title">Customer Details</div>
    <div class="row mb-3">
      <div class="col-md-6">
        <label for="customerName" class="form-label">Customer Name</label>
        <input type="text" class="form-control" id="customerName" name="customerName" required>
      </div>
      <div class="col-md-6">
        <label for="accountNumber" class="form-label">Account Number</label>
        <input type="text" class="form-control" id="accountNumber" name="accountNumber" required>
      </div>
    </div>

    <!-- Billing Items -->
    <div class="form-section-title">Billing Items</div>
    <table class="table table-bordered" id="itemsTable">
      <thead class="table-danger">
        <tr>
          <th>Description</th>
          <th style="width: 100px;">Quantity</th>
          <th style="width: 150px;">Unit Price (Rs.)</th>
          <th style="width: 150px;">Total (Rs.)</th>
          <th style="width: 50px;">Action</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><input type="text" class="form-control" name="description[]"></td>
          <td><input type="number" class="form-control qty" name="quantity[]" oninput="calculateRowTotal(this)"></td>
          <td><input type="number" class="form-control price" name="price[]" oninput="calculateRowTotal(this)"></td>
          <td><input type="text" class="form-control total" readonly></td>
          <td class="text-center">
            <button type="button" class="btn btn-sm btn-danger" onclick="removeRow(this)"><i class="bi bi-x"></i></button>
          </td>
        </tr>
      </tbody>
    </table>
    <button type="button" class="btn btn-outline-success mb-3" onclick="addRow()">
      <i class="bi bi-plus-circle"></i> Add Item
    </button>

    <!-- Summary -->
    <div class="row">
      <div class="col-md-6"></div>
      <div class="col-md-6">
        <table class="table">
          <tr>
            <th>Subtotal (Rs.):</th>
            <td><input type="text" class="form-control" id="subtotal" readonly></td>
          </tr>
          <tr>
            <th>Tax (5%):</th>
            <td><input type="text" class="form-control" id="tax" readonly></td>
          </tr>
          <tr>
            <th><strong>Grand Total (Rs.):</strong></th>
            <td><input type="text" class="form-control" id="grandTotal" readonly></td>
          </tr>
        </table>
      </div>
    </div>

    <!-- Submit Button -->
    <div class="text-end">
      <button type="submit" class="btn btn-danger">Generate Bill</button>
    </div>

  </div>
</div>

<!-- JS Scripts -->
<script>
  function calculateRowTotal(input) {
    const row = input.closest('tr');
    const qty = parseFloat(row.querySelector('.qty').value) || 0;
    const price = parseFloat(row.querySelector('.price').value) || 0;
    const total = qty * price;
    row.querySelector('.total').value = total.toFixed(2);
    calculateTotals();
  }

  function calculateTotals() {
    let subtotal = 0;
    document.querySelectorAll('.total').forEach(input => {
      subtotal += parseFloat(input.value) || 0;
    });

    const tax = subtotal * 0.05;
    const grandTotal = subtotal + tax;

    document.getElementById('subtotal').value = subtotal.toFixed(2);
    document.getElementById('tax').value = tax.toFixed(2);
    document.getElementById('grandTotal').value = grandTotal.toFixed(2);
  }

  function addRow() {
    const table = document.getElementById('itemsTable').querySelector('tbody');
    const newRow = document.createElement('tr');
    newRow.innerHTML = `
      <td><input type="text" class="form-control" name="description[]"></td>
      <td><input type="number" class="form-control qty" name="quantity[]" oninput="calculateRowTotal(this)"></td>
      <td><input type="number" class="form-control price" name="price[]" oninput="calculateRowTotal(this)"></td>
      <td><input type="text" class="form-control total" readonly></td>
      <td class="text-center">
        <button type="button" class="btn btn-sm btn-danger" onclick="removeRow(this)"><i class="bi bi-x"></i></button>
      </td>
    `;
    table.appendChild(newRow);
  }

  function removeRow(button) {
    const row = button.closest('tr');
    row.remove();
    calculateTotals();
  }
</script>

</body>
</html>
