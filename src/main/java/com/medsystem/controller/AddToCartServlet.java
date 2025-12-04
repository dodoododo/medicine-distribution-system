package com.medsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import com.medsystem.model.bean.Cart;
import com.medsystem.model.bean.CartProduct;
import com.medsystem.model.bean.Product;
import com.medsystem.model.dao.CartDAO;
import com.medsystem.model.dao.CartProductDAO;
import com.medsystem.model.dao.ProductDAO;

@WebServlet("/cart/add")
public class AddToCartServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CartDAO cartDAO = new CartDAO();
    private final CartProductDAO cartProductDAO = new CartProductDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        // Lấy user ID từ session (đã đăng nhập)
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int productId = Integer.parseInt(req.getParameter("productId"));

        // Lấy sản phẩm
        Product product;
        try {
            product = productDAO.getProductById(productId);
            if (product == null) {
                resp.sendRedirect("error.jsp");
                return;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        try {
            // Lấy cart theo user. Nếu chưa có -> tạo mới
            Cart cart = cartDAO.getOrCreateCartByUserId(userId);

            // Kiểm tra product đã có trong cart chưa
            CartProduct existed = cartProductDAO.getByCartAndProduct(cart.getId(), productId);

            if (existed != null) {
                // đã tồn tại → update số lượng +1
                existed.setQuantity(existed.getQuantity() + 1);
                cartProductDAO.updateQuantity(existed.getId(), existed.getQuantity());

            } else {
                // chưa có → thêm mới vào DB
                CartProduct cp = new CartProduct();
                cp.setCartId(cart.getId());
                cp.setProductId(productId);
                cp.setQuantity(1);

                cartProductDAO.add(cp);
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }

        // trở về trang giỏ hàng
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
