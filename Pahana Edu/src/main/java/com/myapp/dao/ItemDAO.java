package com.myapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.myapp.model.ItemBean;
import com.myapp.util.DBConnection;

public class ItemDAO {
	
	public boolean saveItem(ItemBean item) {
        String sql = "INSERT INTO items (item_name, unit_price, stock_quantity, description, image, created_by) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, item.getItemName());
            ps.setDouble(2, item.getUnitPrice());
            ps.setInt(3, item.getStockQuantity());
            ps.setString(4, item.getDescription());
            ps.setBytes(5, item.getImage());
            ps.setString(6, item.getCreatedBy());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
