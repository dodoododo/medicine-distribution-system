package com.medsystem.controller;

import java.io.IOException;
import java.util.List;

import com.medsystem.model.bean.CartProduct;
import com.medsystem.model.dao.CartProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private final CartProductDAO cartProductDAO = new CartProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Integer cartId = (Integer) session.getAttribute("cartId");
        
        if (cartId == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // Lấy dữ liệu cart từ DB
        List<CartProduct> items = cartProductDAO.getProductsByCartId(cartId);
        req.setAttribute("cartItems", items);

        // Render cart.jsp
        req.getRequestDispatcher("/view/cart.jsp").forward(req, resp);
    }
}
