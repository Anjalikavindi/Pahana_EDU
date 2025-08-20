<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.myapp.dao.ItemDAO" %>
<%@ page import="com.myapp.model.ItemBean" %>
<%@ page import="com.myapp.dao.CustomerDAO" %>
<%@ page import="com.myapp.model.CustomerBean" %>
<%@ include file="Sidebar.jsp" %>
<%
    ItemDAO itemDAO = new ItemDAO();
    List<ItemBean> itemList = itemDAO.getAllItems();
    CustomerDAO customerDAO = new CustomerDAO();
    List<CustomerBean> customerList = customerDAO.getAllCustomers();
    // Customer selected from servlet
    CustomerBean selectedCustomer = (CustomerBean) request.getAttribute("selectedCustomer");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Billing Form</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { 
        min-height: 100vh; 
        background-color: #F5EEDC; 
        }
        
        .content { 
        padding: 2rem; 
        margin-left: 90px; 
        width: calc(100% - 90px); 
        }
        
        .billing-card { 
        background-color: #f9d7d6; 
        padding: 30px; 
        border-radius: 15px; 
        box-shadow: 0 6px 18px rgba(0, 0, 0, 0.25); 
        }
        
        .form-section-title { 
        font-weight: 600; 
        font-size: 1.2rem; 
        margin-bottom: 15px; 
        }
        
        .table thead th { 
        background-color: #DD4A48; 
        color: #ffffff; 
        }
        
        .table-wrapper { 
        border-radius: 15px; 
        overflow: hidden; 
        }
        
        .table tbody tr:nth-child(odd) {
         background-color: #f2c1bf; 
         }
         
        .table tbody tr:nth-child(even) {
         background-color: #f9d7d6; 
         }
         
        .summary-table { 
        background-color: #f9d7d6; 
        }
        
        .summary-table th, 
        .summary-table td, 
        .summary-table tr { 
        background-color: #f9d7d6 !important; 
        }
        
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <main class="content">
            <jsp:include page="Header.jsp" />
            <div class="billing-card mt-5">
                <h3 class="mb-4 text-center">Billing Form</h3>

                <!-- Customer Selection Form (GET) -->
                <div class="form-section-title">Customer Details</div>
                <form action="<%= request.getContextPath() %>/BillServlet" method="get" id="customerForm">
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="accountNumber" class="form-label">Account Number</label>
                            <select class="form-select" id="accountNumber" name="accountNumber" onchange="this.form.submit()" required>
                                <option value="">-- Select Account Number --</option>
                                <% for(CustomerBean cust : customerList) { %>
                                    <option value="<%= cust.getAccountNumber() %>"
                                        <%= (selectedCustomer != null && selectedCustomer.getAccountNumber().equals(cust.getAccountNumber())) ? "selected" : "" %>>
                                        <%= cust.getAccountNumber() %>
                                    </option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="customerName" class="form-label">Customer Name</label>
                            <input type="text" class="form-control" id="customerName" name="customerName"
                                   value="<%= (selectedCustomer != null) ? selectedCustomer.getFirstName() + " " + selectedCustomer.getLastName() : "" %>" readonly>
                        </div>
                        <div class="col-md-4">
                            <label for="loyaltyPointsCustomer" class="form-label">Loyalty Points</label>
                            <input type="text" class="form-control" id="loyaltyPointsCustomer" name="loyaltyPointsCustomer"
                                   value="<%= (selectedCustomer != null) ? selectedCustomer.getRemainingUnits() : 0 %>" readonly>
                        </div>
                    </div>
                </form>

                <!-- Bill Generation Form (POST) -->
                <form action="<%= request.getContextPath() %>/BillServlet" method="post" id="billForm">
                    <input type="hidden" name="accountNumber" value="<%= (selectedCustomer != null) ? selectedCustomer.getAccountNumber() : "" %>">

                    <!-- Billing Items -->
                    <div class="form-section-title">Billing Items</div>
                    <table class="table table-bordered table-wrapper" id="itemsTable">
                        <thead class="table-danger">
                        <tr>
                            <th>Item</th>
                            <th style="width: 100px;">Quantity</th>
                            <th style="width: 150px;">Unit Price (Rs.)</th>
                            <th style="width: 150px;">Total (Rs.)</th>
                            <th style="width: 50px;">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                <select class="form-select" name="item[]" onchange="setPrice(this)">
								  <option value="">-- Select Item --</option>
								  <% for(ItemBean item : itemList) { %>
								    <option value="<%= item.getItemName() %>" 
								            data-price="<%= item.getPrice() %>" 
								            data-stock="<%= item.getQuantity() %>">
								      <%= item.getItemName() %>
								    </option>
								  <% } %>
								</select>
                            </td>
                            <td><input type="number" class="form-control qty" name="quantity[]" oninput="calculateRowTotal(this)"></td>
                            <td><input type="number" class="form-control price" name="price[]" oninput="calculateRowTotal(this)"></td>
                            <td><input type="text" class="form-control total" name="total[]" readonly></td>
                            <td class="text-center">
                                <button type="button" class="btn btn-sm btn-danger" onclick="removeRow(this)"><i class="bi bi-trash-fill"></i></button>
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
                            <table class="table summary-table">
                                <tbody>
                                <tr>
                                    <th>Subtotal (Rs.):</th>
                                    <td><input type="text" class="form-control" id="subtotal" readonly></td>
                                </tr>
                                <tr>
                                    <th><strong>Grand Total (Rs.):</strong></th>
                                    <td><input type="text" class="form-control" id="grandTotal" readonly></td>
                                </tr>
                                <tr>
                                    <th>Amount Paid (Rs.):</th>
                                    <td><input type="number" class="form-control" id="amountPaid" oninput="calculateBalance()"></td>
                                </tr>
                                <tr>
                                    <th>Loyalty Points Used:</th>
                                    <td><input type="number" class="form-control" id="loyaltyPoints" oninput="calculateBalance()"></td>
                                </tr>
                                <tr>
                                    <th>Balance (Rs.):</th>
                                    <td><input type="text" class="form-control" id="balance" readonly></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Hidden fields for POST -->
                    <input type="hidden" name="subtotal" id="hiddenSubtotal">
                    <input type="hidden" name="grandTotal" id="hiddenGrandTotal">
                    <input type="hidden" name="amountPaid" id="hiddenAmountPaid">
                    <input type="hidden" name="loyaltyPoints" id="hiddenLoyaltyPoints">
                    <input type="hidden" name="balance" id="hiddenBalance">

                    <!-- Submit Button -->
                    <div class="text-end">
                        <button type="button" class="btn btn-danger" onclick="confirmGenerateBill()">Generate Bill</button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</div>

<!-- JS Scripts -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
	window.onload = function() {
	    <% if (session.getAttribute("billSuccess") != null) { %>
	        Swal.fire({
	            title: 'Bill Generated!',
	            text: 'The bill was generated successfully.',
	            icon: 'success',
	            confirmButtonColor: '#d33'
	        }).then(() => {
	            resetAllForms(); // reset forms after user closes the alert
	        });
	        <% session.removeAttribute("billSuccess"); %>
	    <% } %>

	    // Error message
	    <% if (session.getAttribute("billError") != null) { %>
	        Swal.fire({
	            title: 'Error!',
	            text: '<%= session.getAttribute("billError") %>',
	            icon: 'error',
	            confirmButtonColor: '#d33'
	        });
	        <% session.removeAttribute("billError"); %>
	    <% } %>
	};
	function resetAllForms() {
        // Reset customer selection form
        document.getElementById("customerForm").reset();
        document.getElementById("accountNumber").selectedIndex = 0;
        document.getElementById("customerName").value = "";
        document.getElementById("loyaltyPointsCustomer").value = "0";
        
        // Reset bill form
        document.getElementById("billForm").reset();
        
        // Clear all summary fields
        document.getElementById("subtotal").value = "";
        document.getElementById("grandTotal").value = "";
        document.getElementById("amountPaid").value = "";
        document.getElementById("loyaltyPoints").value = "";
        document.getElementById("balance").value = "";
        
        // Clear all hidden fields
        document.getElementById("hiddenSubtotal").value = "";
        document.getElementById("hiddenGrandTotal").value = "";
        document.getElementById("hiddenAmountPaid").value = "";
        document.getElementById("hiddenLoyaltyPoints").value = "";
        document.getElementById("hiddenBalance").value = "";
        
        // Reset items table to have only one empty row
        const tbody = document.getElementById('itemsTable').querySelector('tbody');
        tbody.innerHTML = `
            <tr>
                <td>
                    <select class="form-select" name="item[]" onchange="setPrice(this)">
                        <option value="">-- Select Item --</option>
                        <% for(ItemBean item : itemList) { %>
                            <option value="<%= item.getItemName() %>" 
                                    data-price="<%= item.getPrice() %>" 
                                    data-stock="<%= item.getQuantity() %>">
                                <%= item.getItemName() %>
                            </option>
                        <% } %>
                    </select>
                </td>
                <td><input type="number" class="form-control qty" name="quantity[]" oninput="calculateRowTotal(this)"></td>
                <td><input type="number" class="form-control price" name="price[]" oninput="calculateRowTotal(this)"></td>
                <td><input type="text" class="form-control total" name="total[]" readonly></td>
                <td class="text-center">
                    <button type="button" class="btn btn-sm btn-danger" onclick="removeRow(this)"><i class="bi bi-trash-fill"></i></button>
                </td>
            </tr>`;
    }
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
        const grandTotal = subtotal; // no discount
        document.getElementById('subtotal').value = subtotal.toFixed(2);
        document.getElementById('grandTotal').value = grandTotal.toFixed(2);
    }
    function calculateBalance() {
        const grandTotal = parseFloat(document.getElementById('grandTotal').value) || 0;
        const amountPaid = parseFloat(document.getElementById('amountPaid').value) || 0;
        const loyaltyPoints = parseFloat(document.getElementById('loyaltyPoints').value) || 0;
        const balance = grandTotal - amountPaid - loyaltyPoints;
        document.getElementById('balance').value = balance.toFixed(2);
    }
    function addRow() {
        const table = document.getElementById('itemsTable').querySelector('tbody');
        const newRow = document.createElement('tr');
        newRow.innerHTML = `
            <td>
                <select class="form-select" name="item[]" onchange="setPrice(this)">
                    <option value="">-- Select Item --</option>
                    <% for(ItemBean item : itemList) { %>
                        <option value="<%= item.getItemName() %>" 
                                data-price="<%= item.getPrice() %>" 
                                data-stock="<%= item.getQuantity() %>">
                            <%= item.getItemName() %>
                        </option>
                    <% } %>
                </select>
            </td>
            <td><input type="number" class="form-control qty" name="quantity[]" oninput="calculateRowTotal(this)"></td>
            <td><input type="number" class="form-control price" name="price[]" oninput="calculateRowTotal(this)"></td>
            <td><input type="text" class="form-control total" name="total[]" readonly></td>
            <td class="text-center">
                <button type="button" class="btn btn-sm btn-danger" onclick="removeRow(this)"><i class="bi bi-trash-fill"></i></button>
            </td>`;
        table.appendChild(newRow);
    }

    function setPrice(select) {
        const row = select.closest('tr');
        const priceField = row.querySelector('.price');
        const qtyField = row.querySelector('.qty');
        const selectedOption = select.options[select.selectedIndex];
        const price = parseFloat(selectedOption.getAttribute("data-price")) || 0;
        const stock = parseInt(selectedOption.getAttribute("data-stock")) || 0;

        priceField.value = price;
        qtyField.setAttribute("max-stock", stock); // store max stock for this row
        calculateRowTotal(priceField);
    }


    function removeRow(button) {
        const row = button.closest('tr');
        row.remove();
        calculateTotals();
    }
    function prepareFormData() {
        document.getElementById("hiddenSubtotal").value = document.getElementById("subtotal").value;
        document.getElementById("hiddenGrandTotal").value = document.getElementById("grandTotal").value;
        document.getElementById("hiddenAmountPaid").value = document.getElementById("amountPaid").value;
        document.getElementById("hiddenLoyaltyPoints").value = document.getElementById("loyaltyPoints").value;
        document.getElementById("hiddenBalance").value = document.getElementById("balance").value;
    }
    
    function confirmGenerateBill() {
        prepareFormData(); // fill hidden fields

        // Check stock
        const rows = document.querySelectorAll('#itemsTable tbody tr');
        for (let row of rows) {
            const itemSelect = row.querySelector('select[name="item[]"]');
            const qtyInput = row.querySelector('.qty');
            if (!itemSelect.value) continue; // skip empty row

            const maxStock = parseInt(qtyInput.getAttribute("max-stock")) || 0;
            const qty = parseInt(qtyInput.value) || 0;

            if (qty > maxStock) {
                Swal.fire({
                    title: 'Out of Stock!',
                    text: `The quantity for item "${itemSelect.value}" exceeds available stock (${maxStock}).`,
                    icon: 'error'
                });
                return; // stop form submission
            }
        }

        // Proceed if all items are valid
        Swal.fire({
            title: 'Generate Bill?',
            text: "Are you sure you want to generate the bill?",
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, generate it!',
            cancelButtonText: 'Cancel'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('billForm').submit();
            }
        });
    }


</script>
</body>
</html>