package com.medsystem.model.dao;

import com.medsystem.connection.ConnectJDBC;
import com.medsystem.model.bean.Cart;
import com.medsystem.model.bean.CartProduct;
import com.medsystem.model.bean.Product; // Cần thiết để gán chi tiết sản phẩm

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    private Cart mapResultSetToCart(ResultSet rs) throws SQLException {
        Cart cart = new Cart();
        cart.setId(rs.getInt("id"));
        cart.setUserId(rs.getInt("user_id"));
        return cart;
    }

    private CartProduct mapResultSetToCartProduct(ResultSet rs) throws SQLException {
        CartProduct item = new CartProduct();
        item.setId(rs.getInt("id"));
        item.setCartId(rs.getInt("cart_id"));
        item.setProductId(rs.getInt("product_id"));
        item.setQuantity(rs.getInt("quantity"));

        Product productDetail = new Product();
        productDetail.setId(rs.getInt("product_id"));
        productDetail.setName(rs.getString("name"));
        productDetail.setPrice(rs.getInt("price")); 
        productDetail.setImageUrl(rs.getString("image_url"));

        item.setProduct(productDetail);
        return item;
    }

    public Cart getCartByUserId(int userId) {
        Cart cart = null;
        String sql = "SELECT id, user_id FROM cart WHERE user_id = ?";

        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cart = mapResultSetToCart(rs);
                    System.out.println(cart);
                } else {
                    cart = createCart(userId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cart;
    }
    
    public Cart getNewestCartByUserId(int userId) {
        String sql = "SELECT id, user_id FROM cart WHERE user_id = ? ORDER BY created_at DESC LIMIT 1";

        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCart(rs);
                }
            }

            // Nếu không có cart → tạo cart đầu tiên
            return createCart(userId);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }



    public Cart createCart(int userId) {
        String sql = "INSERT INTO cart (user_id) VALUES (?)";
        Cart newCart = null;

        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, userId);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int cartId = rs.getInt(1);
                        newCart = new Cart();
                        newCart.setId(cartId);
                        newCart.setUserId(userId);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newCart;
    }
    

    public Cart getCartById(int cartId) throws SQLException {
        Cart cart = null;

        String sql = "SELECT * FROM cart WHERE id = ?";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setUserId(rs.getInt("user_id"));
            }
        }

        if (cart != null) {
            cart.setItems(getCartProductsByCartId(cartId));
        }

        return cart;
    }

    public List<CartProduct> getCartProductsByCartId(int cartId) {
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
                    items.add(mapResultSetToCartProduct(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    public CartProduct getCartProductByCartAndProduct(int cartId, int productId) {
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

    public boolean addCartProduct(CartProduct item) {
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

    public boolean updateCartProduct(CartProduct item) {
        String sql = "UPDATE cart_product SET quantity = ? WHERE id = ?";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, item.getQuantity());
            ps.setInt(2, item.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteCartProduct(int cartProductId) {
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

    public boolean clearCart(int cartId) {
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

    public Cart getOrCreateCartByUserId(int userId) throws SQLException {
        Cart c = getCartByUserId(userId);
        if (c != null) return c;
        return createCart(userId);
    }
    
    public Cart createNewCartAfterOrder(int userId) {
        return createCart(userId);
    }
}