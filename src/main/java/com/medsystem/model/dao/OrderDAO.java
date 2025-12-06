package com.medsystem.model.dao;

import com.medsystem.model.bean.Order;
import com.medsystem.connection.ConnectJDBC;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // ====================================================================
    // CREATE ORDER
    // ====================================================================
    public int createOrder(Order order) throws SQLException {

        String sql = "INSERT INTO orders (cart_id, full_name, phone, shipping_address, total_amount, status, payment) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            if (order.getCartId() == null) {
                ps.setNull(1, Types.INTEGER);
            } else {
                ps.setInt(1, order.getCartId());
            }

            ps.setString(2, order.getFullName());
            ps.setString(3, order.getPhone());
            ps.setString(4, order.getShippingAddress());
            ps.setInt(5, order.getTotalAmount());
            ps.setString(6, order.getStatus());
            ps.setBoolean(7, order.isPayment());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }

        return 0;
    }

    // ====================================================================
    // GET ALL ORDERS
    // ====================================================================
    public List<Order> getAllOrders() throws SQLException {
        List<Order> list = new ArrayList<>();

        String sql = "SELECT * FROM orders ORDER BY order_date DESC";

        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapOrder(rs));
            }
        }

        return list;
    }

    public boolean updateOrder(Order o) throws SQLException {
        String sql = "UPDATE orders SET full_name=?, phone=?, shipping_address=?, total_amount=?, status=?, payment=?, cart_id=? WHERE id=?";

        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, o.getFullName());
            ps.setString(2, o.getPhone());
            ps.setString(3, o.getShippingAddress());
            ps.setInt(4, o.getTotalAmount());
            ps.setString(5, o.getStatus());
            ps.setBoolean(6, o.isPayment());
            if (o.getCartId() != null)
                ps.setInt(7, o.getCartId());
            else
                ps.setNull(7, java.sql.Types.INTEGER);

            ps.setInt(8, o.getId());

            return ps.executeUpdate() > 0;
        }
    }

    
    // ====================================================================
    // GET ORDER BY ID
    // ====================================================================
    public Order getOrderById(int id) throws SQLException {

        String sql = "SELECT * FROM orders WHERE id = ?";

        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapOrder(rs);
            }
        }

        return null;
    }

    // ====================================================================
    // GET ORDER BY CART ID
    // ====================================================================
    public Order getOrderByCart(int cartId) throws SQLException {

        String sql = "SELECT * FROM orders WHERE cart_id = ?";

        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapOrder(rs);
            }
        }

        return null;
    }

    // ====================================================================
    // UPDATE STATUS
    // ====================================================================
    public boolean updateStatus(int orderId, String status) throws SQLException {

        String sql = "UPDATE orders SET status = ? WHERE id = ?";

        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;
        }
    }

    // ====================================================================
    // UPDATE CART & TOTAL
    // ====================================================================
    public boolean updateCart(int orderId, int newCartId, int newTotal) throws SQLException {

        String sql = "UPDATE orders SET cart_id = ?, total_amount = ? WHERE id = ?";

        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, newCartId);
            ps.setInt(2, newTotal);
            ps.setInt(3, orderId);

            return ps.executeUpdate() > 0;
        }
    }

    // ====================================================================
    // DELETE ORDER (Controller yêu cầu!)
    // ====================================================================
    public boolean deleteOrder(int id) throws SQLException {

        String sql = "DELETE FROM orders WHERE id = ?";

        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // ====================================================================
    // MAP RESULTSET TO OBJECT
    // ====================================================================
    private Order mapOrder(ResultSet rs) throws SQLException {
        Order o = new Order();

        o.setId(rs.getInt("id"));

        int cartId = rs.getInt("cart_id");
        o.setCartId(rs.wasNull() ? null : cartId);

        o.setFullName(rs.getString("full_name"));
        o.setPhone(rs.getString("phone"));
        o.setShippingAddress(rs.getString("shipping_address"));
        o.setTotalAmount(rs.getInt("total_amount"));
        o.setStatus(rs.getString("status"));
        o.setPayment(rs.getBoolean("payment"));
        o.setOrderDate(rs.getTimestamp("order_date"));

        return o;
    }
}
