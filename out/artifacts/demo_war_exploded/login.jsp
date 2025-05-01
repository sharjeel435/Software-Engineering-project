<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
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
			background-color: #f4f6f9;
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		}

		.jumbotron {
			background-color: #ffffff;
			border-radius: 10px;
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
			padding: 30px 25px;
			max-width: 400px;
			margin: 80px auto;
		}

		h1 {
			text-align: center;
			font-size: 24px;
			font-weight: bold;
			color: #2c3e50;
			margin-bottom: 30px;
		}

		label {
			font-weight: 500;
			color: #34495e;
		}

		.form-control {
			border-radius: 5px;
			border: 1px solid #ced4da;
		}

		.btn-primary {
			width: 100%;
			background-color: #0056b3;
			border: none;
			border-radius: 5px;
		}

		.btn-primary:hover {
			background-color: #003d80;
		}

		.checkbox label {
			color: #555;
		}

		.alert-danger {
			margin-top: 15px;
		}
	</style>
</head>
<body>

<div class="row">
	<jsp:include page="header.jsp" />
</div>

<div class="container">
	<div class="jumbotron">
		<h1>Sign in</h1>
		<form method="post" action="LoginServlet">
			<div class="form-group">
				<label for="email">UserName</label>
				<input type="text" name="UserName" required class="form-control" id="account_no"
					   placeholder="UserName">
			</div>
			<div class="form-group">
				<label for="password">Password*</label>
				<input type="password" name="password" required class="form-control" id="password"
					   placeholder="Password">
			</div>
			<div class="checkbox">
				<label>
					<input name="remember" type="checkbox" value="Remember Me">Remember Me
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
			<input type="submit" class="btn btn-primary btn-lg" value="Sign in to your account">
		</form>
	</div>
</div>

<div class="row" style="margin-top: 50px;">
	<jsp:include page="footer.jsp"></jsp:include>
</div>

</body>
</html>
