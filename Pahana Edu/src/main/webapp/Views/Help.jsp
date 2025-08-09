<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="Sidebar.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Help</title>

  <!-- Bootstrap CSS -->
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

    .accordion-button {
      background-color: rgba(249, 155, 125, 0.7);
      color: #333;
      font-weight: 600;
    }

    .accordion-button:not(.collapsed) {
      background-color: #DD4A48;
      color: #ffffff;
    }

    .accordion-body {
      background-color: #FFF8F0;
      font-size: 0.95rem;
      line-height: 1.6;
      color: #444;
    }

    .highlight {
      color: #BF3E3E;
      font-weight: 600;
    }
  </style>
</head>

<body>

<div class="container-fluid">
  <div class="row">

    <main class="content" style="margin-left: 90px; width: calc(100% - 90px);">
      <div class="d-flex flex-column pb-5 mb-5">
        <jsp:include page="Header.jsp" />
      </div>

      <div class="accordion mt-5" id="helpSection">

        <!-- Dashboard -->
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingDashboard">
            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDashboard" aria-expanded="true" aria-controls="collapseDashboard">
              🏠 Dashboard Overview
            </button>
          </h2>
          <div id="collapseDashboard" class="accordion-collapse collapse show" aria-labelledby="headingDashboard" data-bs-parent="#helpSection">
            <div class="accordion-body">
              The <span class="highlight">Dashboard</span> provides a quick summary of key business metrics:
              <ul>
                <li><strong>Total Customers:</strong> Track how many customers are registered in the system.</li>
                <li><strong>Sales Summary:</strong> View overall billing performance and revenue statistics.</li>
                <li><strong>Quick Access:</strong> Use the <strong>"Calculate Bill"</strong> button located on the top-left corner to jump directly to the billing form for fast transactions.</li>
              </ul>
              This section is perfect for managers or admins to monitor business activities at a glance.
            </div>
          </div>
        </div>

        <!-- Billing Section -->
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingBilling">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBilling" aria-expanded="false" aria-controls="collapseBilling">
              💵 Billing Section
            </button>
          </h2>
          <div id="collapseBilling" class="accordion-collapse collapse" aria-labelledby="headingBilling" data-bs-parent="#helpSection">
            <div class="accordion-body">
              The <span class="highlight">Billing Section</span> allows you to:
              <ul>
                <li>Enter consumption details and calculate customer bills.</li>
                <li>Preview and print the bill for customer records.</li>
                <li>If a customer is not yet registered, you can <strong>add them on the spot</strong> before generating the bill.</li>
              </ul>
              This feature ensures all transactions are recorded and invoiced properly.
            </div>
          </div>
        </div>

        <!-- Manage Items -->
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingItems">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseItems" aria-expanded="false" aria-controls="collapseItems">
              📦 Manage Items
            </button>
          </h2>
          <div id="collapseItems" class="accordion-collapse collapse" aria-labelledby="headingItems" data-bs-parent="#helpSection">
            <div class="accordion-body">
              In the <span class="highlight">Manage Items</span> section, you can:
              <ul>
                <li><strong>Add new items</strong> (products or services) offered by the business.</li>
                <li><strong>View item list</strong> including name, category, pricing, and stock info.</li>
                <li><strong>Edit item details</strong> such as name, unit price, or description.</li>
                <li><strong>Remove items</strong> that are no longer in use.</li>
              </ul>
              Keeping your item database updated ensures accurate billing and inventory management.
            </div>
          </div>
        </div>

        <!-- Manage Users -->
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingUsers">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseUsers" aria-expanded="false" aria-controls="collapseUsers">
              👥 Manage Customers
            </button>
          </h2>
          <div id="collapseUsers" class="accordion-collapse collapse" aria-labelledby="headingUsers" data-bs-parent="#helpSection">
            <div class="accordion-body">
              The <span class="highlight">Manage Customers</span> section allows you to:
              <ul>
                <li><strong>Register new customers</strong> with contact and billing information.</li>
                <li><strong>Edit customer profiles</strong> to update contact numbers, addresses, etc.</li>
                <li><strong>View customer list</strong> and search based on name, contact, or account number.</li>
              </ul>
              Keeping customer records updated ensures faster billing and better service history tracking.
            </div>
          </div>
        </div>

      </div>
      <!-- End of Help Section -->

    </main>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
