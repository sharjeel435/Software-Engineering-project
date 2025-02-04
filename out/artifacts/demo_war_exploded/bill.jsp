<%@page import="java.util.List"%>
<%--<%@page import="com.example.demo.model.BillModel"%>--%>
<%@page import="java.util.ArrayList"%>
<%@ page import="com.example.demo.model.usersmodel" %>
<%@ page import="com.example.demo.model.AccountModel" %>
<%@ page import="com.example.demo.model.beneficiariesmodel" %>
<%@ page import="com.example.demo.model.billmodel" %>
<%@ page import="javax.xml.crypto.Data" %>
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
        usersmodel um = null;
        AccountModel am = null;
        ArrayList<billmodel> bm = null;
    %>
    <%  um = (usersmodel)session.getAttribute("userDetails");
        if(um != null){
            DatabaseOperations db = new DatabaseOperations();
            am = db.getAccount(um.getUser_id());
            bm = db.getbilldetails(am.getAccount_id());
    %>
    <div class="row" style="margin-top: 50px;">
        <div class="col-md-4 col-md-offset-4">
            <!-- Beneficiary Form -->
            <form role="form" method="post" action="BillPaidServlet">
                <h2>Bill Payment</h2>
                <div class="col-md-12">
                    <hr class="colorgraph">
                </div>
                <label class="col-md-4 control-label">Bill No</label>
                <div class="col-sm-8 form-group">
                    <input type="text" required placeholder="Enter Bill no"
                           name="bill_no" class="form-control">
                </div>
                <label class="col-md-4 control-label">Bill Amount</label>
                <div class="col-sm-8 form-group">
                    <input type="number" step="any" required placeholder="Enter Bill Amount"
                           name="bill_amount" class="form-control" min="0">
                </div>
                <label class="col-md-4 control-label">Bill Type</label>
                <div class="col-sm-8 form-group">
                    <select name="billType" class="form-control" required>
                        <option value="electricity">Electricity</option>
                        <option value="water">Water</option>
                        <option value="creditCard">Credit Card</option>
                        <option value="Internet">Internet</option>
                        <option value="Gas">Gas</option>
                        <option value="Rent">Rent</option>
                        <option value="Telephone">Telephone</option>
                        <option value="Mobile">Mobile</option>
                        <option value="Insurance">Insurance</option>
                        <option value="Clothing">Clothing</option>
                        <option value="Medicine">Medicine</option>
                        <option value="Others">Others</option>
                        <!-- Add more options for other bill types -->
                    </select>
                </div>
                <label class="col-md-4 control-label">Password</label>
                <div class="col-sm-8 form-group">
                    <input type="password" required placeholder="Enter Password"
                           name="password" class="form-control">
                </div>
                <input type="hidden" name="user_id" value="<%=um.getUser_id()%>">
                <input type="hidden" name="user_name" value="<%=um.getUsername()%>">
                <input type="hidden" name="account_no" value="<%=am.getAccount_id()%>">
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
                    if (exist != null && exist.equalsIgnoreCase("No")) {
                %>
                <div class="col-md-12">
                    <div class="alert alert-danger" role="alert">
                        <strong>Sorry!</strong> Bill Number incorrect.
                    </div>
                </div>
                <%
                    }
                %>
                <%
                    String ispaid = (String) request.getAttribute("ispaid");
                    if (ispaid != null && ispaid.equalsIgnoreCase("Yes")) {
                %>
                <div class="col-md-12">
                    <div class="alert alert-danger" role="alert">
                        <strong>Sorry!</strong> Bill Already Paid.
                    </div>
                </div>
                <%
                    }
                %>
                <%
                    String duedate = (String) request.getAttribute("duedate");
                    if (duedate != null && duedate.equalsIgnoreCase("Yes")) {
                %>
                <div class="col-md-12">
                    <div class="alert alert-danger" role="alert">
                        <strong>Sorry!</strong> Bill Date Passed.
                    </div>
                </div>
                <%
                    }
                %>
                <%
                    String bal = (String) request.getAttribute("bill_balance");
                    if (bal != null && bal.equalsIgnoreCase("Yes")) {
                %>
                <div class="col-md-12">
                    <div class="alert alert-danger" role="alert">
                        <strong>Sorry!</strong> Bill Amount Does Not Match.
                    </div>
                </div>
                <%
                    }
                %>
                <%
                    String accbal = (String) request.getAttribute("acc_balance");
                    if (bal != null && bal.equalsIgnoreCase("Yes")) {
                %>
                <div class="col-md-12">
                    <div class="alert alert-danger" role="alert">
                        <strong>Sorry!</strong> Your Account Balance doesnot Match.
                    </div>
                </div>
                <%
                    }
                %>
                <%
                    String paybill = (String) request.getAttribute("bill_pay");
                    if (paybill != null && paybill.equalsIgnoreCase("Yes")) {
                %>
                <div class="col-md-12">
                    <div class="alert alert-success" role="alert">
                        <strong>Thank you</strong> Bill has been paid.
                    </div>
                </div>
                <%
                    }
                %>

                <div class="row col-md-10 col-md-offset-1">
                    <div class="col-xs-6 col-md-6">
                        <input type="submit" value="Pay Bill"
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

    <div class="row" style="margin-top: 50px;">
        <div class="col-md-8 col-md-offset-2">
            <h2>Bills</h2>
            <table class="table table-bordered">
                <thead>
                <tr><th>Bill No</th>
                    <th>Bill Type</th>
                    <th>Amount</th>
                    <th>Due Date</th>
                    <th>Paid Date</th>
                    <th>Paid</th>
                </tr>
                </thead>
                <tbody>
                <% for (billmodel bill : bm) { %>
                <tr>
                    <td><%=bill.getBill_no()%></td>
                    <td><%= bill.getBill_type() %></td>
                    <td><%= bill.getAmount_due() %></td>
                    <td><%= bill.getDue_date() %></td>
                    <td><%=bill.getPaid_date()%></td>
                    <td style="color: <%= bill.isPaid() == true ? "green" : "red" %>;">
                    <%= bill.isPaid() == true ? "Paid" : "Unpaid" %></td>

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
