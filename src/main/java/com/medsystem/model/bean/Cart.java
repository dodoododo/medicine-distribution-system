package com.medsystem.model.bean;

import java.util.List;

public class Cart {
    private int id;
    private int userId;

    private List<CartProduct> items; 

    public Cart() {
    }

    public Cart(int id, int userId) {
        this.id = id;
        this.userId = userId;
    }

    // --- Getters và Setters ---

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<CartProduct> getItems() {
        return items;
    }

    public void setItems(List<CartProduct> items) {
        this.items = items;
    }
}