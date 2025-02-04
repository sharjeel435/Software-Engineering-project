<%@ page import="com.example.demo.model.AccountModel" %>
<%@ page import="com.example.demo.model.usersmodel" %>
<%@ page import="com.example.demo.database.DatabaseOperations" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Transfer</title>
	<link rel="shortcut icon" type="image/png" href="image/favicon.png" />
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<style>
		body {
			background: linear-gradient(135deg, #e0eafc, #cfdef3);
			font-family: Arial, sans-serif;
		}
		.form-container {
			max-width: 350px;
			margin: 50px auto;
			background: #fff;
			padding: 20px 30px;
			border-radius: 10px;
			box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
		}
		.form-container h2 {
			text-align: center;
			margin-bottom: 20px;
			color: #333;
		}
		.colorgraph {
			height: 4px;
			background: linear-gradient(to right, #0dcaf0, #6610f2, #0d6efd);
			border: none;
			margin-bottom: 20px;
		}
		.btn-container {
			text-align: center;
		}
		.alert {
			margin-top: 10px;
		}
	</style>
</head>
<body>
<!-- Header -->
<jsp:include page="header.jsp" />

<!-- Main Content -->
<div class="container">
	<%
		AccountModel ac = null;
		usersmodel um = null;
		um = (usersmodel) session.getAttribute("userDetails");
		if (um != null) {
			DatabaseOperations operations = new DatabaseOperations();
			ac = operations.getAccount(um.getUser_id());
	%>
	<div class="form-container">
		<form method="post" action="TransferServlet">
			<h2>Transfer Form</h2>
			<hr class="colorgraph">

			<!-- Account Number -->
			<div class="form-group row">
				<label class="col-sm-4 col-form-label">Account No</label>
				<div class="col-sm-8">
					<input type="text" name="account_no" class="form-control" readonly value="<%=ac.getAccount_id()%>" />
				</div>
			</div>

			<!-- Target Account Number -->
			<div class="form-group row">
				<label class="col-sm-4 col-form-label">Target Acc No</label>
				<div class="col-sm-8">
					<input type="text" name="target_acc_no" class="form-control" placeholder="Enter Target Account No" required pattern="[0-9]+" />
				</div>
			</div>

			<!-- User Name -->
			<div class="form-group row">
				<label class="col-sm-4 col-form-label">User Name</label>
				<div class="col-sm-8">
					<input type="text" name="username" class="form-control" readonly value="<%=um.getUsername()%>" />
				</div>
			</div>

			<!-- Password -->
			<div class="form-group row">
				<label class="col-sm-4 col-form-label">Password</label>
				<div class="col-sm-8">
					<input type="password" name="password" class="form-control" placeholder="Enter Password" required />
				</div>
			</div>

			<!-- Amount -->
			<div class="form-group row">
				<label class="col-sm-4 col-form-label">Amount</label>
				<div class="col-sm-8">
					<input type="number" name="amount" class="form-control" placeholder="Enter Amount" required min="1" />
				</div>
			</div>

			<!-- Error Messages -->
			<%
				if (request.getAttribute("EnoughMoney") != null && request.getAttribute("EnoughMoney").equals("No")) {
			%>
			<div class="alert alert-danger">
				<strong>Sorry!</strong> You do not have enough money.
			</div>
			<% } %>
			<%
				if (request.getAttribute("isPassOk") != null && request.getAttribute("isPassOk").equals("No")) {
			%>
			<div class="alert alert-danger">
				<strong>Sorry!</strong> Password is incorrect.
			</div>
			<% } %>
			<%
				if (request.getAttribute("isExist") != null && request.getAttribute("isExist").equals("No")) {
			%>
			<div class="alert alert-danger">
				<strong>Sorry!</strong> Beneficiary does not exist.Please add Beneficiary.
			</div>
			<% } %>
			<%
				if (request.getAttribute("same") != null && request.getAttribute("same").equals("Yes")) {
			%>
			<div class="alert alert-danger">
				<strong>Sorry!</strong> You cannot transfer to your own account.
			</div>
			<% } %>

			<!-- Submit and Reset Buttons -->
			<hr class="colorgraph">
			<div class="btn-container">
				<button type="submit" class="btn btn-success">Submit</button>
				<button type="reset" class="btn btn-danger">Reset</button>
			</div>
		</form>
	</div>
	<% } else { %>
	<div class="alert alert-warning text-center" style="margin-top: 50px;">
		<strong>Warning!</strong> You must log in to access this page.
	</div>
	<% } %>
</div>

<!-- Footer -->
<jsp:include page="footer.jsp" />
</body>
</html>
