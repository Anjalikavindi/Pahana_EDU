package com.myapp.dao;

import java.sql.*;

import com.myapp.model.BillBean;
import com.myapp.model.BillItemBean;
import com.myapp.util.DBConnection;

public class BillDAO {

    	// Save bill with items (using transaction)
        public boolean saveBill(BillBean bill) {
            Connection conn = null;
            try {
                // Debug: Print bill details
                System.out.println("=== DEBUG: Saving Bill ===");
                System.out.println("Customer ID: " + bill.getCustomerId());
                System.out.println("Subtotal: " + bill.getSubtotal());
                System.out.println("Grand Total: " + bill.getGrandTotal());
                System.out.println("Amount Paid: " + bill.getAmountPaid());
                System.out.println("Loyalty Points Used: " + bill.getLoyaltyPointsUsed());
                System.out.println("Balance: " + bill.getBalance());
                System.out.println("Created By: " + bill.getCreatedBy());
                
                if (bill.getItems() != null) {
                    System.out.println("Number of items: " + bill.getItems().size());
                    for (int i = 0; i < bill.getItems().size(); i++) {
                        BillItemBean item = bill.getItems().get(i);
                        System.out.println("Item " + (i+1) + " - ID: " + item.getItemId() + 
                                         ", Qty: " + item.getQuantity() + 
                                         ", Unit Price: " + item.getUnitPrice() + 
                                         ", Total: " + item.getTotalPrice());
                    }
                } else {
                    System.out.println("No items in bill!");
                }
                
                conn = DBConnection.getConnection();
                System.out.println("Database connection established");
                
                conn.setAutoCommit(false); // Start transaction
                System.out.println("Transaction started");
                
                // 1. Save the main bill record
                String billSql = "INSERT INTO bills (customer_id, bill_date, subtotal, grand_total, amount_paid, loyalty_points_used, balance, created_by) VALUES (?, NOW(), ?, ?, ?, ?, ?, ?)";
                int billId = 0;
                
                try (PreparedStatement billPs = conn.prepareStatement(billSql, Statement.RETURN_GENERATED_KEYS)) {
                    billPs.setInt(1, bill.getCustomerId());
                    billPs.setDouble(2, bill.getSubtotal());
                    billPs.setDouble(3, bill.getGrandTotal());
                    billPs.setDouble(4, bill.getAmountPaid());
                    billPs.setDouble(5, bill.getLoyaltyPointsUsed());
                    billPs.setDouble(6, bill.getBalance());
                    billPs.setString(7, bill.getCreatedBy());
                    
                    System.out.println("Executing bill insert...");
                    int rowsAffected = billPs.executeUpdate();
                    System.out.println("Bill insert rows affected: " + rowsAffected);
                    
                    // Get the generated bill ID
                    ResultSet rs = billPs.getGeneratedKeys();
                    if (rs.next()) {
                        billId = rs.getInt(1);
                        bill.setBillId(billId); // Set the ID back to the bean
                        System.out.println("Generated Bill ID: " + billId);
                    } else {
                        throw new SQLException("Failed to get generated bill ID");
                    }
                }
                
                // 2. Save all bill items
                if (bill.getItems() != null && !bill.getItems().isEmpty()) {
                    String itemSql = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price, total_price) VALUES (?, ?, ?, ?, ?)";
                    try (PreparedStatement itemPs = conn.prepareStatement(itemSql)) {
                        System.out.println("Preparing to insert " + bill.getItems().size() + " bill items...");
                        
                        for (int i = 0; i < bill.getItems().size(); i++) {
                            BillItemBean item = bill.getItems().get(i);
                            
                            // Validate item data
                            if (item.getItemId() <= 0) {
                                throw new SQLException("Invalid item ID for item " + (i+1) + ": " + item.getItemId());
                            }
                            
                            itemPs.setInt(1, billId);
                            itemPs.setInt(2, item.getItemId());
                            itemPs.setInt(3, item.getQuantity());
                            itemPs.setDouble(4, item.getUnitPrice());
                            itemPs.setDouble(5, item.getTotalPrice());
                            itemPs.addBatch();
                            
                            System.out.println("Added item " + (i+1) + " to batch - Bill ID: " + billId + 
                                             ", Item ID: " + item.getItemId());
                        }
                        
                        System.out.println("Executing batch insert for items...");
                        int[] itemRows = itemPs.executeBatch();
                        System.out.println("Item batch insert completed. Rows affected: " + itemRows.length);
                    }
                } else {
                    System.out.println("No items to insert");
                }
                
                conn.commit(); // Commit transaction
                System.out.println("Transaction committed successfully");
                return true;
                
            } catch (SQLException e) {
                System.err.println("=== SQL ERROR in saveBill ===");
                System.err.println("Error Message: " + e.getMessage());
                System.err.println("SQL State: " + e.getSQLState());
                System.err.println("Error Code: " + e.getErrorCode());
                e.printStackTrace();
                
                if (conn != null) {
                    try {
                        conn.rollback(); // Rollback on error
                        System.out.println("Transaction rolled back");
                    } catch (SQLException rollbackEx) {
                        System.err.println("Rollback failed: " + rollbackEx.getMessage());
                        rollbackEx.printStackTrace();
                    }
                }
                return false;
            } catch (Exception e) {
                System.err.println("=== GENERAL ERROR in saveBill ===");
                System.err.println("Error Message: " + e.getMessage());
                e.printStackTrace();
                
                if (conn != null) {
                    try {
                        conn.rollback();
                        System.out.println("Transaction rolled back");
                    } catch (SQLException rollbackEx) {
                        rollbackEx.printStackTrace();
                    }
                }
                return false;
            } finally {
                if (conn != null) {
                    try {
                        conn.setAutoCommit(true); // Reset auto-commit
                        conn.close();
                        System.out.println("Database connection closed");
                    } catch (SQLException closeEx) {
                        System.err.println("Error closing connection: " + closeEx.getMessage());
                        closeEx.printStackTrace();
                    }
                }
            }
        }
        
        // Get bill by ID (optional - for future use)
        public BillBean getBillById(int billId) {
            String sql = "SELECT * FROM bills WHERE bill_id = ?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                
                ps.setInt(1, billId);
                ResultSet rs = ps.executeQuery();
                
                if (rs.next()) {
                    BillBean bill = new BillBean();
                    bill.setBillId(rs.getInt("bill_id"));
                    bill.setCustomerId(rs.getInt("customer_id"));
                    bill.setBillDate(rs.getTimestamp("bill_date"));
                    bill.setSubtotal(rs.getDouble("subtotal"));
                    bill.setGrandTotal(rs.getDouble("grand_total"));
                    bill.setAmountPaid(rs.getDouble("amount_paid"));
                    bill.setLoyaltyPointsUsed(rs.getDouble("loyalty_points_used"));
                    bill.setBalance(rs.getDouble("balance"));
                    bill.setCreatedBy(rs.getString("created_by"));
                    return bill;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return null;
        }
}
