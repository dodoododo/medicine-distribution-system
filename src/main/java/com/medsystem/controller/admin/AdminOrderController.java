//package com.medsystem.controller.admin;
//
//import com.medsystem.model.bean.Cart;
//import com.medsystem.model.bean.Order;
//import com.medsystem.model.bo.CartBO;
//import com.medsystem.model.bo.OrderBO;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//import java.sql.SQLException;
//import java.util.List;
//
//@WebServlet("/admin/order")
//public class AdminOrderController extends HttpServlet {
//
//    private OrderBO orderBO = new OrderBO();
//    private CartBO cartBO = new CartBO();
//
//    // ===================== GET ======================
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String action = request.getParameter("action");
//        if (action == null) action = "list";
//
//        switch (action) {
//
//            case "view":
//                viewOrder(request, response);
//                break;
//
//            default:
//                listOrders(request, response);
//        }
//    }
//
//    // ===================== POST =====================
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String action = request.getParameter("action");
//
//        switch (action) {
//
//            case "update-status":
//                updateStatus(request, response);
//                break;
//
//            case "update-cart":
//                updateCart(request, response);
//                break;
//
//            default:
//                response.sendRedirect("error.jsp");
//        }
//    }
//
//    // ============================================================
//    // 1. Danh sách order
//    // ============================================================
//
//    private void listOrders(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        try {
//            List<Order> orders = orderBO.getAllOrders();
//            request.setAttribute("orders", orders);
//            request.getRequestDispatcher("/view/admin/order_list.jsp").forward(request, response);
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
//
//    // ============================================================
//    // 2. Chi tiết order
//    // ============================================================
//
//    private void viewOrder(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        int id = Integer.parseInt(request.getParameter("id"));
//
//        try {
//            Order order = orderBO.getOrderById(id);
//            Cart cart = cartBO.getCartById(order.getCartId());
//            order.setCart(cart);
//
//            request.setAttribute("order", order);
//            request.getRequestDispatcher("/view/admin/order_detail.jsp").forward(request, response);
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
//
//    // ============================================================
//    // 3. Admin cập nhật trạng thái
//    // ============================================================
//
//    private void updateStatus(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//
//        int id = Integer.parseInt(request.getParameter("orderId"));
//        String status = request.getParameter("status");
//
//        try {
//            orderBO.updateStatus(id, status);
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        response.sendRedirect(request.getContextPath() + "/admin/order?action=view&id=" + id);
//    }
//
//    // ============================================================
//    // 4. Admin đổi cart (thay đổi sản phẩm trong đơn hàng)
//    // ============================================================
//
//    private void updateCart(HttpServletRequest request, HttpServletResponse response)
//            throws IOException {
//
//        int id = Integer.parseInt(request.getParameter("orderId"));
//        int cartId = Integer.parseInt(request.getParameter("cartId"));
//        int total = Integer.parseInt(request.getParameter("total"));
//
//        try {
//            orderBO.updateCart(id, cartId, total);
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        response.sendRedirect(request.getContextPath() + "/admin/order?action=view&id=" + id);
//    }
//}
