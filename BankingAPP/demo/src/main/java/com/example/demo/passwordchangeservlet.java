package com.example.demo;

import com.example.demo.database.DatabaseOperations;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "passwordchangeservlet", value = "/passwordchangeservlet")
public class passwordchangeservlet extends HttpServlet {
    boolean pass_wrong = false;
    public void doPost(HttpServletRequest request, HttpServletResponse response) {
        String password = request.getParameter("password");
        String newpassword = request.getParameter("newpassword");
        String username = request.getParameter("username");

        DatabaseOperations operations = null;
        try {
            operations = new DatabaseOperations();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        try {
            pass_wrong = operations.changePassword(username,password, newpassword);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if(pass_wrong){
           try {
               response.sendRedirect("change_password.jsp?success=true");
           } catch (IOException e) {
               throw new RuntimeException(e);
           }
       }
       else {
              try {
                response.sendRedirect("change_password.jsp?success=false");
              } catch (IOException e) {
                throw new RuntimeException(e);
              }
       }

    }
}
