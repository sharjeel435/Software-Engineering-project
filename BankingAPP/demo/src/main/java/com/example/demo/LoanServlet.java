package com.example.demo;

import java.io.IOException;
import java.sql.SQLException;

import com.example.demo.model.AccountModel;
import com.example.demo.model.usersmodel;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.demo.database.DatabaseOperations;

public class LoanServlet extends HttpServlet
{
	int account_id;
	String username, password;
	usersmodel um = null;
	AccountModel am = null;
	DatabaseOperations operations;
	String loan_type;
	float loan_amount;
	float interest_rate;
	int loan_duration;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		account_id = Integer.parseInt(request.getParameter("account_no"));
		username = request.getParameter("username");
		password = request.getParameter("password");
		loan_type = request.getParameter("loan_type");
		loan_amount = (float) Double.parseDouble(request.getParameter("loan_amount"));
		interest_rate = (float) Double.parseDouble(request.getParameter("interest_rate"));
		loan_duration = (int) Double.parseDouble(request.getParameter("loan_term"));
		try {
			operations = new DatabaseOperations();
			um = operations.getUser(username, password);
			if(um == null){
				request.setAttribute("isPassOK", "No");
				RequestDispatcher rd = request.getRequestDispatcher("loan.jsp");
				rd.forward(request, response);
			}
			else{
				boolean eligible = operations.isEligibleforloan(account_id);
				if(!eligible){
					request.setAttribute("eligible", "No");
					RequestDispatcher rd = request.getRequestDispatcher("loan.jsp");
					rd.forward(request, response);
				}
				else{
					operations.applyforloan(account_id,loan_type,loan_amount,interest_rate,loan_duration);
					request.setAttribute("loan_amount","Yes");
					RequestDispatcher rd = request.getRequestDispatcher("loan.jsp");
					rd.forward(request, response);
				}


			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

	}

}
