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

public class WithdrawServlet extends HttpServlet {
	int account_id;
	String username, password;
	boolean pass_wrong = false;
	float current_amount, withdraw_amount;
	AccountModel am = null;
	usersmodel um = null;
	DatabaseOperations operations;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		account_id = Integer.parseInt(request.getParameter("account_no"));
		username = request.getParameter("username");
		password = request.getParameter("password");
		withdraw_amount = Integer.parseInt(request.getParameter("amount"));

		try {
			operations = new DatabaseOperations();
			um = operations.getUser(username, password);
			if (um == null) {
				request.setAttribute("isPassOK", "No");
				RequestDispatcher rd = request.getRequestDispatcher("withdraw.jsp");
				rd.forward(request, response);
			} else {
				System.out.println("I am in");
				current_amount = operations.getAccountbalance(account_id);
				if (current_amount > withdraw_amount) {
					current_amount -= withdraw_amount;
					operations.insertintotransaction(account_id,"credit",withdraw_amount,"Cash Withdraw");
					request.setAttribute("withdraw", withdraw_amount);
					RequestDispatcher rd = request.getRequestDispatcher("Withdraw_process.jsp");
					rd.forward(request, response);
				} else {
					request.setAttribute("EnoughMoney", "No");
					RequestDispatcher rd = request.getRequestDispatcher("withdraw.jsp");
					rd.forward(request, response);
				}

			}

		} catch (SQLException ex) {
			throw new RuntimeException(ex);
		}
	}
}
