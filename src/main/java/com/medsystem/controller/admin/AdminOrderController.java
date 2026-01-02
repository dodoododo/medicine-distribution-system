package com.medsystem.controller.admin;

import com.medsystem.model.bean.Cart;
import com.medsystem.model.bean.Order;
import com.medsystem.model.bo.CartBO;
import com.medsystem.model.bo.OrderBO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderController extends HttpServlet {

    private final OrderBO orderBO = new OrderBO();
    private final CartBO cartBO = new CartBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                // form thêm mới
                req.setAttribute("mainPage", "/view/admin/order_form.jsp");

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Order order = orderBO.getOrderById(id);

                if (order == null) {
                    req.setAttribute("error", "Không tìm thấy đơn hàng!");
                } else {
                    req.setAttribute("order", order);
                }

                req.setAttribute("mainPage", "/view/admin/order_form.jsp");

            } else if ("view".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Order order = orderBO.getOrderById(id);

                if (order != null && order.getCartId() != null) {
                    Cart cart = cartBO.getCartById(order.getCartId());
                    order.setCart(cart);
                }

                req.setAttribute("order", order);
                req.setAttribute("mainPage", "/view/admin/order_detail.jsp");

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                orderBO.deleteOrder(id);
                resp.sendRedirect(req.getContextPath() + "/admin/orders");
                return;

            } else {
                // LIST ORDERS
                List<Order> orderList = orderBO.getAllOrders();
                req.setAttribute("orderList", orderList);

                req.setAttribute("mainPage", "/view/admin/order_list.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", e.getMessage());
            req.setAttribute("mainPage", "/view/admin/order_list.jsp");
        }

        req.getRequestDispatcher("/view/admin/admin_layout.jsp")
           .forward(req, resp);
    }

    // -------------------------------------------------------------
    // POST: CREATE OR UPDATE ORDER
    // -------------------------------------------------------------
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        boolean isEdit = idStr != null && !idStr.isEmpty();

        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String shippingAddress = req.getParameter("shippingAddress");
        int totalAmount = Integer.parseInt(req.getParameter("totalAmount"));
        String status = req.getParameter("status");
        boolean payment = Boolean.parseBoolean(req.getParameter("payment"));

        String cartStr = req.getParameter("cartId");
        Integer cartId = (cartStr == null || cartStr.isEmpty()) ? null : Integer.parseInt(cartStr);

        try {

            if (!isEdit) {
                // CREATE NEW ORDER
                Order o = new Order();
                o.setFullName(fullName);
                o.setPhone(phone);
                o.setShippingAddress(shippingAddress);
                o.setTotalAmount(totalAmount);
                o.setStatus(status);
                o.setPayment(payment);
                o.setCartId(cartId);

                orderBO.createOrder(o);

            } else {
                // UPDATE ORDER
                int id = Integer.parseInt(idStr);

                Order o = new Order();
                o.setId(id);
                o.setFullName(fullName);
                o.setPhone(phone);
                o.setShippingAddress(shippingAddress);
                o.setTotalAmount(totalAmount);
                o.setStatus(status);
                o.setPayment(payment);
                o.setCartId(cartId);

                orderBO.updateOrder(o);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/orders");
            return;

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", e.getMessage());
            req.setAttribute("mainPage", "/view/admin/order_form.jsp");
        }

        req.getRequestDispatcher("/view/admin/admin_layout.jsp")
           .forward(req, resp);
    }
}
