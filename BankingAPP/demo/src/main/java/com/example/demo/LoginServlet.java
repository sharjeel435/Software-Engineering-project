package com.example.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.example.demo.database.DatabaseOperations;
import com.example.demo.model.usersmodel;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.example.demo.database.JDBC_Connect;


public class LoginServlet extends HttpServlet {
	String UserName, password;
	usersmodel um = null;
	boolean pass_wrong = false;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UserName = request.getParameter("UserName");
		password = request.getParameter("password");

		System.out.println(UserName);
		System.out.println(password);

		try {
			DatabaseOperations operations = new DatabaseOperations();
			um = operations.getUser(UserName, password);
			if (um == null) {
				request.setAttribute("isPassOK", "No");
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
				rd.forward(request, response);
			} else {
					// Setting Session variable for current User
					HttpSession session = request.getSession();
					session.setAttribute("userDetails", um);
					RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
					rd.forward(request, response);

				}
			} catch (SQLException ex) {
            throw new RuntimeException(ex);
        }

    }
	}

