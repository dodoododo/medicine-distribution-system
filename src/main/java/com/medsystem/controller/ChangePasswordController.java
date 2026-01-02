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

@WebServlet("/changepassword")
public class ChangePasswordController extends HttpServlet {
    private final UserBO userBO = new UserBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.getRequestDispatcher("/view/changepassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String currentPassword = req.getParameter("currentPassword");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu mới không trùng nhau!");
            req.getRequestDispatcher("/view/changepassword.jsp").forward(req, resp);
            return;
        }

        if (!currentUser.getPassword().equals(currentPassword)) {
            req.setAttribute("error", "Mật khẩu hiện tại không đúng!");
            req.getRequestDispatcher("/view/changepassword.jsp").forward(req, resp);
            return;
        }

        try {
            userBO.updatePassword(currentUser.getId(), newPassword);
            currentUser.setPassword(newPassword);
            session.setAttribute("user", currentUser);

            req.setAttribute("success", "Đổi mật khẩu thành công!");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }

        req.getRequestDispatcher("/view/changepassword.jsp").forward(req, resp);
    }
}
