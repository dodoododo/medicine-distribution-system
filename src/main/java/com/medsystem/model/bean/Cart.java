package com.medsystem.model.bean;

import java.sql.Timestamp;
import java.util.List;

public class Cart {
    private int id;
    private int userId;
    private Timestamp createdAt;   // 🆕 thêm thời gian tạo giỏ hàng

    private List<CartProduct> items;

    public Cart() {
    }

    public Cart(int id, int userId, Timestamp createdAt) {
        this.id = id;
        this.userId = userId;
        this.createdAt = createdAt;
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public List<CartProduct> getItems() {
        return items;
    }

    public void setItems(List<CartProduct> items) {
        this.items = items;
    }
    
    public int getTotalPrice() {
        if (items == null || items.isEmpty()) return 0;

        double sum = 0.0;
        for (CartProduct cp : items) {
            if (cp == null) continue;
            // ưu tiên dùng subTotal nếu đã có, hoặc lấy từ product nếu cần
            double line = 0.0;
            if (cp.getProduct() != null) {
                line = cp.getProduct().getPrice() * cp.getQuantity();
            } else {
                line = cp.getSubTotal(); // fallback (nếu bạn set product null nhưng có subTotal)
            }
            sum += line;
        }
        return (int) Math.round(sum); // trả về int (VNĐ), làm tròn
    }
}
