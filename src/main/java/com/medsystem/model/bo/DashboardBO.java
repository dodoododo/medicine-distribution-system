package com.medsystem.model.bo;

import com.medsystem.model.dao.DashboardDAO;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class DashboardBO {

    private final DashboardDAO dao = new DashboardDAO();

    public int countUsers() throws SQLException {
        return dao.countUsers();
    }

    public int countProducts() throws SQLException {
        return dao.countProducts();
    }

    public int totalRevenue() throws SQLException {
        return dao.totalRevenue();
    }

    public Map<String, Integer> revenueByDay() throws SQLException {
        return dao.revenueByDay();
    }

    public List<Map<String, Object>> topUsersSpent() throws SQLException {
        return dao.topUsersSpent();
    }
    public List<Map<String,Object>> topProductsByRevenue() throws SQLException {
        return dao.topProductsByRevenue();
    }
}
