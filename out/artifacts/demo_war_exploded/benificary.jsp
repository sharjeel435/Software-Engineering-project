<%@page import="java.util.List"%>
<%--<%@page import="com.example.demo.model.BeneficiaryModel"%>--%>
<%@page import="java.util.ArrayList"%>
<%@ page import="com.example.demo.model.AccountModel" %>
<%@ page import="com.example.demo.model.usersmodel" %>
<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="com.example.demo.database.DatabaseOperations" %>
<%@ page import="com.example.demo.model.beneficiariesmodel" %>

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
</head>
<body>
<div class="row">
    <jsp:include page="header.jsp" />
</div>
<div class="container-fullwidth">
    <%
        usersmodel um = null;
        AccountModel ac = null;

    %>
    <%
        um = (usersmodel) session.getAttribute("userDetails");
        if (um != null) {
            DatabaseOperations operations = new DatabaseOperations();
            ac = operations.getAccount(um.getUser_id());
            ArrayList<beneficiariesmodel> beneficiariesmodels = new ArrayList<>();
            beneficiariesmodels = operations.getBeneficiaries(ac.getAccount_id());
    %>
    <div class="row" style="margin-top: 50px;">
        <div class="col-md-4 col-md-offset-4">
            <!-- Beneficiary Form -->
            <form role="form" method="post" action="beneficiaryservlet">
                <h2>Add Beneficiary</h2>
                <div class="col-md-12">
                    <hr class="colorgraph">
                </div>
                <label class="col-md-4 control-label">Beneficiary Account No</label>
                <div class="col-sm-8 form-group">
                    <input type="number" pattern="[0-9]+" min="1" required placeholder="Enter Beneficiary Account No.."
                           name="beneficiary_account_no" class="form-control" >
                </div>
                <label class="col-md-4 control-label">Bank Name</label>
                <div class="col-sm-8 form-group">
                    <input type="text" required placeholder="Enter Beneficiary Name.."
                           name="bank_name" class="form-control">
                </div>
                <label class="col-md-4 control-label">Recipient Name</label>
                <div class="col-sm-8 form-group">
                    <input type="text" required placeholder="Enter Recipient Name"
                           name="recepient_name" class="form-control">
                </div>
                <label class="col-md-4 control-label">Enter Password</label>
                <div class="col-sm-8 form-group">
                    <input type="password" required placeholder="Enter Password"
                           name="password" class="form-control">
                </div>

                <label class="col-md-4 control-label">Choice</label>
                <div class="col-sm-8 form-group">
                    <input type="radio" name="beneficiary_type" value="ADD"><b> ADD</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="beneficiary_type" value="DELETE"><b> DELETE</b>
                 </div>
                <input type="hidden" name="user_id" value="<%=um.getUser_id()%>">
                <input type="hidden" name="user_name" value="<%=um.getUsername()%>">
                <input type="hidden" name="account_no" value="<%=ac.getAccount_id()%>">
                <input type="hidden" name="first_name" value="<%=um.getFirst_name()%>>">
                <input type="hidden" name="last_name" value="<%=um.getLast_name()%>">
                <input type="hidden" name="address" value="<%=um.getAddress()%>">
                <input type="hidden" name="email" value="<%=um.getEmail()%>">
                <div class="col-md-12">
                    <hr class="colorgraph">
                </div>
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
                    String exist = (String) request.getAttribute("exist");
                    if (exist != null && exist.equals("Yes")) {
                %>
                <div class="col-md-12">
                    <div class="alert alert-danger" role="alert">
                        <strong>Sorry!</strong> Beneficiary already exist.
                    </div>
                </div>
                <%
                    }
                %>
                <%
                    String exist1 = (String) request.getAttribute("exist");
                    if (exist1 != null && exist1.equals("No")) {
                %>
                <div class="col-md-12">
                    <div class="alert alert-success" role="alert">
                        <strong>Congrats</strong> Beneficiary added successfully.
                    </div>
                </div>
                <%
                    }
                %>
                <%
                    String notexist = (String) request.getAttribute("notexist");
                    if (notexist != null && notexist.equals("Yes")) {
                %>
                <div class="col-md-12">
                    <div class="alert alert-danger" role="alert">
                        <strong>Sorry!</strong> Beneficiary doesnot exist.
                    </div>
                </div>
                <%
                    }
                %>
                <%
                    String notexist1 = (String) request.getAttribute("notexist");
                    if (notexist1 != null && notexist1.equals("No")) {
                %>
                <div class="col-md-12">
                    <div class="alert alert-success" role="alert">
                        <strong>Sorry!</strong> Beneficiary Deleted successfully.
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
                        <strong>Sorry!</strong> You can't add your own account into beneficiary.
                    </div>
                </div>
                <%
                    }
                %>
                <div class="row col-md-10 col-md-offset-1">
                    <div class="col-xs-6 col-md-6">
                        <input type="submit" value="Add Beneficiary"
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

    <!-- Beneficiary Table -->
    <div class="row" style="margin-top: 50px;">
        <div class="col-md-8 col-md-offset-2">
            <h2>Beneficiaries</h2>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Recepient Name</th>
                    <th>Beneficiary Account No</th>
                    <th>Bank Name</th>
                </tr>
                </thead>
                <tbody>
                <% for (beneficiariesmodel beneficiary : beneficiariesmodels) { %>
                <tr>
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
        <div class="alert alert-warning col-md-4 col-md-offset-4"
             role="alert">
            <strong>Warning!</strong> You have to login first.
        </div>
    </div>

    <%
        }
    %>

    <!-- End Beneficiary Table -->

    <div class="row" style="margin-top: 50px;">
        <jsp:include page="footer.jsp"></jsp:include>
    </div>
</div>
</body>
</html>
