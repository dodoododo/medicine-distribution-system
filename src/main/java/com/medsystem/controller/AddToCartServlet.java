package com.medsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.medsystem.model.bean.Cart;
import com.medsystem.model.bean.CartProduct;
import com.medsystem.model.bean.Product;
import com.medsystem.model.dao.CartProductDAO;
import com.medsystem.model.dao.ProductDAO;

@WebServlet("/cart/add")
public class AddToCartServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CartProductDAO cartProductDAO = new CartProductDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int productId = Integer.parseInt(req.getParameter("productId"));

        // Lấy product từ DB
        Product product = productDAO.getProductById(productId);
        if (product == null) {
            resp.sendRedirect("error.jsp");
            return;
        }

        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        // Nếu chưa có cart trong session, tạo mới
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        List<CartProduct> items = cart.getItems();
        if (items == null) {
            items = new ArrayList<>();
            cart.setItems(items);
        }

        CartProduct existed = cartProductDAO.getByCartAndProduct(cart.getId(), productId);

        if (existed != null) {
            // Đã có trong DB -> tăng quantity
            existed.setQuantity(existed.getQuantity() + 1);
            cartProductDAO.addOrUpdate(existed);
        } else {
            // Chưa có -> tạo mới
            CartProduct cp = new CartProduct();
            cp.setCartId(cart.getId());
            cp.setProductId(product.getId());
            cp.setQuantity(1);
            cp.setProduct(product);
            cartProductDAO.add(cp);
        }

        session.setAttribute("cart", cart);

        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}

