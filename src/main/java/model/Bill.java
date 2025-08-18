package model;

import java.util.Date;
import java.util.List;

public class Bill {
    private int billId;
    private int accountNumber;
    private double amount;
    private Date billDate;
    private List<BillItem> billItems;

    public Bill() {}

    public Bill(int billId, int accountNumber, double amount, Date billDate, List<BillItem> billItems) {
        this.billId = billId;
        this.accountNumber = accountNumber;
        this.amount = amount;
        this.billDate = billDate;
        this.billItems = billItems;
    }

    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(int accountNumber) {
        this.accountNumber = accountNumber;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getBillDate() {
        return billDate;
    }

    public void setBillDate(Date billDate) {
        this.billDate = billDate;
    }

    public List<BillItem> getBillItems() {
        return billItems;
    }

    public void setBillItems(List<BillItem> billItems) {
        this.billItems = billItems;
    }
}