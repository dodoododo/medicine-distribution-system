package com.medsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.medsystem.model.bean.Cart;
import com.medsystem.model.bean.User;
import com.medsystem.model.bo.AuthBO;
import com.medsystem.model.dao.CartDAO;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private final AuthBO authBO = new AuthBO();
    private final CartDAO cartDAO = new CartDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            User user = authBO.login(email, password);
            HttpSession session = req.getSession();
            session.setAttribute("user", user); // lưu session
            Cart cart = cartDAO.getCartByUserId(user.getId());
            session.setAttribute("cart", cart);
            session.setAttribute("cartId", cart.getId());
            
            if (user.isAdmin()) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/");
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/view/login.jsp").forward(req, resp);
        }
    }
}
