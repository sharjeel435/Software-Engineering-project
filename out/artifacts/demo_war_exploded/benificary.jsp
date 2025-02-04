<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.example.demo.model.AccountModel"%>
<%@page import="com.example.demo.model.usersmodel"%>
<%@page import="com.example.demo.database.DatabaseOperations"%>
<%@page import="com.example.demo.model.beneficiariesmodel"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Add Beneficiary</title>
    <link rel="shortcut icon" type="image/png" href="image/favicon.png" />
    <link rel="stylesheet" type="text/css" href="css/deposit.css">
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>

    <style>
        /* Background */
        body {
            background: linear-gradient(135deg, #e0eafc, #cfdef3);
            font-family: 'Arial', sans-serif;
            color: #333;
            margin: 0;
            padding: 0;
        }

        /* Form Container */
        .form-container {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 20px;
        }

        /* Table */
        .table-container {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 20px;
        }

        /* Header Titles */
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

        /* Buttons */
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

        /* Alerts */
        .alert {
            border-radius: 5px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .form-container, .table-container {
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
        AccountModel ac = null;
        um = (usersmodel) session.getAttribute("userDetails");
        if (um != null) {
            DatabaseOperations operations = new DatabaseOperations();
            ac = operations.getAccount(um.getUser_id());
            ArrayList<beneficiariesmodel> beneficiariesmodels = new ArrayList<>();
            beneficiariesmodels = operations.getBeneficiaries(ac.getAccount_id());
    %>

    <!-- Success or Error Message -->
    <%
        String message = (String) request.getAttribute("message");
        String messageType = (String) request.getAttribute("messageType"); // 'success' or 'error'
        if (message != null) {
    %>
    <div class="alert <%= messageType != null && messageType.equals("success") ? "alert-success" : "alert-danger" %>" role="alert">
        <%= message %>
    </div>
    <%
        }
    %>

    <!-- Beneficiary Form -->
    <div class="row" style="margin-top: 50px;">
        <div class="col-md-4 col-md-offset-4 form-container">
            <form role="form" method="post" action="beneficiaryservlet">
                <h2 class="text-center">Add Beneficiary</h2>
                <div class="col-md-12">
                    <hr class="colorgraph">
                </div>
                <div class="form-group row">
                    <label class="col-md-4 control-label text-right">Beneficiary Acc No</label>
                    <div class="col-md-8">
                        <input type="number" pattern="[0-9]+" min="1" required placeholder="Enter Account No.."
                               name="beneficiary_account_no" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-md-4 control-label text-right">Bank Name</label>
                    <div class="col-md-8">
                        <input type="text" required placeholder="Enter Bank Name.." name="bank_name" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-md-4 control-label text-right">Recipient Name</label>
                    <div class="col-md-8">
                        <input type="text" required placeholder="Enter Recipient Name" name="recepient_name" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-md-4 control-label text-right">Enter Password</label>
                    <div class="col-md-8">
                        <input type="password" required placeholder="Enter Password" name="password" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-md-4 control-label text-right">Choice</label>
                    <div class="col-md-8">
                        <input type="radio" name="beneficiary_type" value="ADD"><b> ADD</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="beneficiary_type" value="DELETE"><b> DELETE</b>
                    </div>
                </div>
                <input type="hidden" name="user_id" value="<%=um.getUser_id()%>">
                <input type="hidden" name="user_name" value="<%=um.getUsername()%>">
                <input type="hidden" name="account_no" value="<%=ac.getAccount_id()%>">
                <div class="col-md-12">
                    <hr class="colorgraph">
                </div>
                <div class="row col-md-12 text-center">
                    <div class="col-xs-6">
                        <input type="submit" value="Process" class="btn btn-success btn-block btn-md">
                    </div>
                    <div class="col-xs-6">
                        <input class="btn btn-danger btn-block btn-md" type="reset" value="Reset">
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Beneficiary Table -->
    <div class="row" style="margin-top: 50px;">
        <div class="col-md-8 col-md-offset-2 table-container">
            <h2 class="text-center">Beneficiaries</h2>
            <table class="table table-bordered">
                <thead>
                <tr class="text-center">
                    <th>Recipient Name</th>
                    <th>Beneficiary Account No</th>
                    <th>Bank Name</th>
                </tr>
                </thead>
                <tbody>
                <% for (beneficiariesmodel beneficiary : beneficiariesmodels) { %>
                <tr class="text-center">
                    <td><%=beneficiary.getRecipient_name()%></td>
                    <td><%= beneficiary.getAccount_number() %></td>
                    <td><%= beneficiary.getBank_name() %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <%
    } else {
    %>
    <div class="row" style="margin-top: 150px;">
        <div class="alert alert-warning col-md-4 col-md-offset-4" role="alert">
            <strong>Warning!</strong> You have to login first.
        </div>
    </div>
    <%
        }
    %>

    <div class="row" style="margin-top: 50px;">
        <jsp:include page="footer.jsp"></jsp:include>
    </div>
</div>
</body>
</html>
