<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.medsystem.model.bean.Order" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đơn hàng của tôi</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <style>
        body { background-color: #f8f9fa; }
        .card { border-radius: 12px; }
        .status-badge {
            padding: 6px 12px;
            border-radius: 6px;
            font-weight: 600;
        }
    </style>
</head>

<body>
<%@ include file="header.jsp" %>
<div class="container py-4">

    <h2 class="mb-4">📦 Đơn hàng của tôi</h2>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");
        if (orders == null || orders.isEmpty()) {
    %>

        <div class="alert alert-info">Bạn chưa có đơn hàng nào.</div>

    <% } else { %>

        <table class="table table-hover align-middle">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Ngày đặt</th>
                <th>Trạng thái</th>
                <th>Tổng tiền</th>
                <th>Thanh toán</th>
                <th></th>
            </tr>
            </thead>
            <tbody>

            <% for (Order o : orders) { %>
                <tr>
                    <td>#<%= o.getId() %></td>
                    <td><%= o.getOrderDate() %></td>

                    <td>
                        <span class="status-badge 
                            <% switch(o.getStatus()) {
                                  case "PENDING": %> bg-secondary text-white <% break;
                                  case "PROCESSING": %> bg-info text-dark <% break;
                                  case "SHIPPING": %> bg-warning text-dark <% break;
                                  case "DELIVERED": %> bg-success text-white <% break;
                                  case "CANCELLED": %> bg-danger text-white <% break;
                                } %>">
                            <%= o.getStatus() %>
                        </span>
                    </td>

                    <td><strong><%= String.format("%,d", o.getTotalAmount()) %> VND</strong></td>

                    <td>
                        <% if (o.isPayment()) { %>
                            <span class="badge bg-success">Banking</span>
                        <% } else { %>
                            <span class="badge bg-danger">Tiền Mặt</span>
                        <% } %>
                    </td>

                    <td>
                        <a href="<%= request.getContextPath() %>/my-orders?action=detail&id=<%= o.getId() %>"
                           class="btn btn-primary btn-sm">
                            Xem chi tiết
                        </a>
                    </td>
                </tr>
            <% } %>

            </tbody>
        </table>

    <% } %>

</div>
<%@ include file="footer.jsp" %>
</body>
</html>
