package com.example.demo.database;

import java.beans.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBC_Connect {
	private Connection connection = null;

	public Connection getConnection() throws SQLException {
		try {

			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankappdb?useSSL=false", "root", "fast");

		} catch (ClassNotFoundException e) {

			System.out.println("Where is your Oracle JDBC Driver?");
			e.printStackTrace();

		}

		return connection;

	}

}
