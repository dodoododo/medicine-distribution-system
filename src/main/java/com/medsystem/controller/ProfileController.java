package com.medsystem.controller;

import com.medsystem.model.bean.User;
import com.medsystem.model.bo.UserBO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {

    private final UserBO userBO = new UserBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            User user = userBO.getUserById(userId);
            req.setAttribute("user", user);
            req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Không tìm thấy người dùng: " + e.getMessage());
            req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            User user = userBO.getUserById(userId);

            // Lấy dữ liệu từ form
            String fullName = req.getParameter("fullName");
            String password = req.getParameter("password");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");

            // Cập nhật user
            user.setFullName(fullName);
            user.setPassword(password); // giữ nguyên, không mã hóa
            user.setPhone(phone);
            user.setAddress(address);

            userBO.updateUser(user);

            // Cập nhật lại session
            session.setAttribute("fullName", user.getFullName());

            req.setAttribute("success", "Cập nhật thông tin thành công!");
            req.setAttribute("user", user);
        } catch (Exception e) {
            req.setAttribute("error", "Cập nhật thất bại: " + e.getMessage());
        }

        req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
    }
}
