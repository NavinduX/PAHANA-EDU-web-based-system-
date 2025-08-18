package services;

import model.BillItem;
import model.Item;
import controller.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillItemService {
    public boolean addBillItem(BillItem billItem) throws ClassNotFoundException {
        String sql = "INSERT INTO bill_items (bill_id, item_id, quantity) VALUES (?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, billItem.getBillId());
            ps.setInt(2, billItem.getItemId());
            ps.setInt(3, billItem.getQuantity());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<BillItem> getBillItemsByBillId(int billId) throws ClassNotFoundException {
        List<BillItem> billItems = new ArrayList<>();
        String sql = "SELECT bi.*, i.item_name, i.price, i.description FROM bill_items bi JOIN items i ON bi.item_id = i.item_id WHERE bi.bill_id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, billId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Item item = new Item(rs.getInt("item_id"), rs.getString("item_ame"), rs.getDouble("price"), rs.getString("description"));
                    BillItem billItem = new BillItem(rs.getInt("bill_item_id"), billId, rs.getInt("item_id"), rs.getInt("quantity"), item);
                    billItems.add(billItem);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return billItems;
    }
}