package com.myapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.myapp.model.ItemBean;
import com.myapp.util.DBConnection;

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
	    String sql = "SELECT item_id, item_code, item_name, price, quantity, item_description, image_path, created_by FROM items";

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

	            items.add(item);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return items;
	}


}
