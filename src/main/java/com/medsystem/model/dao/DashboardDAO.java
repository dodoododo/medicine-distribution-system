package com.medsystem.model.dao;

import com.medsystem.connection.ConnectJDBC;

import java.sql.*;
import java.util.*;

public class DashboardDAO {

    // =========================================================
    // 1. Tổng số người dùng
    // =========================================================
    public int countUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // =========================================================
    // 2. Tổng số sản phẩm
    // =========================================================
    public int countProducts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM products";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // =========================================================
    // 3. Tổng doanh thu (status = DELIVERED)
    // =========================================================
    public int totalRevenue() throws SQLException {
        String sql = "SELECT SUM(total_amount) FROM orders WHERE status = 'DELIVERED'";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
    
    // 4. Doanh thu theo ngày
    public Map<String, Integer> revenueByDay() throws SQLException {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = """
            SELECT DATE(order_date) AS day, 
                   SUM(total_amount) AS revenue
            FROM orders
            WHERE status='DELIVERED'
            GROUP BY DATE(order_date)
            ORDER BY DATE(order_date)
        """;
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("day"), rs.getInt("revenue"));
            }
        }
        return map;
    }

    // =========================================================
    // 5. Tổng tiền từng người dùng
    // =========================================================
    public List<Map<String, Object>> totalSpentPerUser() throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = """
            SELECT u.id, u.full_name, SUM(o.total_amount) AS spent
            FROM users u
            JOIN cart c ON c.user_id = u.id
            JOIN orders o ON o.cart_id = c.id
            WHERE o.status='DELIVERED'
            GROUP BY u.id, u.full_name
            ORDER BY u.id
        """;
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> m = new HashMap<>();
                m.put("id", rs.getInt("id"));
                m.put("name", rs.getString("full_name"));
                m.put("spent", rs.getInt("spent"));
                list.add(m);
            }
        }
        return list;
    }

    // =========================================================
    // 6. Top 10 khách hàng tiêu nhiều tiền nhất
    // =========================================================
    public List<Map<String, Object>> topUsersSpent() throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = """
            SELECT u.id, u.full_name, SUM(o.total_amount) AS spent
            FROM users u
            JOIN cart c ON c.user_id = u.id
            JOIN orders o ON o.cart_id = c.id
            WHERE o.status='DELIVERED'
            GROUP BY u.id, u.full_name
            ORDER BY spent DESC
            LIMIT 10
        """;
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> m = new HashMap<>();
                m.put("id", rs.getInt("id"));
                m.put("name", rs.getString("full_name"));
                m.put("spent", rs.getInt("spent"));
                list.add(m);
            }
        }
        return list;
    }

    // =========================================================
    // 7. Top 5 sản phẩm tạo nhiều doanh thu nhất
    // =========================================================
    public List<Map<String,Object>> topProductsByRevenue() throws SQLException {
        List<Map<String,Object>> list = new ArrayList<>();
        String sql = """
            SELECT p.id, p.name, SUM(p.price * cp.quantity) AS revenue
            FROM products p
            JOIN cart_product cp ON cp.product_id = p.id
            JOIN cart c ON c.id = cp.cart_id
            JOIN orders o ON o.cart_id = c.id
            WHERE o.status='DELIVERED'
            GROUP BY p.id, p.name
            ORDER BY revenue DESC
            LIMIT 5
        """;
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String,Object> m = new HashMap<>();
                m.put("id", rs.getInt("id"));
                m.put("name", rs.getString("name"));
                m.put("revenue", rs.getInt("revenue"));
                list.add(m);
            }
        }
        return list;
    }
}
