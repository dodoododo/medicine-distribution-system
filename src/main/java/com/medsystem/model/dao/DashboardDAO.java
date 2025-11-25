package com.medsystem.model.dao;

import com.medsystem.connection.ConnectJDBC;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DashboardDAO {

    public int countUsers() throws SQLException {
        String sql = "SELECT COUNT(*) AS cnt FROM users";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt("cnt");
        }
        return 0;
    }

    public int countProducts() throws SQLException {
        String sql = "SELECT COUNT(*) AS cnt FROM products";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt("cnt");
        }
        return 0;
    }

    public double totalRevenue() throws SQLException {
        String sql = "SELECT IFNULL(SUM(total_amount),0) AS total FROM orders WHERE status IN ('PROCESSING','SHIPPING','DELIVERED')";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble("total");
        }
        return 0;
    }
}
