//package com.medsystem.controller;
//
//import com.medsystem.model.bean.User;
//import com.medsystem.model.bo.UserBO;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//
//@WebServlet(name="UserController", urlPatterns = {"/login","/logout","/profile"})
//public class UserController extends HttpServlet {
//
//    private final UserBO userBO = new UserBO();
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String path = req.getServletPath();
//        HttpSession session = req.getSession(false);
//
//        switch (path) {
//            case "/logout":
//                if (session != null) session.invalidate();
//                resp.sendRedirect(req.getContextPath() + "/login.jsp");
//                break;
//
//            case "/profile":
//                if (session == null || session.getAttribute("userId") == null) {
//                    resp.sendRedirect(req.getContextPath() + "/login.jsp");
//                    return;
//                }
//                req.getRequestDispatcher("/WEB-INF/user/profile.jsp").forward(req, resp);
//                break;
//
//            case "/login":
//            default:
//                req.getRequestDispatcher("/login.jsp").forward(req, resp);
//                break;
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String path = req.getServletPath();
//        if ("/login".equals(path)) {
//            String email = req.getParameter("email");
//            String password = req.getParameter("password");
//
//            User user = userBO.getByEmail(email);
//            if (user != null && password.equals(user.getPassword())) {
//                HttpSession session = req.getSession(true);
//                session.setAttribute("userId", user.getId());
//                session.setAttribute("role", user.getRole()); // 1 = admin, 0 = user
//                session.setAttribute("fullName", user.getFullName());
//
//                if (user.isAdmin()) {
//                    resp.sendRedirect(req.getContextPath() + "/admin");
//                } else {
//                    resp.sendRedirect(req.getContextPath() + "/home");
//                }
//            } else {
//                req.setAttribute("error", "Email hoặc mật khẩu không đúng");
//                req.getRequestDispatcher("/login.jsp").forward(req, resp);
//            }
//        }
//    }
//}
