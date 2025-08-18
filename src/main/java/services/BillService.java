package services;

import model.Bill;
import model.BillItem;
import controller.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillService {
    public boolean addBill(Bill bill) throws ClassNotFoundException {
        String sql = "INSERT INTO bills (account_number, amount, bill_date) VALUES (?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, bill.getAccountNumber());
            ps.setDouble(2, bill.getAmount());
            ps.setDate(3, new java.sql.Date(bill.getBillDate().getTime()));
            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int billId = rs.getInt(1);
                        BillItemService billItemService = new BillItemService();
                        if (bill.getBillItems() != null) {
                            for (BillItem item : bill.getBillItems()) {
                                item.setBillId(billId);
                                billItemService.addBillItem(item);
                            }
                        }
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Bill> getBillsByAccountNumber(int accountNumber) throws ClassNotFoundException {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills WHERE account_number = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountNumber);
            try (ResultSet rs = ps.executeQuery()) {
                BillItemService billItemService = new BillItemService();
                while (rs.next()) {
                    int billId = rs.getInt("bill_id");
                    List<BillItem> billItems = billItemService.getBillItemsByBillId(billId);
                    Bill bill = new Bill(
                        billId,
                        rs.getInt("account_number"),
                        rs.getDouble("amount"),
                        rs.getDate("bill_date"),
                        billItems
                    );
                    bills.add(bill);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    public List<Bill> getAllBills() throws ClassNotFoundException {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                BillItemService billItemService = new BillItemService();
                while (rs.next()) {
                    int billId = rs.getInt("bill_id");
                    List<BillItem> billItems = billItemService.getBillItemsByBillId(billId);
                    Bill bill = new Bill(
                        billId,
                        rs.getInt("account_number"),
                        rs.getDouble("amount"),
                        rs.getDate("bill_date"),
                        billItems
                    );
                    bills.add(bill);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }
}