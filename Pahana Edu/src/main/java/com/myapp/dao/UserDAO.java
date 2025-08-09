package com.myapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


import com.myapp.model.UserBean;
import com.myapp.model.RoleBean;
import com.myapp.util.DBConnection;



public class UserDAO {
	
	public UserBean getUserByUsername(String username) {
        String sql = "SELECT u.*, r.role_name, r.permissions FROM users u JOIN roles r ON u.role_id = r.role_id WHERE u.username = ? AND u.status = 'active';";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                UserBean user = new UserBean();
                RoleBean role = new RoleBean();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPasswordHash(rs.getString("password_hash"));
                user.setFullName(rs.getString("full_name"));
                user.setRoleId(rs.getInt("role_id"));
                user.setStatus(rs.getString("status"));
                user.setImage(rs.getString("image"));

                role.setRoleId(rs.getInt("role_id"));
                role.setRoleName(rs.getString("role_name"));
                role.setPermissions(rs.getString("permissions"));
                user.setRole(role);
                return user;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

}
