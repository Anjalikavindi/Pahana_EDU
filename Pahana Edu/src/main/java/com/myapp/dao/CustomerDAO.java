package com.myapp.dao;

import com.myapp.model.CustomerBean;
import com.myapp.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
	// Get all customers
    public List<CustomerBean> getAllCustomers() {
        List<CustomerBean> customers = new ArrayList<>();
        String sql = "SELECT account_number, first_name, last_name, email, contact_number, address, remaining_units, created_by, created_at FROM customers";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                CustomerBean customer = new CustomerBean();
                customer.setAccountNumber(rs.getString("account_number"));
                customer.setFirstName(rs.getString("first_name"));
                customer.setLastName(rs.getString("last_name"));
                customer.setEmail(rs.getString("email"));
                customer.setContactNumber(rs.getString("contact_number"));
                customer.setAddress(rs.getString("address"));
                customer.setRemainingUnits(rs.getInt("remaining_units"));
                customer.setCreatedBy(rs.getString("created_by"));
                customer.setCreatedAt(rs.getTimestamp("created_at"));
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return customers;
    }
    
    // Get customer by account number
    public CustomerBean getCustomerByAccountNumber(String accountNumber) {
        String sql = "SELECT account_number, first_name, last_name, email, contact_number, address, remaining_units, created_by, created_at FROM customers WHERE account_number = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, accountNumber);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                CustomerBean customer = new CustomerBean();
                customer.setAccountNumber(rs.getString("account_number"));
                customer.setFirstName(rs.getString("first_name"));
                customer.setLastName(rs.getString("last_name"));
                customer.setEmail(rs.getString("email"));
                customer.setContactNumber(rs.getString("contact_number"));
                customer.setAddress(rs.getString("address"));
                customer.setRemainingUnits(rs.getInt("remaining_units"));
                customer.setCreatedBy(rs.getString("created_by"));
                customer.setCreatedAt(rs.getTimestamp("created_at"));
                return customer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    //Get customer by email address
    public CustomerBean getCustomerByEmail(String email) {
        String sql = "SELECT account_number, first_name, last_name, email, contact_number, address, remaining_units, created_by, created_at FROM customers WHERE email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                CustomerBean customer = new CustomerBean();
                customer.setAccountNumber(rs.getString("account_number"));
                customer.setFirstName(rs.getString("first_name"));
                customer.setLastName(rs.getString("last_name"));
                customer.setEmail(rs.getString("email"));
                customer.setContactNumber(rs.getString("contact_number"));
                customer.setAddress(rs.getString("address"));
                customer.setRemainingUnits(rs.getInt("remaining_units"));
                customer.setCreatedBy(rs.getString("created_by"));
                customer.setCreatedAt(rs.getTimestamp("created_at"));
                return customer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    
    // Add new customer
    public boolean addCustomer(CustomerBean customer) {
        String sql = "INSERT INTO customers (account_number, first_name, last_name, email, contact_number, address, remaining_units, created_by, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, customer.getAccountNumber());
            stmt.setString(2, customer.getFirstName());
            stmt.setString(3, customer.getLastName());
            stmt.setString(4, customer.getEmail());
            stmt.setString(5, customer.getContactNumber());
            stmt.setString(6, customer.getAddress());
            stmt.setInt(7, customer.getRemainingUnits());
            stmt.setString(8, customer.getCreatedBy());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Update customer
    public boolean updateCustomer(CustomerBean customer) {
        String sql = "UPDATE customers SET first_name = ?, last_name = ?, email = ?, contact_number = ?, address = ?, remaining_units = ? WHERE account_number = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, customer.getFirstName());
            stmt.setString(2, customer.getLastName());
            stmt.setString(3, customer.getEmail());
            stmt.setString(4, customer.getContactNumber());
            stmt.setString(5, customer.getAddress());
            stmt.setInt(6, customer.getRemainingUnits());
            stmt.setString(7, customer.getAccountNumber());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Delete customer
    public boolean deleteCustomer(String accountNumber) {
        String sql = "DELETE FROM customers WHERE account_number = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, accountNumber);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
}
