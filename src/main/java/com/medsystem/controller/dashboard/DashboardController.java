package com.medsystem.controller.dashboard;

import com.medsystem.model.dao.DashboardDAO; 

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "DashboardController", urlPatterns = {"/admin/dashboard"})
public class DashboardController extends HttpServlet {
    private final DashboardDAO dao = new DashboardDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int totalUsers = dao.countUsers();
            int totalProducts = dao.countProducts();
            double revenue = dao.totalRevenue();
            req.setAttribute("totalUsers", totalUsers);
            req.setAttribute("totalProducts", totalProducts);
            req.setAttribute("totalRevenue", revenue);
            req.getRequestDispatcher("/WEB-INF/admin/dashboard.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
