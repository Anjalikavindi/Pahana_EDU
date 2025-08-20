package com.myapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.myapp.model.UserBean;
import com.myapp.model.RoleBean;
import com.myapp.util.DBConnection;



public class UserDAO {
	
	public UserBean getUserByUsername(String username) {
        String sql = "SELECT u.*, r.role_name, r.permissions FROM users u JOIN roles r ON u.role_id = r.role_id WHERE u.username = ?;";
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
    
    public UserBean getUserById(int userId) {
        String sql = "SELECT u.*, r.role_name, r.permissions FROM users u JOIN roles r ON u.role_id = r.role_id WHERE u.user_id = ?;";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
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
    
    public List<UserBean> getAllUsers() {
        List<UserBean> users = new ArrayList<>();
        String sql = "SELECT u.*, r.role_name, r.permissions FROM users u JOIN roles r ON u.role_id = r.role_id ORDER BY u.user_id;";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
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
                users.add(user);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return users;
    }
    
    
    // Get total users count for dashboard card
    public int getUserCount() {
        String sql = "SELECT COUNT(*) AS total FROM users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    
    public boolean addUser(UserBean user) {
        String sql = "INSERT INTO users (username, password_hash, full_name, role_id, status) VALUES (?, ?, ?, ?, ?);";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPasswordHash()); // Using plain text for now, matching current implementation
            ps.setString(3, user.getFullName());
            ps.setInt(4, user.getRoleId());
            ps.setString(5, user.getStatus());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) { 
            e.printStackTrace(); 
            return false;
        }
    }
    
    public boolean updateUser(UserBean user) {
        String sql;
        if (user.getPasswordHash() != null && !user.getPasswordHash().trim().isEmpty()) {
            sql = "UPDATE users SET username = ?, password_hash = ?, full_name = ?, role_id = ?, status = ? WHERE user_id = ?;";
        } else {
            sql = "UPDATE users SET username = ?, full_name = ?, role_id = ?, status = ? WHERE user_id = ?;";
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (user.getPasswordHash() != null && !user.getPasswordHash().trim().isEmpty()) {
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getPasswordHash()); // Using plain text for now
                ps.setString(3, user.getFullName());
                ps.setInt(4, user.getRoleId());
                ps.setString(5, user.getStatus());
                ps.setInt(6, user.getUserId());
            } else {
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getFullName());
                ps.setInt(3, user.getRoleId());
                ps.setString(4, user.getStatus());
                ps.setInt(5, user.getUserId());
            }
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) { 
            e.printStackTrace(); 
            return false;
        }
    }
    
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?;";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) { 
            e.printStackTrace(); 
            return false;
        }
    }
    
    public boolean updateUserStatus(int userId, String status) {
        String sql = "UPDATE users SET status = ? WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, userId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) { 
            e.printStackTrace(); 
            return false;
        }
    }

}
