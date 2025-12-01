package com.medsystem.controller;

import java.io.IOException;

import com.medsystem.model.bean.Cart;
import com.medsystem.model.dao.CartProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart/remove")
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int cartProductId = Integer.parseInt(req.getParameter("cartProductId"));

        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if(cart != null && cart.getItems() != null){
            // Xóa khỏi list session
            cart.getItems().removeIf(cp -> cp.getId() == cartProductId);

            CartProductDAO cartProductDAO = new CartProductDAO();
            cartProductDAO.delete(cartProductId);
        }

        session.setAttribute("cart", cart);
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
