package com.medsystem.controller;

//import com.medsystem.bo.authBO;
//import com.medsystem.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
//    private final authBO authBO = new authBO(); // Sau này dùng để xử lý đăng ký

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Forward đến trang đăng ký
        req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
    }

    // Sau này mở comment để xử lý POST khi submit form đăng ký
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String email = req.getParameter("email");
//        String password = req.getParameter("password");
//        String fullName = req.getParameter("fullName");
//
//        try {
//            User user = authBO.register(email, password, fullName); // Gọi BO để xử lý đăng ký
//            HttpSession session = req.getSession();
//            session.setAttribute("user", user); // Lưu user vào session
//            resp.sendRedirect("/"); // Chuyển đến home sau khi đăng ký thành công
//        } catch (Exception e) {
//            req.setAttribute("error", e.getMessage());
//            doGet(req, resp); // Forward lại trang register với error
//        }
//    }
}
