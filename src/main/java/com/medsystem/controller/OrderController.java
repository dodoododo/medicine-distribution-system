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

@WebServlet("/order")
public class OrderController extends HttpServlet {

    private OrderBO orderBO = new OrderBO();
    private CartBO cartBO = new CartBO();

    // ===================== GET =======================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "checkout";

        switch (action) {

            case "view":
                viewOrderDetail(request, response);
                break;

            case "success":
                request.getRequestDispatcher("/view/order_success.jsp").forward(request, response);
                break;

            default:
                showCheckout(request, response);
        }
    }

    // ===================== POST ======================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "place":
                placeOrder(request, response);
                break;

            default:
                response.sendRedirect("/view/error.jsp");
        }
    }

    // ============================================================
    // 1. Trang checkout
    // ============================================================

    private void showCheckout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Cart cart = cartBO.getNewestCartByUserId(user.getId());
        if (cart == null || cart.getItems().isEmpty()) {
            request.setAttribute("message", "Giỏ hàng trống.");
            request.getRequestDispatcher("/cart").forward(request, response);
            return;
        }

        request.setAttribute("cart", cart);
        request.getRequestDispatcher("/view/checkout.jsp").forward(request, response);
    }

    // ============================================================
    // 2. Đặt hàng
    // ============================================================

    private void placeOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("streetAddress");
        String paymentMethod = request.getParameter("paymentMethod");

        boolean payment = paymentMethod.equals("bank") ? true : false;

        Cart cart = cartBO.getNewestCartByUserId(user.getId());

        if (cart == null || cart.getItems().isEmpty()) {
            request.setAttribute("message", "Giỏ hàng rỗng.");
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
            return;
        }

        try {
        	Order order = new Order(
        	        cart.getId(),
        	        fullName,
        	        phone,
        	        address,
        	        cart.getTotalPrice(),
        	        payment
        	);

        	int orderId = orderBO.createOrder(order);


            if (orderId > 0) {
                // Tạo cart mới cho user
                cartBO.createCart(user.getId());
                response.sendRedirect(request.getContextPath() + "/order?action=success");
                return;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("message", "Không thể đặt hàng.");
        request.getRequestDispatcher("/view/checkout.jsp").forward(request, response);
    }

    // ============================================================
    // 3. Xem chi tiết đơn của user
    // ============================================================

    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Order order = orderBO.getOrderById(id);
            if (order == null) {
                request.setAttribute("message", "Không tìm thấy đơn hàng.");
                request.getRequestDispatcher("/view/order_list.jsp").forward(request, response);
                return;
            }

            Cart cart = cartBO.getCartById(order.getCartId());
            order.setCart(cart);

            request.setAttribute("order", order);
            request.getRequestDispatcher("/view/order_detail.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
