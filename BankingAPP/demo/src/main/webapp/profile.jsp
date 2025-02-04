<%@page import="com.example.demo.database.DatabaseOperations"%>
<%@page import="com.example.demo.database.JDBC_Connect"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.example.demo.model.AccountModel"%>
<%@ page import="com.example.demo.model.usersmodel" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%!AccountModel ac;%>
	<%!usersmodel um;%>

<%
	um = (usersmodel) session.getAttribute("userDetails");
	int user_id = um.getUser_id();
	DatabaseOperations operations = new DatabaseOperations();
	ac = operations.getAccount(user_id);
%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=um.getFirst_name() + " " + um.getLast_name()%></title>
<link rel="shortcut icon" type="image/png" href="image/favicon.png" />
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="css/profile.css" rel="stylesheet">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="row">
		<jsp:include page="header.jsp" />
	</div>

	<div class="container-fullwidth">
		<div class="jumbotron col-md-6 col-md-offset-3"
			style="margin-top: 50px">
			<div class="row">
				<div class="profile-head col-md-10 col-md-offset-1">
					<div class="col-md-4 ">
						<img class="img-circle img-responsive" alt="" src="image/user.png">
					</div>


					<div class="col-md-6 ">
						<h2><%=um.getFirst_name() + " " + um.getLast_name()%></h2>
						<ul>
							<li class="navli"><span class="glyphicon glyphicon-home"></span>
								<%=um.getAddress()%></li>
							<li class="navli"><span class="glyphicon glyphicon-phone"></span><%=um.getPhone_number()%></li>
							<li class="navli"><span class="glyphicon glyphicon-envelope"></span><%=um.getEmail()%></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="account_details col-md-10 col-md-offset-1"
					style="margin-top: 30px;">
					<h2>Account Details</h2>
					<hr class="divider">
					<table class="table table-user-information col-md-6">
						<tbody>
							<tr>
								<td><b>First Name:</b></td>
								<td><%=um.getFirst_name()%></td>
							</tr>
							<tr>
								<td><b>Last Name:</b></td>
								<td><%=um.getLast_name()%></td>
							</tr>
							<tr>
								<td><b>Account Number:</b></td>
								<td><%=ac.getAccount_id()%></td>
							</tr>
							<tr>
								<td><b>Address</b></td>
								<td><%=um.getAddress()%></td>
							</tr>
							<tr>
								<td><b>UserName</b></td>
								<td><%=um.getUsername()%></td>
							</tr>
							<tr>
								<td><b>Phone Number</b></td>
								<td><%=um.getPhone_number()%></td>
							</tr>
							<tr>
								<td><b>Email</b></td>
								<td><a href="mailto:" +<%=um.getEmail()%>><%=um.getEmail()%></a></td>
							</tr>
							<tr>
								<td><b>Account Type</b></td>
								<td><%=ac.getAccount_type()%></td>
							</tr>
							<tr>
								<td><b>Registration Date</b></td>
								<td><%=ac.getOpen_date()%></td>
							</tr>
							<tr>
								<td><b>Amount</b></td>
								<td>RS: <%=ac.getBalance()%></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<div class="row"></div>

		<!-- Footer start here -->
		<div class="row" style="margin-top: 50px;">
			<jsp:include page="footer.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>