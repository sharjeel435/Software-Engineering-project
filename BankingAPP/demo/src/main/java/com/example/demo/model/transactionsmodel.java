package com.example.demo.model;

import java.sql.Date;

public class transactionsmodel {
    int transaction_id;
    int account_id;
    String transaction_type;
    Date transaction_date;
    float transaction_amount;
    String description;
    public transactionsmodel(int transaction_id, int account_id, String transaction_type, Date transaction_date, float amount, String description) {
        this.transaction_id = transaction_id;
        this.account_id = account_id;
        this.transaction_type = transaction_type;
        this.transaction_date = transaction_date;
        this.transaction_amount = amount;
        this.description = description;
    }

    public int getTransaction_id() {
        return transaction_id;
    }

    public void setTransaction_id(int transaction_id) {
        this.transaction_id = transaction_id;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    public String getTransaction_type() {
        return transaction_type;
    }

    public void setTransaction_type(String transaction_type) {
        this.transaction_type = transaction_type;
    }

    public Date getTransaction_date() {
        return transaction_date;
    }

    public void setTransaction_date(Date transaction_date) {
        this.transaction_date = transaction_date;
    }

    public float getAmount() {
        return transaction_amount;
    }

    public void setAmount(float amount) {
        this.transaction_amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
