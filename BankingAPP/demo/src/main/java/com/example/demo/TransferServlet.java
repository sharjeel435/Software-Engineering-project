package com.example.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.example.demo.database.DatabaseOperations;
import com.example.demo.model.usersmodel;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class TransferServlet extends HttpServlet {
	int account_id;
	int target_account_id;
	String username;
	String password;
	float amount;
	usersmodel um = null;
	DatabaseOperations operations;
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		account_id = Integer.parseInt(request.getParameter("account_no"));
		target_account_id = Integer.parseInt(request.getParameter("target_acc_no"));
		username = request.getParameter("username");
		password = request.getParameter("password");
		amount = Float.parseFloat(request.getParameter("amount"));

		try {
			operations = new DatabaseOperations();
			um = operations.getUser(username, password);
			System.out.println(um);
			if(um == null){
				request.setAttribute("isPassOk","No");
				RequestDispatcher rd = request.getRequestDispatcher("transfer.jsp");
				rd.forward(request, response);
			}
			else{
				if(account_id == target_account_id){
					request.setAttribute("same","Yes");
					RequestDispatcher rd = request.getRequestDispatcher("transfer.jsp");
					rd.forward(request, response);
				}
				else {
					boolean isExist = operations.BeneficiaryExist(String.valueOf(target_account_id), account_id);
					if (!isExist) {
						request.setAttribute("isExist", "No");
						RequestDispatcher rd = request.getRequestDispatcher("transfer.jsp");
						rd.forward(request, response);
					} else {
						float balance = operations.getAccountbalance(account_id);
						if (balance < amount) {
							request.setAttribute("EnoughMoney", "No");
							RequestDispatcher rd = request.getRequestDispatcher("transfer.jsp");
							rd.forward(request, response);
						} else {
							operations.transfermoney(account_id, target_account_id, amount);
							request.setAttribute("amount", amount);
							RequestDispatcher rd = request.getRequestDispatcher("transfer_process.jsp");
							rd.forward(request, response);


						}

					}
				}

			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}


	}
}
