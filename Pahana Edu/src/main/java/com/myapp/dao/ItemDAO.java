package com.myapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;
import java.util.UUID;

import com.myapp.model.ItemBean;
import com.myapp.util.DBConnection;
import com.myapp.util.DatabaseConnection;

public class ItemDAO {
	
	// Add a new item to the database
	public boolean addItem(ItemBean item) {
		
	        String sql = "INSERT INTO items (item_code, item_name, price, quantity, item_description, image_path, created_by) VALUES (?, ?, ?, ?, ?, ?, ?)";

	        // Generate a unique item code (you can adjust format as needed)
	        String uniqueCode = UUID.randomUUID().toString().substring(0, 8).toUpperCase();
	        item.setItemCode(uniqueCode);

	        try (Connection conn = DBConnection.getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {

	            ps.setString(1, item.getItemCode());
	            ps.setString(2, item.getItemName());
	            ps.setDouble(3, item.getPrice());
	            ps.setInt(4, item.getQuantity());
	            ps.setString(5, item.getItemDescription());
	            ps.setString(6, item.getImagePath());
	            ps.setString(7, item.getCreatedBy());

	            int rows = ps.executeUpdate();
	            return rows > 0;

	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	
	//Fetch the item list
	public List<ItemBean> getAllItems() {
	    List<ItemBean> items = new ArrayList<>();
	    String sql = "SELECT * FROM items";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         java.sql.ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            ItemBean item = new ItemBean();
	            item.setItemId(rs.getInt("item_id"));
	            item.setItemCode(rs.getString("item_code"));
	            item.setItemName(rs.getString("item_name"));
	            item.setPrice(rs.getDouble("price"));
	            item.setQuantity(rs.getInt("quantity"));
	            item.setItemDescription(rs.getString("item_description"));
	            item.setImagePath(rs.getString("image_path"));
	            item.setCreatedBy(rs.getString("created_by"));
	            
	            Timestamp createdAt = rs.getTimestamp("created_at");
                item.setCreatedAt(createdAt);

	            items.add(item);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return items;
	}
	
	
	// Update item details
	public boolean updateItem(ItemBean item) {
	    StringBuilder sql = new StringBuilder("UPDATE items SET item_name=?, price=?, quantity=?, item_description=?");
	    if (item.getImagePath() != null && !item.getImagePath().isEmpty()) {
	        sql.append(", image_path=?");
	    }
	    sql.append(" WHERE item_id=?");

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql.toString())) {

	        ps.setString(1, item.getItemName());
	        ps.setDouble(2, item.getPrice());
	        ps.setInt(3, item.getQuantity());
	        ps.setString(4, item.getItemDescription());

	        int index = 5;
	        if (item.getImagePath() != null && !item.getImagePath().isEmpty()) {
	            ps.setString(index++, item.getImagePath());
	        }

	        ps.setInt(index, item.getItemId());

	        int rows = ps.executeUpdate();
	        return rows > 0;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}



	// Delete item by ID
    public boolean deleteItem(int itemId) {
        String sql = "DELETE FROM items WHERE item_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, itemId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
