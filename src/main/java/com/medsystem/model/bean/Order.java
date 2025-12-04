package com.medsystem.model.bean;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Order {
    private int id;
    private Integer cartId;
    private String fullName;
    private String phone;
    private String shippingAddress;
    private BigDecimal totalAmount;
    private String status;
    private Timestamp orderDate;
    private Cart cart;

    public Order() {
    }

    public Order(Integer cartId, String fullName, String phone, String shippingAddress, BigDecimal totalAmount, String status) {
        this.cartId = cartId;
        this.fullName = fullName;
        this.phone = phone;
        this.shippingAddress = shippingAddress;
        this.totalAmount = totalAmount;
        this.status = status;
    }

    public Order(int id, Integer cartId, String fullName, String phone, String shippingAddress, BigDecimal totalAmount, String status, Timestamp orderDate) {
        this.id = id;
        this.cartId = cartId;
        this.fullName = fullName;
        this.phone = phone;
        this.shippingAddress = shippingAddress;
        this.totalAmount = totalAmount;
        this.status = status;
        this.orderDate = orderDate;
    }

    // --- Getters và Setters ---

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

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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