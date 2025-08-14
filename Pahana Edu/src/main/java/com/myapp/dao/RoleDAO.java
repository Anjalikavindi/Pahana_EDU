package com.myapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.myapp.util.DBConnection;
import com.myapp.model.RoleBean;

public class RoleDAO {

	public List<String> getAllRoleNames() {
        List<String> roles = new ArrayList<>();
        String sql = "SELECT role_name FROM roles ORDER BY role_name";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                roles.add(rs.getString("role_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return roles;
    }
    
    public List<RoleBean> getAllRoles() {
        List<RoleBean> roles = new ArrayList<>();
        String sql = "SELECT role_id, role_name, permissions FROM roles ORDER BY role_name";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                RoleBean role = new RoleBean();
                role.setRoleId(rs.getInt("role_id"));
                role.setRoleName(rs.getString("role_name"));
                role.setPermissions(rs.getString("permissions"));
                roles.add(role);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return roles;
    }
	
}
