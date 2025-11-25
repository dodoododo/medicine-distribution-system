package com.medsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.medsystem.model.bean.User;
import com.medsystem.model.bo.AuthBO;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private final AuthBO authBO = new AuthBO();

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
            session.setAttribute("user", user);
            session.setAttribute("role", user.isAdmin() ? "ADMIN" : "CUSTOMER"); // thêm role riêng trong session

            if (user.isAdmin()) {
                req.setAttribute("mainPage", "/view/admin/category_list.jsp");
                req.getRequestDispatcher("/view/admin/admin_layout.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/"); // student về home
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/view/login.jsp").forward(req, resp);
        }
    }
}
