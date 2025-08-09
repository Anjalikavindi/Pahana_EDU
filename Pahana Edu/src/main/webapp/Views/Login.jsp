<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- JSP expression -->
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
	
	
	<style>
    body {
      margin: 0;
      padding: 0;
      min-height: 100vh;
      
      background-color: #F5EEDC;
    }

    .login-wrapper {
      display: flex;
      min-height: 100vh;
    }

    .login-left {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 2rem;
    }

    .login-left img {
      width: 95%;
      max-width: 750px;
    }

    .login-right {
      flex: 1;
      
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 2rem;
    }

    .login-form {
	  width: 100%;
	  max-width: 450px;
	  background-color: rgba(192, 216, 192, 0.5);
	  padding: 2rem;
	  border-radius: 20px;
	  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
	}

    .login-form h2 {
      text-align: center;
      font-weight: bold;
      margin-bottom: 1.5rem;
    }

    .login-form .form-control {
    background-color: transparent;
      border: none;
      border-bottom: 2px solid #DD4A48;
      border-radius: 0;
      box-shadow: none;
      font-size: 1rem;
    }

    .login-form .form-control:focus {
      border-color: #00A686;
      box-shadow: none;
    }

    .login-form .btn-login {
      background-color: #DD4A48;
      border: none;
      width: 100%;
      padding: 0.5rem;
      font-weight: bold;
      color: #ffffff;
      border-radius: 30px;
      transition: background-color 0.3s ease;
    }

    .login-form .btn-login:hover {
      background-color: #00B3A6;
    }

    .login-form .form-label {
      font-weight: 500;
      font-size: 0.85rem;
      color: #333;
    }

    .forgot-password {
      font-size: 0.75rem;
      text-align: right;
      color: #999;
      display: block;
      margin-top: -10px;
      margin-bottom: 15px;
    }

    .login-icon {
      width: 70px;
      height: 70px;
      margin: 0 auto 1rem auto;
      display: block;
    }
  </style>
	
</head>

<body>

  <div class="login-wrapper">
    
    <!-- Left illustration -->
    <div class="login-left">
      <img src="<%= request.getContextPath() %>/Images/Login.png" alt="Illustration">
    </div>

    <!-- Right login form -->
    <div class="login-right">
      <div class="login-form">
        <h2>WELCOME</h2>

        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
		    <div class="my-5">
		        <label for="username" class="form-label fs-5">Username</label>
		        <input type="text" class="form-control" name="username" id="username" required>
		    </div>
		
		    <div class="mb-3">
		        <label for="password" class="form-label fs-5">Password</label>
		        <input type="password" class="form-control" name="password" id="password" required>
		    </div>
		
		    <span class="forgot-password">Forgot Password?</span>
		
		    <button type="submit" class="btn btn-login mt-4">LOGIN</button>
		
		    <p style="color:red;">
		        ${errorMessage}
		    </p>
		</form>

      </div>
    </div>

  </div>

</body>
</html>