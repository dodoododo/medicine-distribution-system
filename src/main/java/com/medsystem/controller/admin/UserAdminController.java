package com.medsystem.controller.admin;

import com.medsystem.model.bean.User;
import com.medsystem.model.bo.UserBO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class UserAdminController extends HttpServlet {
    private final UserBO userBO = new UserBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            if ("new".equals(action)) {
                req.setAttribute("user", new User());
                req.setAttribute("formAction", "new");
                req.setAttribute("mainPage", "/view/admin/user_form.jsp");

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                User u = userBO.getUserById(id);

                req.setAttribute("user", u);
                req.setAttribute("formAction", "edit");
                req.setAttribute("mainPage", "/view/admin/user_form.jsp");

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                userBO.deleteUser(id);

                resp.sendRedirect(req.getContextPath() + "/admin/users");
                return;

            } else {
                List<User> list = userBO.getAllUsers();
                req.setAttribute("userList", list);
                req.setAttribute("mainPage", "/view/admin/user_list.jsp");
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("mainPage", "/view/admin/user_list.jsp");
        }

        req.getRequestDispatcher("/view/admin/admin_layout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        try {
            String formAction = req.getParameter("formAction"); // "new" hoặc "edit"
            String idParam = req.getParameter("id");

            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");   // có thể rỗng
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");
            int role = "1".equals(req.getParameter("role")) ? 1 : 0;

            User u;

            // ------------- EDIT USER -------------
            if ("edit".equals(formAction) && idParam != null && !idParam.isEmpty()) {

                int userId = Integer.parseInt(idParam);
                u = userBO.getUserById(userId);

                // Update thông tin cơ bản
                u.setFullName(fullName);
                u.setEmail(email);
                u.setPhone(phone);
                u.setAddress(address);
                u.setRole(role);

                // Nếu admin nhập mật khẩu mới → đổi mật khẩu
                if (password != null && !password.trim().isEmpty()) {
                    userBO.updatePassword(userId, password);
                }

                // Update thông tin user (không đụng vào password)
                userBO.updateUserInfo(u);
            }

            // ------------- ADD USER -------------
            else {
                u = new User();
                u.setFullName(fullName);
                u.setEmail(email);
                u.setPassword(password);   // thêm mới bắt buộc cần password
                u.setPhone(phone);
                u.setAddress(address);
                u.setRole(role);

                userBO.addUser(u);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/users");

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("user", new User());
            req.setAttribute("formAction", "new");
            req.setAttribute("mainPage", "/view/admin/user_form.jsp");

            req.getRequestDispatcher("/view/admin/admin_layout.jsp").forward(req, resp);
        }
    }
}
