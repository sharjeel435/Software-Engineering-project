package com.example.demo;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.Random;

import com.example.demo.database.DatabaseOperations;
import com.example.demo.model.AccountModel;
import com.example.demo.model.usersmodel;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import static java.lang.Double.parseDouble;

public class CreateAccountServlet extends HttpServlet {
	String first_name;
	String last_name;
	String email;
	String password;
	String address;
	Date dob;
	String username;
	String phone;
	String AccountType;
	float openingBalance;
	DatabaseOperations operations;
	usersmodel user=null;
	AccountModel am=null;

	public void doPost(HttpServletRequest request,HttpServletResponse response){
		first_name = request.getParameter("first_name");
		last_name = request.getParameter("last_name");
		address = request.getParameter("address");
		dob = Date.valueOf(request.getParameter("Date"));
		username = request.getParameter("username");
		email = request.getParameter("email");
		password = request.getParameter("password");
		phone = request.getParameter("phone");
		AccountType = request.getParameter("account_type");
		openingBalance = Float.parseFloat(request.getParameter("amount"));

		try {
			operations = new DatabaseOperations();
			boolean isusername = operations.isuserexist(username);
			if(isusername){
				request.setAttribute("user","yes");
				RequestDispatcher rd = request.getRequestDispatcher("create_account.jsp");
				rd.forward(request, response);
			}
			else{
				boolean isemail = operations.isemailexist(email);
				if(isemail){
					request.setAttribute("email","yes");
					RequestDispatcher rd = request.getRequestDispatcher("create_account.jsp");
					rd.forward(request, response);
				}
				else{
					LocalDate date = LocalDate.now();
					Period age = Period.between(dob.toLocalDate(), date);
					if(age.getYears()<18){
						request.setAttribute("age","yes");
						RequestDispatcher rd = request.getRequestDispatcher("create_account.jsp");
						rd.forward(request, response);
					}
					else{
						operations.insertintousers(username,password,first_name,last_name,dob,email,phone,address);
						user = operations.getUser(username,password);
						operations.insertintoaccounts(user.getUser_id(),AccountType,0);
						am = operations.getAccount(user.getUser_id());
						operations.insertintotransaction(am.getAccount_id(),"Debit",openingBalance,"Opening Balance");
						request.setAttribute("account",am);
						RequestDispatcher rd = request.getRequestDispatcher("create_account_progress.jsp");
						rd.forward(request, response);


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
