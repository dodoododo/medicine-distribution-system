package com.medsystem.model.dao;

import com.medsystem.model.bean.Order;
import com.medsystem.connection.ConnectJDBC;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // Tạo đơn hàng mới
    public int createOrder(Order order) throws SQLException {
        String sql = "INSERT INTO orders (cart_id, full_name, phone, shipping_address, total_amount, status, payment) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        Connection conn = ConnectJDBC.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        ps.setInt(1, order.getCartId());
        ps.setString(2, order.getFullName());
        ps.setString(3, order.getPhone());
        ps.setString(4, order.getShippingAddress());
        ps.setInt(5, order.getTotalAmount());
        ps.setString(6, order.getStatus());
        ps.setBoolean(7, order.isPayment());

        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) return rs.getInt(1);

        return 0;
    }

    // Lấy toàn bộ đơn cho admin
    public List<Order> getAllOrders() throws SQLException {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";

        Connection conn = ConnectJDBC.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            list.add(mapOrder(rs));
        }
        return list;
    }

    // Lấy order theo ID
    public Order getOrderById(int id) throws SQLException {
        String sql = "SELECT * FROM orders WHERE id = ?";

        Connection conn = ConnectJDBC.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) return mapOrder(rs);
        return null;
    }

    // Lấy order theo cartId
    public Order getOrderByCart(int cartId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE cart_id = ?";

        Connection conn = ConnectJDBC.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, cartId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) return mapOrder(rs);
        return null;
    }

    // Admin cập nhật trạng thái
    public boolean updateStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        Connection conn = ConnectJDBC.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, status);
        ps.setInt(2, orderId);

        return ps.executeUpdate() > 0;
    }

    // Admin thay đổi cartId và tổng tiền
    public boolean updateCart(int orderId, int newCartId, int newTotal) throws SQLException {
        String sql = "UPDATE orders SET cart_id = ?, total_amount = ? WHERE id = ?";

        Connection conn = ConnectJDBC.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, newCartId);
        ps.setInt(2, newTotal);
        ps.setInt(3, orderId);

        return ps.executeUpdate() > 0;
    }

    // Helper: map resultset → Order object
    private Order mapOrder(ResultSet rs) throws SQLException {
        Order o = new Order();

        o.setId(rs.getInt("id"));
        o.setCartId(rs.getInt("cart_id"));
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
