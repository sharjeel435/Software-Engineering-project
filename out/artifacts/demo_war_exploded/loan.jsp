<%@page import="com.example.demo.model.loansmodel"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.model.usersmodel" %>
<%@ page import="com.example.demo.model.AccountModel" %>
<%@ page import="com.example.demo.database.DatabaseOperations" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Loan Request</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <style>
        body {
            background: linear-gradient(135deg, #e0eafc, #cfdef3);
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .form-container {
            max-width: 350px;
            margin: 50px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 10px;
        }

        .blue-line {
            height: 4px;
            width: 100%;
            background: linear-gradient(to right, #0dcaf0, #6610f2, #0d6efd);
            border-radius: 4px;
            margin: 10px 0;
        }

        .form-group {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .form-group label {
            flex: 1;
            font-weight: bold;
            color: #555;
        }

        .form-group input,
        .form-group select {
            flex: 2;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-group input::placeholder,
        .form-group select::placeholder {
            font-size: 16px;
            color: #999;
        }

        .text-center {
            text-align: center;
        }

        .btn-success,
        .btn-danger {
            width: 120px;
            padding: 10px;
            font-size: 16px;
            border-radius: 4px;
        }

        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
            color: white;
            margin-right: 10px;
        }

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
            color: white;
        }

        .table-container {
            max-width: 90%;
            margin: 30px auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        .table-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            text-align: center;
            padding: 10px;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #f2f2f2;
        }

        table tfoot {
            background-color: #f9f9f9;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="row">
    <jsp:include page="header.jsp" />
</div>

<div class="container">
    <%
        usersmodel um = (usersmodel) session.getAttribute("userDetails");
        if (um != null) {
            DatabaseOperations operations = new DatabaseOperations();
            AccountModel am = operations.getAccount(um.getUser_id());
            List<loansmodel> loans = operations.getloandetails(am.getAccount_id());
            boolean hasUnpaidLoan = loans.stream().anyMatch(loan -> loan.getPaid_amount() < loan.getLoan_amount());
            boolean isNewUser = loans.isEmpty();
    %>

    <!-- Display warning if unpaid loans exist -->
    <% if (hasUnpaidLoan) { %>
    <div class="alert alert-danger text-center">
        <strong>Warning!</strong> You have unpaid loans. Please clear them before requesting a new loan.
    </div>
    <% } else if (isNewUser) { %>
    <div class="alert alert-info text-center">
        <strong>Info:</strong> Welcome! This is your first time applying for a loan.
    </div>
    <% } %>

    <!-- Loan Request Form -->
    <div class="form-container">
        <form method="post" action="LoanServlet">
            <h2>Loan Request</h2>
            <div class="blue-line"></div>

            <div class="form-group">
                <label>Loan Type</label>
                <input type="text" name="loan_type" placeholder="Enter loan type" required>
            </div>
            <div class="form-group">
                <label>Loan Amount</label>
                <input type="number" name="loan_amount" placeholder="Enter loan amount" min="1" required>
            </div>
            <div class="form-group">
                <label>Interest Rate</label>
                <input type="number" name="interest_rate" placeholder="Enter interest rate" min="0" required>
            </div>
            <div class="form-group">
                <label>Loan Term (Months)</label>
                <input type="number" name="loan_term" placeholder="Enter loan term" min="1" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter password" required>
            </div>

            <!-- Hidden inputs -->
            <input type="hidden" name="account_no" value="<%=am.getAccount_id()%>">
            <input type="hidden" name="first_name" value="<%=um.getFirst_name()%>">
            <input type="hidden" name="last_name" value="<%=um.getLast_name()%>">
            <input type="hidden" name="address" value="<%=um.getAddress()%>">
            <input type="hidden" name="email" value="<%=um.getEmail()%>">
            <input type="hidden" name="username" value="<%=um.getUsername()%>">

            <div class="blue-line"></div>

            <div class="text-center">
                <input type="submit" value="Request Loan" class="btn btn-success">
                <input type="reset" value="Reset" class="btn btn-danger">
            </div>
        </form>
    </div>

    <!-- Loan Details Table -->
    <div class="table-container">
        <h2>Loan Details</h2>
        <table>
            <thead>
            <tr>
                <th>Loan ID</th>
                <th>Loan Type</th>
                <th>Loan Amount</th>
                <th>Paid Amount</th>
                <th>Interest Rate</th>
                <th>Interest Amount</th>
                <th>Loan Term</th>
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
                <td><%= loan.getLoan_term() %></td>
                <td><%= loan.getApproval_date() %></td>
                <td><%= loan.getPaid_date() %></td>
            </tr>
            <% } %>
            </tbody>
            <tfoot>
            <tr>
                <td colspan="9">Total Loans: <%= loans.size() %></td>
            </tr>
            </tfoot>
        </table>
    </div>

    <%
    } else {
    %>
    <div class="alert alert-warning text-center" style="margin-top: 150px;">
        <strong>Warning!</strong> You need to log in first.
    </div>
    <%
        }
    %>
</div>

<div class="row">
    <jsp:include page="footer.jsp" />
</div>

</body>
</html>
