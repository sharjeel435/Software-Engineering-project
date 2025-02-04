package com.example.demo.model;

import java.sql.Date;

public class billnomodel
{
    int bill_no;
    float bill_amount;
    String bill_type;
    Date due_date;
    boolean bill_paid;

    public billnomodel(int bill_no, float bill_amount, String bill_type, Date due_date, boolean bill_paid) {
        this.bill_no = bill_no;
        this.bill_amount = bill_amount;
        this.bill_type = bill_type;
        this.due_date = due_date;
        this.bill_paid = bill_paid;
    }

    public int getBill_no() {
        return bill_no;
    }

    public void setBill_no(int bill_no) {
        this.bill_no = bill_no;
    }

    public float getBill_amount() {
        return bill_amount;
    }

    public void setBill_amount(float bill_amount) {
        this.bill_amount = bill_amount;
    }

    public String getBill_type() {
        return bill_type;
    }

    public void setBill_type(String bill_type) {
        this.bill_type = bill_type;
    }

    public Date getDue_date() {
        return due_date;
    }

    public void setDue_date(Date due_date) {
        this.due_date = due_date;
    }

    public boolean isBill_paid() {
        return bill_paid;
    }

    public void setBill_paid(boolean bill_paid) {
        this.bill_paid = bill_paid;
    }
}
