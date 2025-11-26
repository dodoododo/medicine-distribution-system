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
        // Lấy session hiện tại, không tạo session mới
        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        // Nếu chưa login → redirect login
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy id từ query string, nếu không có thì dùng id của currentUser
        String idParam = req.getParameter("id");
        int userId = (idParam != null) ? Integer.parseInt(idParam) : currentUser.getId();

        try {
            if (idParam != null && !idParam.isEmpty()) {
                userId = Integer.parseInt(idParam);
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "ID không hợp lệ!");
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        // Chỉ cho phép user xem profile của chính mình
        if (userId != currentUser.getId()) {
            req.setAttribute("error", "Bạn không có quyền xem profile này!");
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        try {
            User user = userBO.getUserById(userId);
            req.setAttribute("user", user);
            req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullName = req.getParameter("fullName");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        currentUser.setFullName(fullName);
        currentUser.setPassword(password);
        currentUser.setPhone(phone);
        currentUser.setAddress(address);

        try {
            userBO.updateUser(currentUser);
            session.setAttribute("user", currentUser); // Cập nhật session
            req.setAttribute("success", "Cập nhật thông tin thành công!");
            req.setAttribute("user", currentUser);
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }

        req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
    }
}