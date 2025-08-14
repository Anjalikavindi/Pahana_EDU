<!-- File: adminHeader.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
  /* Show dropdown on hover */
  .admin-dropdown:hover .dropdown-menu {
    display: block;
    margin-top: 0; /* Remove gap */
  }
  .dropdown-menu .dropdown-item:hover {
    color: #000 !important;
  }
</style>

<!-- Admin Header -->
<div class="d-flex justify-content-between align-items-center mb-2 me-3 flex-wrap">
  <div class="d-flex align-items-center">
    <img src="<%= request.getContextPath() %>/Images/Logo.png"
         alt="Logo"
         class="img-fluid"
         style="height: auto; max-height: 40px; width: auto;">
  </div>

  <div class="dropdown admin-dropdown mt-2 mt-md-0">
    <div class="d-flex align-items-center gap-2 dropdown-toggle" role="button">
      <i class="bi bi-person-circle fs-3 fs-md-2 me-2 me-md-3"></i>
      <div class="d-flex flex-column text-start">
        <span class="fw-medium text-muted small small-md">Hi</span>
        <span class="fw-bold text-dark" style="font-size: 0.85rem;">
        <%
            HttpSession userSession = request.getSession(false);
            if (userSession != null && userSession.getAttribute("loggedInUser") != null) {
              com.myapp.model.UserBean user = (com.myapp.model.UserBean) userSession.getAttribute("loggedInUser");
              out.print(user.getUsername() != null ? user.getUsername() : user.getUsername());
            } else {
              out.print("Admin");
            }
          %>
         </span>
      </div>
    </div>

    <!-- Dropdown menu -->
    <ul class="dropdown-menu dropdown-menu-end shadow-sm mt-1 bg-dark">
      <li>
        <a class="dropdown-item text-light" href="<%= request.getContextPath() %>/Profile.jsp">
          <i class="bi bi-person me-2"></i> Profile
        </a>
      </li>
      <li>
        <a class="dropdown-item text-light" href="<%= request.getContextPath() %>/LogoutServlet">
	      <i class="bi bi-box-arrow-right me-2"></i> Logout
	    </a>
      </li>
    </ul>
  </div>
</div>
