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
            session.setAttribute("user", user); // lưu session

            if (user.isAdmin()) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/");
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/view/login.jsp").forward(req, resp);
        }
    }
}