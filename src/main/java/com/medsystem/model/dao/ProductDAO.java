package com.medsystem.model.dao;

import com.medsystem.connection.ConnectJDBC;
import com.medsystem.model.bean.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // Lấy danh sách tất cả sản phẩm
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE is_active = 1";

        // Sử dụng try-with-resources để tự động đóng kết nối
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = new Product(0, 0, sql, sql, 0, 0, sql, sql, sql, false);
                p.setId(rs.getInt("id"));
                p.setCategoryId(rs.getInt("category_id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setStockQuantity(rs.getInt("stock_quantity"));
                p.setImageUrl(rs.getString("image_url"));
                p.setManufacturer(rs.getString("manufacturer"));
                p.setExpiryDate(rs.getString("expiry_date"));
                p.setActive(rs.getBoolean("is_active"));
                
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public Product getProductById(int id) {
        Product p = null;
        // Lấy tất cả thông tin sản phẩm dựa trên ID
        String sql = "SELECT * FROM products WHERE id = ? AND is_active = 1";

        // Sử dụng try-with-resources để tự động đóng kết nối
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Thiết lập tham số cho câu lệnh SQL
            ps.setInt(1, id); 

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Khởi tạo và gán giá trị cho Product
                    p = new Product(0, 0, sql, sql, 0, 0, sql, sql, sql, false);
                    p.setId(rs.getInt("id"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getDouble("price"));
                    p.setStockQuantity(rs.getInt("stock_quantity"));
                    p.setImageUrl(rs.getString("image_url"));
                    p.setManufacturer(rs.getString("manufacturer"));
                    p.setExpiryDate(rs.getString("expiry_date"));
                    p.setActive(rs.getBoolean("is_active"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return p; // Trả về Product hoặc null nếu không tìm thấy
    }
    
}