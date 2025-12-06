package com.medsystem.model.bean;

import java.sql.Timestamp;

public class Order {

    private int id;                     // id INT NOT NULL
    private Integer cartId;             // cart_id INT NULL
    private String fullName;            // full_name VARCHAR(100)
    private String phone;               // phone VARCHAR(20)
    private String shippingAddress;     // shipping_address TEXT
    private int totalAmount;            // total_amount INT
    private String status;              // ENUM: PENDING, PROCESSING, SHIPPING, DELIVERED, CANCELLED
    private boolean payment;            // payment TINYINT(1)
    private Timestamp orderDate;        // order_date TIMESTAMP
    private Cart cart;                  // (optional reference)

    public Order() {
    }

    public Order(Integer cartId, String fullName, String phone, String shippingAddress,
                 int totalAmount, String status, boolean payment) {
        this.cartId = cartId;
        this.fullName = fullName;
        this.phone = phone;
        this.shippingAddress = shippingAddress;
        this.totalAmount = totalAmount;
        this.status = status;
        this.payment = payment;
    }
    
    public Order(Integer cartId, String fullName, String phone, String shippingAddress,
            int totalAmount, boolean payment) {
	   this.cartId = cartId;
	   this.fullName = fullName;
	   this.phone = phone;
	   this.shippingAddress = shippingAddress;
	   this.totalAmount = totalAmount;
	   this.payment = payment;
	   this.status = "PENDING"; // default status
	}

    public Order(int id, Integer cartId, String fullName, String phone, String shippingAddress,
                 int totalAmount, String status, boolean payment, Timestamp orderDate) {
        this.id = id;
        this.cartId = cartId;
        this.fullName = fullName;
        this.phone = phone;
        this.shippingAddress = shippingAddress;
        this.totalAmount = totalAmount;
        this.status = status;
        this.payment = payment;
        this.orderDate = orderDate;
    }

    // --- GETTERS & SETTERS ---

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getCartId() {
        return cartId;
    }

    public void setCartId(Integer cartId) {
        this.cartId = cartId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isPayment() {
        return payment;
    }

    public void setPayment(boolean payment) {
        this.payment = payment;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }
}
