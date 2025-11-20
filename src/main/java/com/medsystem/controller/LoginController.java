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

@WebServlet("/login")
public class LoginController extends HttpServlet {
//    private final authBO authBO = new authBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/login.jsp").forward(req, resp);
    }

//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String email = req.getParameter("email");
//        String password = req.getParameter("password");
//
//        try {
//            User user = authBO.login(email, password); // Gọi BO để xử lý login
//            HttpSession session = req.getSession();
//            session.setAttribute("user", user); // Lưu object User vào session (hoặc chỉ username nếu cần)
//            if (user.isAdmin()) { // Giả sử User có method isAdmin() để kiểm tra role (true cho admin)
//                resp.sendRedirect("/admin/dashboard.jsp");
//            } else {
//                resp.sendRedirect("/");
//            }
//        } catch (Exception e) {
//            req.setAttribute("error", e.getMessage());
//            doGet(req, resp); // Forward lại trang login với error
//        }
//    }
}