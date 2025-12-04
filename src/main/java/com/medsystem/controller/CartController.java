package com.medsystem.controller;

import java.io.IOException;

import com.medsystem.model.bo.CartBO;
import com.medsystem.model.bean.Cart;
import com.medsystem.model.bean.CartProduct;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    private final CartBO cartBO = new CartBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // --- Check login ---
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int sessionUserId = ((com.medsystem.model.bean.User) session.getAttribute("user")).getId();
        String userIdParam = req.getParameter("userId");

        if (userIdParam == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing userId");
            return;
        }

        int userId = Integer.parseInt(userIdParam);

        // --- Security: chỉ cho phép truy cập giỏ hàng của chính mình ---
        if (userId != sessionUserId) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        // --- NEW: xử lý checkout bằng GET ---
        String action = req.getParameter("action");
        if ("checkout".equals(action)) {

            Cart cart = cartBO.getCartByUserId(userId);

            double subtotal = cart.getItems().stream()
                    .mapToDouble(i -> i.getProduct().getPrice() * i.getQuantity())
                    .sum();

            req.setAttribute("user", session.getAttribute("user"));
            req.setAttribute("cart", cart);
            req.setAttribute("cartItems", cart.getItems());
            req.setAttribute("cartSubtotal", subtotal);
            req.setAttribute("cartTotal", subtotal);

            req.getRequestDispatcher("/view/checkout.jsp")
                    .forward(req, resp);

            return; // VERY IMPORTANT
        }

        // --- Lấy hoặc tạo cart ---
        Cart cart = cartBO.getCartByUserId(userId);

        req.setAttribute("cart", cart);
        req.setAttribute("cartItems", cart.getItems());
        req.setAttribute("cartId", cart.getId());

        req.getRequestDispatcher("/view/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // --- Check login ---
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // --- Lấy userId từ session ---
        int userId = ((com.medsystem.model.bean.User) session.getAttribute("user")).getId();

        // --- Lấy giỏ hàng ---
        Cart cart = cartBO.getCartByUserId(userId);
        int cartId = cart.getId();

        String action = req.getParameter("action");
        if (action == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing action");
            return;
        }

        switch (action) {

            case "add": {
                int productId = Integer.parseInt(req.getParameter("productId"));
                int quantity = Integer.parseInt(req.getParameter("quantity"));
                cartBO.addOrUpdateProduct(cartId, productId, quantity);
                break;
            }

            case "update": {
                int productId = Integer.parseInt(req.getParameter("productId"));
                int newQty = Integer.parseInt(req.getParameter("quantity"));
                cartBO.addOrUpdateProduct(cartId, productId, newQty - cartBO.getCartByUserId(userId)
                        .getItems()
                        .stream()
                        .filter(i -> i.getProductId() == productId)
                        .findFirst()
                        .orElseThrow()
                        .getQuantity());
                break;
            }

            case "delete": {
                int productId = Integer.parseInt(req.getParameter("productId"));
                cartBO.removeProductFromCart(cartId, productId);
                break;
            }

            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                return;
        }

        // Redirect lại giỏ hàng
        resp.sendRedirect(req.getContextPath() + "/cart?userId=" + userId);
    }
}
