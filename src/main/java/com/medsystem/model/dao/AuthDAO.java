package com.medsystem.model.dao;

import com.medsystem.connection.ConnectJDBC;
import com.medsystem.model.bean.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

public class AuthDAO {
    public User login(String email, String password) throws Exception {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getInt("role"),               // role là int
                        rs.getTimestamp("created_at")   // createdAt
                );
            } else {
                throw new Exception("Email hoặc mật khẩu không đúng!");
            }
        }
    }
    // Đăng ký user mới
    public User register(String fullName, String email, String password, String phone, String address) throws Exception {
        // Kiểm tra email đã tồn tại
        String checkSql = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement checkPs = conn.prepareStatement(checkSql)) {
            checkPs.setString(1, email);
            ResultSet rs = checkPs.executeQuery();
            if (rs.next()) {
                throw new Exception("Email đã được sử dụng!");
            }
        }

        String sql = "INSERT INTO users(full_name, email, password, phone, address, role, created_at) " +
                     "VALUES(?, ?, ?, ?, ?, 0, NOW())"; // role = 0 = user
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, phone);
            ps.setString(5, address);
            ps.executeUpdate();

            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) {
                int id = keys.getInt(1);
                return new User(id, fullName, email, password, phone, address, 0, new Timestamp(System.currentTimeMillis()));
            } else {
                throw new Exception("Đăng ký thất bại!");
            }
        }
    }
}
