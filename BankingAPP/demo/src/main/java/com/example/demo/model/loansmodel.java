package com.example.demo.model;

import java.sql.Date;
public class loansmodel
{
    int loan_id;
    int account_id;
    String loan_type;
    float loan_amount;
    float interest_amount;
    float paid_amount;
    float interest_rate;
    int loan_term;
    Date approval_date;
    Date paid_date;
    public loansmodel(int loan_id, int account_id, String loan_type, float loan_amount, float interest_amount, float paid_amount, float interest_rate, int loan_term, Date approval_date, Date paid_date) {
        this.loan_id = loan_id;
        this.account_id = account_id;
        this.loan_type = loan_type;
        this.loan_amount = loan_amount;
        this.interest_amount = interest_amount;
        this.paid_amount = paid_amount;
        this.interest_rate = interest_rate;
        this.loan_term = loan_term;
        this.approval_date = approval_date;
        this.paid_date = paid_date;
    }

    public int getLoan_id() {
        return loan_id;
    }

    public void setLoan_id(int loan_id) {
        this.loan_id = loan_id;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    public String getLoan_type() {
        return loan_type;
    }

    public void setLoan_type(String loan_type) {
        this.loan_type = loan_type;
    }

    public float getLoan_amount() {
        return loan_amount;
    }

    public void setLoan_amount(float loan_amount) {
        this.loan_amount = loan_amount;
    }

    public float getInterest_amount() {
        return interest_amount;
    }

    public void setInterest_amount(float interest_amount) {
        this.interest_amount = interest_amount;
    }

    public float getPaid_amount() {
        return paid_amount;
    }

    public void setPaid_amount(float paid_amount) {
        this.paid_amount = paid_amount;
    }

    public float getInterest_rate() {
        return interest_rate;
    }

    public void setInterest_rate(float interest_rate) {
        this.interest_rate = interest_rate;
    }

    public int getLoan_term() {
        return loan_term;
    }

    public void setLoan_term(int loan_term) {
        this.loan_term = loan_term;
    }

    public Date getApproval_date() {
        return approval_date;
    }

    public void setApproval_date(Date approval_date) {
        this.approval_date = approval_date;
    }

    public Date getPaid_date() {
        return paid_date;
    }

    public void setPaid_date(Date paid_date) {
        this.paid_date = paid_date;
    }
}
