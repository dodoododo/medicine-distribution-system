package com.medsystem.controller;

import com.medsystem.model.bean.User;
import com.medsystem.model.bo.AuthBO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private final AuthBO authBO = new AuthBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullName = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String address = ""; // Có thể thêm input address nếu muốn

        try {
            User user = authBO.register(fullName, email, password, phone, address);
            HttpSession session = req.getSession();
            session.setAttribute("user", user); // lưu session
            resp.sendRedirect(req.getContextPath() + "/"); // về home
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
        }
    }
}
