package com.example.demo.model;

import java.sql.Date;

public class AccountModel {
    int account_id;
    int user_id;
    String account_type;
    float balance;
    Date open_date;
    public AccountModel(int account_id, int user_id, String account_type, float balance, Date open_date) {
        this.account_id = account_id;
        this.user_id = user_id;
        this.account_type = account_type;
        this.balance = balance;
        this.open_date = open_date;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getAccount_type() {
        return account_type;
    }

    public void setAccount_type(String account_type) {
        this.account_type = account_type;
    }

    public float getBalance() {
        return balance;
    }

    public void setBalance(float balance) {
        this.balance = balance;
    }

    public Date getOpen_date() {
        return open_date;
    }

    public void setOpen_date(Date open_date) {
        this.open_date = open_date;
    }
}
