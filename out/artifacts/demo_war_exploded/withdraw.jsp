<%@page import="com.example.demo.model.AccountModel"%>
<%@ page import="com.example.demo.model.usersmodel" %>
<%@ page import="com.example.demo.database.DatabaseOperations" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Withdraw</title>
<link rel="shortcut icon" type="image/png" href="image/favicon.png" />
<link rel="stylesheet" type="text/css" href="css/deposit.css">
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<!-- Enhanced Styling -->
	<style>
		body {
			background: linear-gradient(135deg, #e0eafc, #cfdef3);
			font-family: Arial, sans-serif;
		}

		.form-container {
			background: #ffffff;
			border-radius: 8px;
			box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
			padding: 30px;
			margin-top: 20px;
		}

		h2 {
			color: #333;
			text-align: center;
		}

		.colorgraph {
			height: 5px;
			background: linear-gradient(to right, #0dcaf0, #6610f2, #0d6efd);
			border: none;
			margin-bottom: 15px;
		}

		.btn-success {
			background: #198754;
			border: none;
			box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
		}

		.btn-danger {
			background: #dc3545;
			border: none;
			box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
		}

		.btn-success:hover, .btn-danger:hover {
			opacity: 0.9;
		}

		.alert {
			border-radius: 5px;
		}

		@media (max-width: 768px) {
			.form-container {
				padding: 15px;
			}

			h2 {
				font-size: 24px;
			}
		}
	</style>
</head>
<body>
	<div class="row">
		<jsp:include page="header.jsp" />
	</div>
	<div class="container-fullwidth">
		<%
			usersmodel um = null;
			AccountModel am = null;
			DatabaseOperations operations = new DatabaseOperations();
		%>
		<%
			um = (usersmodel) session.getAttribute("userDetails");
			if (um != null) {
				am = operations.getAccount(um.getUser_id());
		%>
		<div class="row" style="margin-top: 50px;">
			<div class="col-md-4 col-md-offset-4">
				<form role="form" method="post" action="WithdrawServlet">
					<h2>Withdraw Form</h2>
					<div class="col-md-12">
						<hr class="colorgraph">
					</div>
					<label class="col-md-4 control-label">Account No</label>
					<div class="col-sm-8 form-group">
						<input type="text" required placeholder="Enter Account No.."
							name="account_no" class="form-control"
							value="<%=am.getAccount_id()%>">
					</div>
					<label class="col-md-4 control-label">User Name</label>
					<div class="col-sm-8 form-group">
						<input type="text" required placeholder="Enter User Name.."
							name="username" class="form-control"
							value="<%=um.getUsername()%>">
					</div>

					<label class="col-md-4 control-label">Password</label>
					<div class="col-sm-8 form-group">
						<input type="password" required placeholder="Enter Password.."
							name="password" class="form-control">
					</div>

					<label class="col-md-4 control-label">Amount</label>
					<div class="col-sm-8 form-group">
						<input type="number" required placeholder="Enter Amount.."
							class="form-control" name="amount" min="1">
					</div>
					<div class="col-md-12">
						<hr class="colorgraph">
					</div>
					<input type="hidden" name="user_id" value="<% um.getUser_id();%>">
					<%
						String EnoughMoney = (String) request.getAttribute("EnoughMoney");
							if (EnoughMoney != null && EnoughMoney.equals("No")) {
					%>
					<div class="col-md-12">
						<div class="alert alert-danger" role="alert">
							<strong>Sorry!</strong> You do not have enough money.
						</div>
					</div>
					<%
						}
					%>
					<%
						String isPassOK = (String) request.getAttribute("isPassOK");
							if (isPassOK != null && isPassOK.equals("No")) {
					%>
					<div class="col-md-12">
						<div class="alert alert-danger" role="alert">
							<strong>Sorry!</strong> Password incorrect.
						</div>
					</div>
					<%
						}
					%>
					<div class="row col-md-10 col-md-offset-1">
						<div class="col-xs-6 col-md-6">
							<input type="submit" value="Submit"
								class="btn btn-success btn-block btn-md" tabindex="7">
						</div>
						<div class="col-xs-6 col-md-6">
							<input class="btn btn-danger btn-block btn-md" type="reset"
								value="Reset">
						</div>
					</div>
				</form>
			</div>
		</div>
		<%
			} else {
		%>
		<div class="row" style="margin-top: 150px;">
			<div class="alert alert-warning col-md-4 col-md-offset-4"
				role="alert">
				<strong>Warning!</strong> You have to login first.
			</div>
		</div>

		<%
			}
		%>

		<!-- Footer start here -->
		<div class="row" style="margin-top: 50px;">
			<jsp:include page="footer.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>