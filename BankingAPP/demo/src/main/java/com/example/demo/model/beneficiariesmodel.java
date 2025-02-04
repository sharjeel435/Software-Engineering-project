package com.example.demo.model;

public class beneficiariesmodel
{
    int beneficiary_id;
    int user_id;
    int account_id;
    String recipient_name;
    String account_number;
    String bank_name;

    public beneficiariesmodel(int beneficiary_id, int user_id, int account_id, String recipient_name, String account_number, String bank_name) {
        this.beneficiary_id = beneficiary_id;
        this.user_id = user_id;
        this.account_id = account_id;
        this.recipient_name = recipient_name;
        this.account_number = account_number;
        this.bank_name = bank_name;
    }

    public int getBeneficiary_id() {
        return beneficiary_id;
    }

    public void setBeneficiary_id(int beneficiary_id) {
        this.beneficiary_id = beneficiary_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    public String getRecipient_name() {
        return recipient_name;
    }

    public void setRecipient_name(String recipient_name) {
        this.recipient_name = recipient_name;
    }

    public String getAccount_number() {
        return account_number;
    }

    public void setAccount_number(String account_number) {
        this.account_number = account_number;
    }

    public String getBank_name() {
        return bank_name;
    }

    public void setBank_name(String bank_name) {
        this.bank_name = bank_name;
    }
}
