<%@page import="com.example.demo.model.loansmodel"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.example.demo.model.usersmodel" %>
<%@ page import="com.example.demo.model.AccountModel" %>
<%@ page import="com.example.demo.database.DatabaseOperations" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Loan</title>
	<link rel="shortcut icon" type="image/png" href="image/favicon.png" />
	<link rel="stylesheet" type="text/css" href="css/deposit.css">
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<div class="row">
	<jsp:include page="header.jsp" />
</div>
<div class="container-fullwidth">
	<%
		usersmodel um = (usersmodel) session.getAttribute("userDetails");
		if (um != null) {
			DatabaseOperations operations = new DatabaseOperations();
			AccountModel am = operations.getAccount(um.getUser_id());
			List<loansmodel> loans = new ArrayList<>();
			loans = operations.getloandetails(am.getAccount_id());
	%>

	<div class="row" style="margin-top: 50px;">
		<div class="col-md-4 col-md-offset-4">
			<form method="post" action="LoanServlet" role="form">
			<h2>Loan Request</h2>
			<div class="col-md-12">
				<hr class="colorgraph">
			</div>
				<label class="col-md-4 control-label">Loan Type</label>
				<div class="col-sm-8 form-group">
					<input type="text" class="form-control" id="loanType" name="loan_type" placeholder="Enter loan type" required>
				</div>
				<label class="col-md-4 control-label">Loan Amount</label>
						<div class="col-sm-8 form-group">
							<input type="number" class="form-control" id="loanAmount" name="loan_amount" placeholder="Enter loan amount" min="1" required>
						</div>
						<label class="col-md-4 control-label">Interest Rate</label>
						<div class="col-sm-8 form-group">
							<input type="number" class="form-control" id="interestRate" name="interest_rate" placeholder="Enter interest rate" min="0" required>
						</div>
						<label class="col-md-4 control-label">Loan Term (months)</label>
						<div class="col-sm-8 form-group">
							<input type="number" class="form-control" id="loanTerm" name="loan_term" placeholder="Enter loan term" min="1" required>
						</div>
						<label class="col-md-4 control-label">Password</label>
						<div class="col-sm-8 form-group">
						<input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>
						</div>
					<!-- Add other necessary hidden fields (e.g., account number, user details) -->
					<input type="hidden" name="account_no" value="<%=am.getAccount_id()%>">
					<input type="hidden" name="first_name" value="<%=um.getFirst_name()%>">
					<input type="hidden" name="last_name" value="<%=um.getLast_name()%>">
					<input type="hidden" name="address" value="<%=um.getAddress()%>">
					<input type="hidden" name="email" value="<%=um.getEmail()%>">
					<input type="hidden" name="username" value="<%=um.getUsername()%>">
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
				%><%
				String eligible = (String) request.getAttribute("eligible");
				if (eligible != null && eligible.equals("No")) {
			%>
				<div class="col-md-12">
					<div class="alert alert-danger" role="alert">
						<strong>Sorry!</strong> You are not eligible for the new loan.Please pay your previous loan.
					</div>
				</div>
				<%
					}
				%><%
				String apply = (String) request.getAttribute("loan_amount");
				if (apply != null && apply.equals("Yes")) {
			%>
				<div class="col-md-12">
					<div class="alert alert-success" role="alert">
						<strong>Congrats</strong> Your loan has been approved and amount has been transfered into your account.
					</div>
				</div>
				<%
					}
				%>
				<div class="col-md-12">
					<hr class="colorgraph">
				</div>
				<div class="row col-md-10 col-md-offset-1">
					<div class="col-xs-6 col-md-6">
						<input type="submit" value="Send Loan Request"
							   class="btn btn-success btn-block btn-md" tabindex="7">
					</div>
					<div class="col-xs-6 col-md-6">
						<input class="btn btn-danger btn-block btn-md" type="reset"
							   value="Reset">
					</div>
				</div>

				<!-- End Loan Request Form -->
			</form>
		</div>
	</div>


	<!-- Loan Table -->
	<div class="row" style="margin-top: 50px;">
		<div class="col-md-10 col-md-offset-1">
			<h2>Loan Details</h2>
			<table class="table table-bordered">
				<thead>
				<tr>
					<th>Loan ID</th>
					<th>Loan Type</th>
					<th>Loan Amount</th>
					<th>paid amount</th>
					<th>Interest Rate</th>
					<th>Interest Amount</th>
					<th>Loan Term (Months)</th>
					<th>Approval Date</th>
					<th>Paid Date</th>
				</tr>
				</thead>
				<tbody>
				<% for (loansmodel loan : loans) { %>
				<tr>
					<td><%= loan.getLoan_id() %></td>
					<td><%= loan.getLoan_type() %></td>
					<td><%= loan.getLoan_amount() %></td>
					<td><%= loan.getPaid_amount() %></td>
					<td><%= loan.getInterest_rate() %></td>
					<td><%= loan.getInterest_amount() %></td>
					<td><%= loan.getLoan_term()%></td>
					<td><%= loan.getApproval_date()%></td>
					<td><%= loan.getPaid_date() %></td>
				</tr>
				<% } %>
				</tbody>
			</table>
		</div>
	</div>
	<!-- End Loan Table -->
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

<%! SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy"); %>

<%--<%--%>
<%--	public String formatDate(Date date) {--%>
<%--	return date != null ? dateFormat.format(date) : "";--%>
<%--	}--%>
<%--%>--%>
