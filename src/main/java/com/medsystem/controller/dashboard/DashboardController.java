package com.medsystem.controller.dashboard;

import com.medsystem.model.bo.DashboardBO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;
import java.util.List;

@WebServlet("/admin/dashboard")
public class DashboardController extends HttpServlet {

    private final DashboardBO dashboardBO = new DashboardBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // --- Thống kê ---
            int totalUsers = dashboardBO.countUsers();
            int totalProducts = dashboardBO.countProducts();
            double totalRevenue = dashboardBO.totalRevenue();
            Map<String, Integer> revenueByDay = dashboardBO.revenueByDay();
            List<Map<String, Object>> topUsers = dashboardBO.topUsersSpent();

            // --- Gán attribute cho JSP ---
            req.setAttribute("totalUsers", totalUsers);
            req.setAttribute("totalProducts", totalProducts);
            req.setAttribute("totalRevenue", totalRevenue);
            req.setAttribute("revenueByDay", revenueByDay);
            req.setAttribute("topUsers", topUsers);
            
            List<Map<String,Object>> topProducts = dashboardBO.topProductsByRevenue();
            req.setAttribute("topProducts", topProducts);


            // --- Xác định trang con để render vào layout ---
            req.setAttribute("mainPage", "/view/admin/dashboard.jsp");

        } catch (SQLException e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("mainPage", "/view/admin/dashboard.jsp");
        }

        // --- Forward vào layout chung ---
        req.getRequestDispatcher("/view/admin/admin_layout.jsp")
           .forward(req, resp);
    }
}
