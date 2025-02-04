<%@page import="java.util.List"%>
<%--<%@page import="com.example.demo.model.TransactionModel"%>--%>
<%@page import="java.util.ArrayList"%>
<%@ page import="com.example.demo.model.AccountModel" %>
<%@ page import="com.example.demo.model.usersmodel" %>
<%@ page import="com.example.demo.model.transactionsmodel" %>
<%@ page import="com.example.demo.database.DatabaseOperations" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Transactions</title>
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
        DatabaseOperations operations = new DatabaseOperations();
        usersmodel user = null;
        AccountModel ac = null;
        user = (usersmodel) session.getAttribute("userDetails");
        if(user != null){
            ac = operations.getAccount(user.getUser_id());
            List<transactionsmodel> transactions = new ArrayList<>();
            transactions = operations.getTransactions(ac.getAccount_id());
    %>
    <div class="row" style="margin-top: 50px;">
        <div class="col-md-8 col-md-offset-2">
            <h2>Transaction History</h2>
            <h3>Balance: <%= ac.getBalance() %></h3>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Transaction ID</th>
                    <th>Transaction Type</th>
                    <th>Amount</th>
                    <th>Date</th>
                    <th>Description</th>
                </tr>
                </thead>
                <tbody>
                <% for (transactionsmodel transaction : transactions) { %>
                <tr>
                    <td><%= transaction.getTransaction_id() %></td>
                    <td style="color: <%= transaction.getTransaction_type().equalsIgnoreCase("Debit") ? "green" : "red" %>;">
                        <%= transaction.getTransaction_type() %>
                    </td>
                    <td><%= transaction.getAmount() %></td>
                    <td><%= transaction.getTransaction_date() %></td>
                    <td><%= transaction.getDescription() %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <% } else { %>
    <div class="row" style="margin-top: 150px;">
        <div class="alert alert-warning col-md-4 col-md-offset-4"
             role="alert">
            <strong>Warning!</strong> You have to login first.
        </div>
    </div>

    <% } %>

    <div class="row" style="margin-top: 50px;">
        <jsp:include page="footer.jsp"></jsp:include>
    </div>
</div>
</body>
</html>
