package com.example.demo.database;

import com.example.demo.model.*;

import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class DatabaseOperations {
    Connection conn ;

    public DatabaseOperations() throws SQLException {
        JDBC_Connect connect = new JDBC_Connect();
        conn = connect.getConnection();
    }
    public usersmodel getUser(String username, String password) throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select * from users where username='" + username + "' and password='" + password + "'");
        if (!rs.isBeforeFirst()) {
            return null;
        } else {
            rs.next();
            usersmodel user = new usersmodel(rs.getInt("user_id"), rs.getString("username"), rs.getString("password"), rs.getString("first_name"), rs.getString("last_name"), rs.getDate("date_of_birth"), rs.getString("email"), rs.getString("phone"), rs.getString("address"));
            return user;
        }
    }
    public AccountModel getAccount(int user_id) throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select * from accounts where user_id='" + user_id + "'");
        if (!rs.isBeforeFirst()) {
            return null;
        } else {
            rs.next();
            AccountModel account = new AccountModel(rs.getInt("account_id"), rs.getInt("user_id"), rs.getString("account_type"), rs.getFloat("balance"), rs.getDate("open_date"));
            return account;
        }
    }

    public boolean changePassword(String username, String password, String newpassword) throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select * from users where username='" + username + "' and password='" + password + "'");
        if (!rs.isBeforeFirst()) {
            return false;
        } else {
            stmt.executeUpdate("update users set password='" + newpassword + "' where username='" + username + "'");
            return true;
        }
    }

    public float getAccountbalance(int account_id) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{? = call getAccountBalance(?)}");
        stmt.setInt(2, account_id);
        stmt.registerOutParameter(1, Types.FLOAT);
        stmt.execute();
        float balance = stmt.getFloat(1);

        return balance;
    }

    public ArrayList<transactionsmodel> getTransactions(int account_id) throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select * from transactions where account_id='" + account_id + "'");
        ArrayList<transactionsmodel> transactions = new ArrayList<transactionsmodel>();
        while (rs.next()) {
            transactionsmodel transaction = new transactionsmodel(rs.getInt("transaction_id"), rs.getInt("account_id"), rs.getString("transaction_type"),  rs.getDate("transaction_date"), rs.getFloat("amount"), rs.getString("description"));
            transactions.add(transaction);
        }
        return transactions;
    }
    public void insertintotransaction (int account_id, String transaction_type, float amount, String description) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{call InsertTransaction(?,?,?,?)}");
        stmt.setInt(1, account_id);
        stmt.setString(2, transaction_type);
        stmt.setFloat(3, amount);
        stmt.setString(4, description);
        stmt.execute();
    }
    public ArrayList<beneficiariesmodel> getBeneficiaries(int account_id) throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select * from beneficiaries where account_id='" + account_id + "'");
        ArrayList<beneficiariesmodel> beneficiaries = new ArrayList<beneficiariesmodel>();
        while (rs.next()) {
            beneficiariesmodel beneficiary = new beneficiariesmodel(rs.getInt("beneficiary_id"), rs.getInt("user_id"), rs.getInt("account_id"),rs.getString("recipient_name"), rs.getString("account_number"), rs.getString("bank_name"));
            beneficiaries.add(beneficiary);
        }
        return beneficiaries;
    }
    public boolean BeneficiaryExist(String account_number , int account_id) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{? = call  BeneficiaryExists(?,?)}");
        stmt.setString(2, account_number);
        stmt.setInt(3, account_id);
        stmt.registerOutParameter(1, Types.BOOLEAN);
        stmt.execute();
        boolean exists = stmt.getBoolean(1);
        System.out.println(exists);
        return exists;
    }
    public void addBeneficiary(int user_id, int account_id, String recipient_name, String account_number, String bank_name) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{call AddBeneficiary(?,?,?,?,?)}");
        stmt.setInt(1, user_id);
        stmt.setInt(2, account_id);
        stmt.setString(3, recipient_name);
        stmt.setString(4, account_number);
        stmt.setString(5, bank_name);
        stmt.execute();
    }
    public void deleteBeneficiary(String account_number, int account_id) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{call DeleteBeneficiary(?,?)}");
        stmt.setString(1, account_number);
        stmt.setInt(2, account_id);
        stmt.execute();
    }
    public boolean isbillexist(int billno) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{? = call CheckBillNoExists(?)}");
        stmt.setInt(2, billno);
        stmt.registerOutParameter(1,Types.BOOLEAN);
        stmt.execute();
        boolean exists = stmt.getBoolean(1);
        return exists;
    }
    public boolean isbillpaid(int billno) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{? = call CheckBillPaid(?)}");
        stmt.setInt(2, billno);
        stmt.registerOutParameter(1,Types.BOOLEAN);
        stmt.execute();
        boolean exists = stmt.getBoolean(1);
        return exists;
    }
    public boolean isDuedatepassed(int billno) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{? = call  CheckDueDatePassed(?)}");
        stmt.setInt(2, billno);
        stmt.registerOutParameter(1,Types.BOOLEAN);
        stmt.execute();
        boolean exists = stmt.getBoolean(1);
        return exists;
    }
    public float getBillamount(int billno) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{? = call  GetBillAmount(?)}");
        stmt.setInt(2, billno);
        stmt.registerOutParameter(1,Types.FLOAT);
        stmt.execute();
        float amount = stmt.getFloat(1);
        return amount;
    }
    public ArrayList<billmodel> getbilldetails(int account_id) throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select * from bills where account_id='" + account_id + "'");
        ArrayList<billmodel> bills = new ArrayList<billmodel>();
        while (rs.next()) {
            billmodel bill = new billmodel(rs.getInt("billpaid_id"), rs.getInt("bill_no"),rs.getInt("account_id"),rs.getString("bill_type"),rs.getFloat("amount_due"),rs.getDate("due_date"),rs.getDate("paid_date"),rs.getBoolean("paid"));
            bills.add(bill);
        }
        return bills;
    }
    public void paybill(int billno, int account_id , float amount) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{call PayBillByBillNo(?,?,?)}");
        stmt.setInt(1, billno);
        stmt.setInt(2, account_id);
        stmt.setFloat(3, amount);
        stmt.execute();
    }
    public ArrayList<loansmodel> getloandetails(int account_id) throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select * from loans where account_id='" + account_id + "'");
        ArrayList<loansmodel> loans = new ArrayList<loansmodel>();
        while (rs.next()) {
            loansmodel loan = new loansmodel(rs.getInt("loan_id"), rs.getInt("account_id"), rs.getString("loan_type"), rs.getFloat("loan_amount"), rs.getFloat("interest_amount"), rs.getFloat("paid_amount"),rs.getFloat("interest_rate"), rs.getInt("loan_term"), rs.getDate("approval_date"), rs.getDate("paid_date"));
            loans.add(loan);
        }
        return loans;
    }
    public boolean isEligibleforloan(int account_id) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{? = call  CheckLoanEligibility(?)}");
        stmt.setInt(2, account_id);
        stmt.registerOutParameter(1,Types.BOOLEAN);
        stmt.execute();
        boolean exists = stmt.getBoolean(1);
        return exists;
    }
    public void applyforloan(int account_id,String loan_type,float loan_amount,float interest_rate,int loan_term) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{call ApplyForLoan(?,?,?,?,?)}");
        stmt.setInt(1, account_id);
        stmt.setString(2, loan_type);
        stmt.setFloat(3, loan_amount);
        stmt.setFloat(4, interest_rate);
        stmt.setInt(5, loan_term);
        stmt.execute();
    }
    public void insertintotopus(int account_id, String mobile_number, float amount) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{call MobileTopUp(?,?,?)}");
        stmt.setInt(1, account_id);
        stmt.setString(2, mobile_number);
        stmt.setFloat(3, amount);
        stmt.execute();
    }
    public void transfermoney(int from_account,int to_account, float amount) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{call TransferMoney(?,?,?)}");
        stmt.setInt(1, from_account);
        stmt.setInt(2, to_account);
        stmt.setFloat(3, amount);
        stmt.execute();
    }

    public boolean isuserexist (String username) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{? = call  ISUSEREXIST(?)}");
        stmt.setString(2, username);
        stmt.registerOutParameter(1,Types.BOOLEAN);
        stmt.execute();
        boolean exists = stmt.getBoolean(1);
        return exists;
    }

    public boolean isemailexist (String email) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{? = call  ISEmail(?)}");
        stmt.setString(2, email);
        stmt.registerOutParameter(1,Types.BOOLEAN);
        stmt.execute();
        boolean exists = stmt.getBoolean(1);
        return exists;
    }
    public void insertintoaccounts(int user_id, String account_type, float balance) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{call cr_account(?,?,?)}");
        stmt.setInt(1, user_id);
        stmt.setString(2, account_type);
        stmt.setFloat(3, balance);
        stmt.execute();
    }
    public void insertintousers(String username, String password, String first_name, String last_name, Date date_of_birth, String email, String phone, String address) throws SQLException {
        CallableStatement stmt = conn.prepareCall("{call cr_user(?,?,?,?,?,?,?,?)}");
        stmt.setString(1, username);
        stmt.setString(2, password);
        stmt.setString(3, first_name);
        stmt.setString(4, last_name);
        stmt.setDate(5, (java.sql.Date) date_of_birth);
        stmt.setString(6, email);
        stmt.setString(7, phone);
        stmt.setString(8, address);
        stmt.execute();
    }

}
