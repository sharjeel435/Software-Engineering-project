package com.example.demo.model;

import java.sql.Date;

public class billmodel
{
    int billpaid_id;
    int bill_no;
    int account_no;
    String bill_type;
    float amount_due;
    Date due_date;
    Date paid_date;
    boolean paid;

    public billmodel(int billpaid_id, int bill_no, int account_no, String bill_type, float amount_due, Date due_date, Date paid_date, boolean paid) {
        this.billpaid_id = billpaid_id;
        this.bill_no = bill_no;
        this.account_no = account_no;
        this.bill_type = bill_type;
        this.amount_due = amount_due;
        this.due_date = due_date;
        this.paid_date = paid_date;
        this.paid = paid;
    }

    public int getBillpaid_id() {
        return billpaid_id;
    }

    public void setBillpaid_id(int billpaid_id) {
        this.billpaid_id = billpaid_id;
    }

    public int getBill_no() {
        return bill_no;
    }

    public void setBill_no(int bill_no) {
        this.bill_no = bill_no;
    }

    public int getAccount_no() {
        return account_no;
    }

    public void setAccount_no(int account_no) {
        this.account_no = account_no;
    }

    public String getBill_type() {
        return bill_type;
    }

    public void setBill_type(String bill_type) {
        this.bill_type = bill_type;
    }

    public float getAmount_due() {
        return amount_due;
    }

    public void setAmount_due(float amount_due) {
        this.amount_due = amount_due;
    }

    public Date getDue_date() {
        return due_date;
    }

    public void setDue_date(Date due_date) {
        this.due_date = due_date;
    }

    public Date getPaid_date() {
        return paid_date;
    }

    public void setPaid_date(Date paid_date) {
        this.paid_date = paid_date;
    }

    public boolean isPaid() {
        return paid;
    }

    public void setPaid(boolean paid) {
        this.paid = paid;
    }
}
