package com.example.demo;

import com.example.demo.database.DatabaseOperations;
import com.example.demo.model.AccountModel;
import com.example.demo.model.usersmodel;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/BillPaidServlet")
public class BillPaidServlet extends HttpServlet {
    AccountModel ac =null;
    int account_id;
    String username;
    String password;
    String bill_type;
    float bill_amount;
    int bill_no;
    usersmodel um =null;
    DatabaseOperations operations;


    public void doPost(HttpServletRequest request, HttpServletResponse response){
        account_id = Integer.parseInt(request.getParameter("account_no"));
        username = request.getParameter("user_name");
        password = request.getParameter("password");
        bill_type = request.getParameter("billType");
        bill_amount = (float) Double.parseDouble(request.getParameter("bill_amount"));
        bill_no = Integer.parseInt(request.getParameter("bill_no"));

        try {
            operations = new DatabaseOperations();
            um = operations.getUser(username, password);
            if(um == null){
                request.setAttribute("isPassOK", "No");
                RequestDispatcher rd = request.getRequestDispatcher("bill.jsp");
                rd.forward(request, response);
            }
            else{
                boolean exist = operations.isbillexist(bill_no);
                if(!exist){
                    request.setAttribute("exist", "No");
                    RequestDispatcher rd = request.getRequestDispatcher("bill.jsp");
                    rd.forward(request, response);
                }
                else{
                    boolean ispaid = operations.isbillpaid(bill_no);
                    if(ispaid){
                        request.setAttribute("ispaid", "Yes");
                        RequestDispatcher rd = request.getRequestDispatcher("bill.jsp");
                        rd.forward(request, response);
                    }
                    else{
                        boolean duedate = operations.isDuedatepassed(bill_no);
                        if(duedate){
                            request.setAttribute("duedate", "Yes");
                            RequestDispatcher rd = request.getRequestDispatcher("bill.jsp");
                            rd.forward(request, response);
                        }
                        else{
                            float bill_balance = operations.getBillamount(bill_no);
                            if(bill_balance != bill_amount){
                                request.setAttribute("bill_balance", "Yes");
                                RequestDispatcher rd = request.getRequestDispatcher("bill.jsp");
                                rd.forward(request, response);
                            }
                            else{
                                float acc_balance = operations.getAccountbalance(account_id);
                                if(acc_balance < bill_amount){
                                    request.setAttribute("acc_balance", "Yes");
                                    RequestDispatcher rd = request.getRequestDispatcher("bill.jsp");
                                    rd.forward(request, response);
                                }
                                else{
                                    operations.paybill(bill_no,account_id,bill_amount);
                                    request.setAttribute("bill_pay","yes");
                                    RequestDispatcher rd = request.getRequestDispatcher("bill.jsp");
                                    rd.forward(request, response);
                                }

                            }

                        }

                    }

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }


    }
}
