<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Sign In</title>
	<link rel="shortcut icon" type="image/png" href="image/favicon.png" />
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<style>
		body {
			background-color: #f8f9fa;
			margin: 0;
			font-family: Arial, sans-serif;
			display: flex;
			flex-direction: column;
			min-height: 100vh;
		}

		.main-container {
			flex: 1;
			display: flex;
			justify-content: center;
			align-items: center;
			padding: 20px;
		}

		.login-container {
			width: 100%;
			max-width: 550px; /* Reduced max-width */
			background-color: #000;
			color: #fff;
			padding: 40px;
			border-radius: 10px;
			box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
			text-align: center;
		}

		.welcome-message {
			font-size: 28px;
			font-weight: bold;
			margin-bottom: 30px;
			color: #28a745; /* Green for "Green Bank" */
		}

		h1 {
			color: #fff;
			margin-bottom: 30px;
		}

		.form-group label {
			color: #fff;
		}

		.form-control {
			max-width: 230px; /* Smaller width for input fields */
			padding: 5px 10px; /* Adjusted padding for compact design */
			margin: 0 auto; /* Center align input fields */
		}

		.btn-primary {
			background-color: #007bff;
			border-color: #007bff;
		}

		.btn-primary:hover {
			background-color: #0056b3;
			border-color: #0056b3;
		}

		.alert {
			margin-top: 20px;
		}
	</style>
</head>
<body>
<!-- Include Header -->
<jsp:include page="header.jsp" />

<!-- Main Content -->
<div class="main-container">
	<div class="login-container">
		<!-- Welcome Message -->
		<div class="welcome-message">
			Welcome to Green Bank
		</div>

		<!-- Login Container -->
		<h1>LOGIN PLEASE</h1>
		<form method="post" action="LoginServlet">
			<div class="form-group">
				<label for="email">UserName</label>
				<input type="text" name="UserName" required class="form-control" id="account_no" placeholder="User Name">
			</div>
			<div class="form-group">
				<label for="password">Password*</label>
				<input type="password" name="password" required class="form-control" id="password" placeholder="Password">
			</div>
			<div class="checkbox">
				<label>
					<input name="remember" type="checkbox" value="Remember Me"> Remember Me
				</label>
			</div>
			<%
				String isPassOK = (String) request.getAttribute("isPassOK");
				if (isPassOK != null && isPassOK.equals("No")) {
			%>
			<div class="alert alert-danger" role="alert">
				<strong>Account No/Password Incorrect. Try Again.</strong>
			</div>
			<%
				}
			%>
			<input type="submit" class="btn btn-primary btn-lg" value="SIGN IN">
		</form>
	</div>
</div>

<!-- Include Footer -->
<jsp:include page="footer.jsp" />
</body>
</html>
