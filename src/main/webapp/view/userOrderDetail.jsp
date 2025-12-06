<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.medsystem.model.bean.Order" %>
<%@ page import="com.medsystem.model.bean.Cart" %>
<%@ page import="com.medsystem.model.bean.CartProduct" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <style>
        body { background-color: #f5f6fa; }
        .card { border-radius: 12px; }
        .product-img { width: 60px; height: 60px; object-fit: cover; border-radius: 6px; }
    </style>
</head>

<body>
<%@ include file="header.jsp" %>
<div class="container py-4">

    <a href="<%= request.getContextPath() %>/my-orders" class="btn btn-secondary mb-3">← Quay lại</a>

    <%
        Order order = (Order) request.getAttribute("order");
        String errorDetail = (String) request.getAttribute("error");
        if (errorDetail != null) {
    %>
        <div class="alert alert-danger"><%= errorDetail %></div>
    <% } %>

    <% if (order == null) { %>
        <div class="alert alert-danger">Không có dữ liệu đơn hàng.</div>
    <% } else {

        Cart cart = order.getCart();
        List<CartProduct> products = (cart != null) ? cart.getItems() : null;
    %>

    <div class="card shadow mb-4">
        <div class="card-body">
            <h3 class="mb-3">Đơn hàng #<%= order.getId() %></h3>

            <p><strong>Ngày đặt:</strong> <%= order.getOrderDate() %></p>
            <p><strong>Trạng thái:</strong> <span class="badge bg-info"><%= order.getStatus() %></span></p>
            <p><strong>Tên người nhận:</strong> <%= order.getFullName() %></p>
            <p><strong>Số điện thoại:</strong> <%= order.getPhone() %></p>
            <p><strong>Địa chỉ giao hàng:</strong> <%= order.getShippingAddress() %></p>
            <p><strong>Thanh toán:</strong>
                <% if (order.isPayment()) { %>
                    <span class="badge bg-success">Banking</span>
                <% } else { %>
                    <span class="badge bg-danger">Tiền Mặt</span>
                <% } %>
            </p>
        </div>
    </div>

    <div class="card shadow">
        <div class="card-body">
            <h4 class="mb-3">Sản phẩm trong đơn</h4>

            <% if (products == null || products.isEmpty()) { %>
                <div class="alert alert-warning">Giỏ hàng trống.</div>
            <% } else { %>

                <table class="table align-middle">
                    <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                    </tr>
                    </thead>

                    <tbody>
                    <% for (CartProduct cp : products) { %>
                        <tr>
                            <td>
                                <img src="<%= cp.getProduct().getImageUrl() %>" class="product-img me-2">
                                <%= cp.getProduct().getName() %>
                            </td>
                            <td><%= String.format("%,d", cp.getProduct().getPrice()) %> VND</td>
                            <td><%= cp.getQuantity() %></td>
                            <td><strong><%= String.format("%,d", cp.getProduct().getPrice() * cp.getQuantity()) %> VND</strong></td>
                        </tr>
                    <% } %>

                    <tr class="table-secondary">
                        <td colspan="3" class="text-end"><strong>Tổng cộng:</strong></td>
                        <td><strong><%= String.format("%,d", order.getTotalAmount()) %> VND</strong></td>
                    </tr>
                    </tbody>
                </table>

            <% } %>
        </div>
    </div>

    <% } %>

</div>
<%@ include file="footer.jsp" %>
</body>
</html>
