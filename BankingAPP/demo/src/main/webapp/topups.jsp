<%@page import="java.util.List"%>
<%--<%@page import="com.example.demo.model.BillModel"%>--%>
<%@page import="java.util.ArrayList"%>
<%@ page import="com.example.demo.model.AccountModel" %>
<%@ page import="com.example.demo.model.usersmodel" %>
<%@ page import="com.example.demo.database.DatabaseOperations" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Bills</title>
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
            AccountModel ac = null;
            usersmodel um = null;
            um = (usersmodel) session.getAttribute("userDetails");
            if(um != null){
                DatabaseOperations operations = new DatabaseOperations();
                ac = operations.getAccount(um.getUser_id());
        %>
    <div class="row" style="margin-top: 50px;">
        <div class="col-md-4 col-md-offset-4">
            <!-- Beneficiary Form -->
            <form role="form" method="post" action="topupsservlet">
                <h2>Mobile Top-UP</h2>
                <div class="col-md-12">
                    <hr class="colorgraph">
                </div>
                <label class="col-md-4 control-label">Mobile Number</label>
                <div class="col-sm-8 form-group">
                    <input type="number" required placeholder="Enter Mobile Number"
                           name="mobile_number" class="form-control" min="10000000000" max="99999999999">
                </div>
                <label class="col-md-4 control-label">Amount</label>
                <div class="col-sm-8 form-group">
                    <input type="number" step="any" required placeholder="Enter Amount"
                           name="amount" class="form-control" min="1">
                </div>
                <label class="col-md-4 control-label">Mobile Operator</label>
                <div class="col-sm-8 form-group">
                    <select name="mobile_operator" class="form-control" required>
                        <option value="electricity">UFONE</option>
                        <option value="water">JAZZ</option>
                        <option value="creditCard">ZONG</option>
                        <option value="Internet">WARID</option>
                        <option value="Gas">NCOM</option>
                        <!-- Add more options for other bill types -->
                    </select>
                </div>
                <label class="col-md-4 control-label">Password</label>
                <div class="col-sm-8 form-group">
                    <input type="password" required placeholder="Enter Password"
                           name="password" class="form-control">
                </div>

                <input type="hidden" name="account_no" value="<%=ac.getAccount_id()%>">
                <input type="hidden" name="first_name" value="<%=um.getFirst_name()%>">
                <input type="hidden" name="last_name" value="<%=um.getLast_name()%>">
                <input type="hidden" name="address" value="<%=um.getAddress()%>">
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
                %>
                <%
                    String balance = (String) request.getAttribute("balance");
                    if (balance != null && balance.equals("No")) {
                %>
                <div class="col-md-12">
                    <div class="alert alert-danger" role="alert">
                        <strong>Sorry!</strong> You have insufficient balance.
                    </div>
                </div>
                <%
                    }
                %>
                <%
                    String top = (String) request.getAttribute("topup");
                    if (top != null && top.equals("Yes")) {
                %>
                <div class="col-md-12">
                    <div class="alert alert-success" role="alert">
                        <strong>Transaction Complete</strong> Topup has been transfer.
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
                        <input type="submit" value="TOP-UP"
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
    <%} else { %>
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
