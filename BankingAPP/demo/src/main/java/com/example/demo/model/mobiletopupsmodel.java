package com.example.demo.model;

import java.sql.Date;

public class mobiletopupsmodel
{
    int topup_id;
    int account_id;
    String mobile_number;
    float topup_amount;
    Date topup_date;
    public mobiletopupsmodel(int topup_id, int account_id, String mobile_number, float topup_amount, Date topup_date) {
        this.topup_id = topup_id;
        this.account_id = account_id;
        this.mobile_number = mobile_number;
        this.topup_amount = topup_amount;
        this.topup_date = topup_date;
    }

    public int getTopup_id() {
        return topup_id;
    }

    public void setTopup_id(int topup_id) {
        this.topup_id = topup_id;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    public String getMobile_number() {
        return mobile_number;
    }

    public void setMobile_number(String mobile_number) {
        this.mobile_number = mobile_number;
    }

    public float getTopup_amount() {
        return topup_amount;
    }

    public void setTopup_amount(float topup_amount) {
        this.topup_amount = topup_amount;
    }

    public Date getTopup_date() {
        return topup_date;
    }

    public void setTopup_date(Date topup_date) {
        this.topup_date = topup_date;
    }
}
