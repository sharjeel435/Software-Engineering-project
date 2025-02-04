package com.example.demo;

import com.example.demo.database.DatabaseOperations;
import com.example.demo.model.usersmodel;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "topupsservlet", value = "/topupsservlet")
public class topupsservlet extends HttpServlet {
    String mobile_number;
    float amount;
    String mobile_operator;
    String password;
    String username;
    int account_id;
    usersmodel um = null;
    DatabaseOperations operations;
    public void doPost(HttpServletRequest request, HttpServletResponse response){
        mobile_number = request.getParameter("mobile_number");
        amount = Float.parseFloat(request.getParameter("amount"));
        mobile_operator = request.getParameter("mobile_operator");
        password = request.getParameter("password");
        username = request.getParameter("username");
        account_id = Integer.parseInt(request.getParameter("account_no"));
        try {
            operations = new DatabaseOperations();
            um = operations.getUser(username, password);
            if(um == null){
                request.setAttribute("isPassOK", "No");
                RequestDispatcher rd = request.getRequestDispatcher("topups.jsp");
                rd.forward(request, response);
            }
            else {
                float balance = operations.getAccountbalance(account_id);
                if(balance < amount){
                    request.setAttribute("balance", "No");
                    RequestDispatcher rd = request.getRequestDispatcher("topups.jsp");
                    rd.forward(request, response);
                }
                else{
                    operations.insertintotopus(account_id,mobile_number,amount);
                    request.setAttribute("topup", "Yes");
                    RequestDispatcher rd = request.getRequestDispatcher("topups.jsp");
                    rd.forward(request, response);
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
