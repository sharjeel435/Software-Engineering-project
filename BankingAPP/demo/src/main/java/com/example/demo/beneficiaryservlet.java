package com.example.demo;

import com.example.demo.database.DatabaseOperations;
import com.example.demo.model.AccountModel;
import com.example.demo.model.usersmodel;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/beneficiaryservlet")
public class beneficiaryservlet extends HttpServlet {
    int account_no;
    int user_id;
    String username;
    String password;
    String recepient_name;
    String beneficiary_account_no;
    String beneficiary_bank_name;
    String choice;
    AccountModel am;
    usersmodel um =null;
    DatabaseOperations operations;
    public void doPost(HttpServletRequest request, HttpServletResponse response) {
        account_no = Integer.parseInt(request.getParameter("account_no"));
        System.out.println(account_no);
        user_id = Integer.parseInt(request.getParameter("user_id"));
        System.out.println(user_id);
        password = request.getParameter("password");
        recepient_name = request.getParameter("recepient_name");
        beneficiary_account_no = request.getParameter("beneficiary_account_no");
        beneficiary_bank_name = request.getParameter("bank_name");
        choice = request.getParameter("beneficiary_type");
        username = request.getParameter("user_name");

        try {
            operations = new DatabaseOperations();
            um = operations.getUser(username, password);
            if (um == null) {
                request.setAttribute("isPassOK", "No");
                RequestDispatcher rd = request.getRequestDispatcher("benificary.jsp");
                rd.forward(request, response);
            }
            else {
                if(String.valueOf(account_no).equals(beneficiary_account_no)) {
                    request.setAttribute("same", "Yes");
                    RequestDispatcher rd = request.getRequestDispatcher("benificary.jsp");
                    rd.forward(request, response);
                }
                else {
                    if (choice.equalsIgnoreCase("add")) {
                        boolean exist = operations.BeneficiaryExist(beneficiary_account_no, account_no);
                        if (exist) {
                            request.setAttribute("exist", "Yes");
                            RequestDispatcher rd = request.getRequestDispatcher("benificary.jsp");
                            rd.forward(request, response);
                        } else {
                            request.setAttribute("exist", "No");
                            operations.addBeneficiary(user_id, account_no, recepient_name, beneficiary_account_no, beneficiary_bank_name);
                            RequestDispatcher rd = request.getRequestDispatcher("benificary.jsp");
                            rd.forward(request, response);

                        }
                    } else if (choice.equalsIgnoreCase("delete")) {
                        boolean exist = operations.BeneficiaryExist(beneficiary_account_no, account_no);
                        if (!exist) {
                            request.setAttribute("notexist", "Yes");
                            RequestDispatcher rd = request.getRequestDispatcher("benificary.jsp");
                            rd.forward(request, response);
                        } else {
                            request.setAttribute("notexist", "No");
                            operations.deleteBeneficiary(beneficiary_account_no, account_no);
                            RequestDispatcher rd = request.getRequestDispatcher("benificary.jsp");
                            rd.forward(request, response);

                        }
                    }
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }



    }
}
