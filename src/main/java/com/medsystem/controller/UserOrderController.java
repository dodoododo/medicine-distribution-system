package com.medsystem.controller;

import com.medsystem.model.bean.Cart;
import com.medsystem.model.bean.Order;
import com.medsystem.model.bean.User;
import com.medsystem.model.bo.CartBO;
import com.medsystem.model.bo.OrderBO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/my-orders")
public class UserOrderController extends HttpServlet {

    private final OrderBO orderBO = new OrderBO();
    private final CartBO cartBO = new CartBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "detail":
                showOrderDetail(req, resp, currentUser);
                break;

            default:
                showOrderList(req, resp, currentUser);
        }
    }

    // ============================================================
    // 📌 1. Danh sách đơn hàng của user
    // ============================================================
    private void showOrderList(HttpServletRequest req, HttpServletResponse resp, User currentUser)
            throws ServletException, IOException {

        try {
            // Lấy ALL orders
            List<Order> allOrders = orderBO.getAllOrders();

            // Chỉ giữ đơn có cart.userId == currentUser.id
            List<Order> userOrders = allOrders.stream()
                    .filter(o -> {
                        try {
                            Cart c = cartBO.getCartById(o.getCartId());
                            return c != null && c.getUserId() == currentUser.getId();
                        } catch (SQLException e) {
                            return false;
                        }
                    })
                    .toList();

            req.setAttribute("orders", userOrders);
            req.getRequestDispatcher("/view/userOrderList.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Không thể tải danh sách đơn hàng.");
            req.getRequestDispatcher("/view/userOrderList.jsp").forward(req, resp);
        }
    }

    // ============================================================
    // 📌 2. Chi tiết đơn hàng
    // ============================================================
    private void showOrderDetail(HttpServletRequest req, HttpServletResponse resp, User currentUser)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect(req.getContextPath() + "/my-orders");
            return;
        }

        int orderId = Integer.parseInt(idStr);

        try {
            Order order = orderBO.getOrderById(orderId);

            if (order == null) {
                req.setAttribute("error", "Không tìm thấy đơn hàng.");
                req.getRequestDispatcher("/view/userOrderDetail.jsp").forward(req, resp);
                return;
            }

            // Lấy cart để kiểm tra quyền sở hữu
            Cart cart = cartBO.getCartById(order.getCartId());
            order.setCart(cart);

            // Không phải cart của user → không cho xem
            if (cart == null || cart.getUserId() != currentUser.getId()) {
                resp.sendRedirect(req.getContextPath() + "/my-orders");
                return;
            }

            req.setAttribute("order", order);
            req.getRequestDispatcher("/view/userOrderDetail.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra.");
            req.getRequestDispatcher("/view/userOrderDetail.jsp").forward(req, resp);
        }
    }
}
