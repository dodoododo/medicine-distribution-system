package com.medsystem.model.bo;

import com.medsystem.model.bean.Order;
import com.medsystem.model.dao.OrderDAO;

import java.sql.SQLException;
import java.util.List;

public class OrderBO {

    private OrderDAO orderDAO = new OrderDAO();

    public int createOrder(Order o) throws SQLException {
        return orderDAO.createOrder(o);
    }

    public List<Order> getAllOrders() throws SQLException {
        return orderDAO.getAllOrders();
    }

    public Order getOrderById(int id) throws SQLException {
        return orderDAO.getOrderById(id);
    }

    public Order getOrderByCartId(int cartId) throws SQLException {
        return orderDAO.getOrderByCart(cartId);
    }

    public boolean updateStatus(int id, String status) throws SQLException {
        return orderDAO.updateStatus(id, status);
    }

    public boolean updateCart(int id, int cartId, int total) throws SQLException {
        return orderDAO.updateCart(id, cartId, total);
    }
}
