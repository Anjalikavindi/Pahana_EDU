package com.myapp.model;

import java.sql.Timestamp;
import java.util.List;

public class BillBean {

	private int billId;
    private int customerId;
    private Timestamp billDate;
    private double subtotal;
    private double grandTotal;
    private double amountPaid;
    private double loyaltyPointsUsed;
    private double balance;
    private String createdBy;
    private List<BillItemBean> items; // bill items
    
    
	public int getBillId() {
		return billId;
	}
	public void setBillId(int billId) {
		this.billId = billId;
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public Timestamp getBillDate() {
		return billDate;
	}
	public void setBillDate(Timestamp billDate) {
		this.billDate = billDate;
	}
	public double getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(double subtotal) {
		this.subtotal = subtotal;
	}
	public double getGrandTotal() {
		return grandTotal;
	}
	public void setGrandTotal(double grandTotal) {
		this.grandTotal = grandTotal;
	}
	public double getAmountPaid() {
		return amountPaid;
	}
	public void setAmountPaid(double amountPaid) {
		this.amountPaid = amountPaid;
	}
	public double getLoyaltyPointsUsed() {
		return loyaltyPointsUsed;
	}
	public void setLoyaltyPointsUsed(double loyaltyPointsUsed) {
		this.loyaltyPointsUsed = loyaltyPointsUsed;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public List<BillItemBean> getItems() {
		return items;
	}
	public void setItems(List<BillItemBean> items) {
		this.items = items;
	}
    
    
}
