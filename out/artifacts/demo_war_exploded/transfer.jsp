<%@page import="com.example.demo.model.AccountModel"%>
<%@ page import="com.example.demo.model.usersmodel" %>
<%@ page import="com.example.demo.database.DatabaseOperations" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Transfer</title>
<link rel="shortcut icon" type="image/png" href="image/favicon.png" />
<link rel="stylesheet" type="text/css" href="css/deposit.css">
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="row">
		<jsp:include page="header.jsp" />
	</div>
	<div class="container-fullwidth">
		<%
			AccountModel ac = null;
			usersmodel um = null;
		%>
		<%
			um = (usersmodel) session.getAttribute("userDetails");
			if (um != null) {
				DatabaseOperations operations = new DatabaseOperations();
				ac = operations.getAccount(um.getUser_id());
		%>
		<div class="row" style="margin-top: 50px;">
			<div class="col-md-4 col-md-offset-4">
				<form role="form" method="post" action="TransferServlet">
					<h2>Transfer Form</h2>
					<div class="col-md-12">
						<hr class="colorgraph">
					</div>
					<label class="col-md-4 control-label">Account No</label>
					<div class="col-sm-8 form-group">
						<input type="text" required placeholder="Enter Account No.."
							name="account_no" class="form-control"
							value="<%=ac.getAccount_id()%>">
					</div>
					<label class="col-md-4 control-label">Target Account No</label>
					<div class="col-sm-8 form-group">
						<input type="text" required placeholder="Enter Account No.."
							name="target_acc_no" class="form-control" pattern="[0-9]+" min="1">
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
						<input type="number" step="any" required placeholder="Enter Amount.."
							name="amount" class="form-control" min="1">
					</div>
					<div class="col-md-12">
						<hr class="colorgraph">
					</div>
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
						String isPassOK = (String) request.getAttribute("isPassOk");
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
					<%
						String isExist = (String) request.getAttribute("isExist");
						if (isExist != null && isExist.equals("No")) {
					%>
					<div class="col-md-12">
						<div class="alert alert-danger" role="alert">
							<strong>Sorry!</strong> Beneficiary does not exist into your account.<br>
							Please add beneficiary first <a href="benificary.jsp">Add Beneficiary</a>.
						</div>
					</div>
					<%
						}
					%>
					<%
						String same = (String) request.getAttribute("same");
						if (same != null && same.equals("Yes")) {
					%>
					<div class="col-md-12">
						<div class="alert alert-danger" role="alert">
							<strong>Sorry!</strong> You can't transfer to your own account.
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