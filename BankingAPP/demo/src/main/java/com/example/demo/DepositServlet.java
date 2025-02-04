package com.example.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.example.demo.database.DatabaseOperations;
import com.example.demo.model.AccountModel;
import com.example.demo.model.usersmodel;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.example.demo.database.JDBC_Connect;

public class DepositServlet extends HttpServlet {
	int account_id;
	String username, password;
	String choice;
	boolean pass_wrong = false;
	int current_amount, deposit_amount;
	DatabaseOperations operations ;
	usersmodel um = null;
	AccountModel am = null;
	int user_id ;
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		account_id = Integer.parseInt(request.getParameter("account_no"));
		username = request.getParameter("username");
		password = request.getParameter("password");
		//user_id = Integer.parseInt(request.getParameter("user_id"));
		deposit_amount = Integer.parseInt(request.getParameter("amount"));
		choice = request.getParameter("deposit_type");
		try {
			operations = new DatabaseOperations();
			um = operations.getUser(username, password);
			if (um == null) {
				request.setAttribute("isPassOK", "No");
				RequestDispatcher rd = request.getRequestDispatcher("deposit.jsp");
				rd.forward(request, response);
			} else {
				if (choice.equalsIgnoreCase("Cash deposit")) {
					operations.insertintotransaction(account_id, "debit", deposit_amount, "Cash Deposit");
					request.setAttribute("deposit", deposit_amount);
					RequestDispatcher rd = request.getRequestDispatcher("Deposit_process.jsp");
					rd.forward(request, response);
				} else if (choice.equalsIgnoreCase("Loan deposit")) {
					operations.insertintotransaction(account_id, "debit", deposit_amount, "LoanPayment");
					request.setAttribute("deposit", deposit_amount);
					RequestDispatcher rd = request.getRequestDispatcher("Deposit_process.jsp");
					rd.forward(request, response);
				}
			}
		} catch (SQLException ex) {
			throw new RuntimeException(ex);
		}
	}

}
