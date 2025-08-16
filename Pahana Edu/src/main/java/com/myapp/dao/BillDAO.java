package com.myapp.dao;

import java.sql.*;
import java.util.List;

import com.myapp.model.BillBean;
import com.myapp.model.BillItemBean;
import com.myapp.util.DBConnection;

public class BillDAO {

	// Save bill
	public void saveBill(BillBean bill) {
        String sql = "INSERT INTO bills (customer_id, bill_date, subtotal, grand_total, amount_paid, loyalty_points_used, balance, created_by) VALUES (?, NOW(), ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bill.getCustomerId());
            ps.setDouble(2, bill.getSubtotal());
            ps.setDouble(4, bill.getGrandTotal());
            ps.setDouble(5, bill.getAmountPaid());
            ps.setDouble(6, bill.getLoyaltyPointsUsed());
            ps.setDouble(7, bill.getBalance());
            ps.setString(8, bill.getCreatedBy());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
