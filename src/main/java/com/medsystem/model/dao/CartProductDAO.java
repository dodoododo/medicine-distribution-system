package com.medsystem.model.dao;

import com.medsystem.connection.ConnectJDBC;
import com.medsystem.model.bean.CartProduct;
import com.medsystem.model.bean.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartProductDAO {

    private CartProduct mapResultSetToCartProductFull(ResultSet rs) throws SQLException {
        CartProduct item = new CartProduct();
        item.setId(rs.getInt("id"));
        item.setCartId(rs.getInt("cart_id"));
        item.setProductId(rs.getInt("product_id"));
        item.setQuantity(rs.getInt("quantity"));

        // Gán thông tin Product chi tiết (chỉ sử dụng cho query JOIN)
        Product productDetail = new Product();
        productDetail.setId(rs.getInt("product_id"));
        productDetail.setName(rs.getString("name"));
        productDetail.setPrice(rs.getDouble("price")); 
        productDetail.setImageUrl(rs.getString("image_url"));

        item.setProduct(productDetail);
        return item;
    }

    public List<CartProduct> getProductsByCartId(int cartId) {
        List<CartProduct> items = new ArrayList<>();

        String sql = "SELECT cp.id, cp.cart_id, cp.product_id, cp.quantity, " +
                     "p.name, p.price, p.image_url " +
                     "FROM cart_product cp JOIN products p ON cp.product_id = p.id " +
                     "WHERE cp.cart_id = ?";

        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapResultSetToCartProductFull(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    public CartProduct getByCartAndProduct1(int cartId, int productId) {
        String sql = "SELECT id, cart_id, product_id, quantity FROM cart_product WHERE cart_id = ? AND product_id = ?";
        CartProduct item = null;

        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ps.setInt(2, productId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    item = new CartProduct();
                    item.setId(rs.getInt("id"));
                    item.setCartId(rs.getInt("cart_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return item;
    }

    public boolean add(CartProduct item) {
        String sql = "INSERT INTO cart_product (cart_id, product_id, quantity) VALUES (?, ?, ?)";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, item.getCartId());
            ps.setInt(2, item.getProductId());
            ps.setInt(3, item.getQuantity());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addOrUpdate(CartProduct item) {
        if (item.getId() > 0) {
            String updateSql = "UPDATE cart_product SET quantity = ? WHERE id = ?";
            try (Connection conn = ConnectJDBC.getConnection();
                 PreparedStatement ps = conn.prepareStatement(updateSql)) {

                ps.setInt(1, item.getQuantity()); // set quantity mới
                ps.setInt(2, item.getId());
                return ps.executeUpdate() > 0;

            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        } else {
            return add(item);
        }
    }

    public boolean delete(int cartProductId) {
        String sql = "DELETE FROM cart_product WHERE id = ?";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartProductId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteByCartId(int cartId) {
        String sql = "DELETE FROM cart_product WHERE cart_id = ?";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartId);

            return ps.executeUpdate() >= 0; 
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public CartProduct getByCartAndProduct(int cartId, int productId) throws SQLException {
        String sql = "SELECT * FROM cart_product WHERE cart_id=? AND product_id=?";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ps.setInt(2, productId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                CartProduct cp = new CartProduct();
                cp.setId(rs.getInt("id"));
                cp.setCartId(rs.getInt("cart_id"));
                cp.setProductId(rs.getInt("product_id"));
                cp.setQuantity(rs.getInt("quantity"));
                return cp;
            }
        }
        return null;
    }

    public boolean updateQuantity(int id, int qty) throws SQLException {
        String sql = "UPDATE cart_product SET quantity=? WHERE id=?";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, qty);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        }
    }
}