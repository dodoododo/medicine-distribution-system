package com.medsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin")
public class AdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy session hiện tại, không tạo mới
        HttpSession session = request.getSession(false);
        Object role = (session != null) ? session.getAttribute("role") : null;

        // Nếu không phải admin → logout
        if (role == null || !"ADMIN".equals(role.toString())) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        // Admin hợp lệ → chuyển tới dashboard mặc định
        request.setAttribute("mainPage", "/view/admin/category_list.jsp");
        request.getRequestDispatcher("/view/admin/admin_layout.jsp").forward(request, response);
    }
}
