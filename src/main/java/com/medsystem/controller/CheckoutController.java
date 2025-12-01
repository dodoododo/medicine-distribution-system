package com.medsystem.controller;

import com.medsystem.connection.ConnectJDBC;
import com.medsystem.model.bean.Cart;
import com.medsystem.model.bean.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

@WebServlet("/placeOrder")
public class CheckoutController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String address = req.getParameter("streetAddress");

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/view/cart.jsp");
            return;
        }
        Integer cartId = cart.getId();

        Double totalDouble = (Double) session.getAttribute("cartTotal");
        if (totalDouble == null) totalDouble = 0.0;
        BigDecimal totalAmount = BigDecimal.valueOf(totalDouble);

        Order order = new Order();
        order.setCartId(cartId);
        order.setFullName(fullName);
        order.setPhone(phone);
        order.setShippingAddress(address);
        order.setTotalAmount(totalAmount);
        order.setStatus("PENDING");
        order.setOrderDate(new Timestamp(System.currentTimeMillis()));

        // Lưu Order vào DB
        String sql = "INSERT INTO orders (cart_id, full_name, phone, shipping_address, total_amount, status, order_date) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, order.getCartId());
            ps.setString(2, order.getFullName());
            ps.setString(3, order.getPhone());
            ps.setString(4, order.getShippingAddress());
            ps.setBigDecimal(5, order.getTotalAmount());
            ps.setString(6, order.getStatus());
            ps.setTimestamp(7, order.getOrderDate());

            int result = ps.executeUpdate();
            if (result > 0) {
                session.removeAttribute("cart");
                session.removeAttribute("cartTotal");
                session.removeAttribute("cartSubtotal");

                resp.sendRedirect(req.getContextPath() + "/orderSuccess.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/checkout.jsp?error=fail");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/checkout.jsp?error=exception");
        }
    }
}
