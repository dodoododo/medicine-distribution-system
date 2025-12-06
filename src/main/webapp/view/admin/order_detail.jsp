<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.medsystem.model.bean.Order" %>
<%@ page import="com.medsystem.model.bean.Cart" %>

<%
    Order order = (Order) request.getAttribute("order");
    Cart cart = order != null ? order.getCart() : null;
%>

<div class="container mt-4">

    <a href="<%= request.getContextPath() %>/admin/orders" class="btn btn-secondary mb-3">
        ← Quay lại danh sách
    </a>

    <div class="card shadow-sm">
        <div class="card-body">

            <h3 class="text-success mb-3">Chi tiết đơn hàng #<%= order.getId() %></h3>

            <p><strong>Họ tên:</strong> <%= order.getFullName() %></p>
            <p><strong>SĐT:</strong> <%= order.getPhone() %></p>
            <p><strong>Địa chỉ giao hàng:</strong> <%= order.getShippingAddress() %></p>
            <p><strong>Tổng tiền:</strong> 
                <span class="text-danger fw-bold">
                    <%= String.format("%,d", order.getTotalAmount()) %> đ
                </span>
            </p>
            <p><strong>Trạng thái:</strong> <span class="badge bg-info"><%= order.getStatus() %></span></p>
            <p><strong>Thanh toán:</strong>
                <%= "DELIVERED".equalsIgnoreCase(order.getStatus()) ? "<span class='text-success'>Đã thanh toán</span>"
                                      : "<span class='text-danger'>Chưa thanh toán</span>" %>
            </p>

            <hr>

            <h5 class="mt-3">Thông tin giỏ hàng</h5>

            <%
                if (cart != null && cart.getItems() != null) {
            %>

            <table class="table table-bordered mt-3">
                <thead class="table-light">
                    <tr>
                        <th>Sản phẩm</th>
                        <th>SL</th>
                        <th>Giá</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                <% for (var item : cart.getItems()) { %>
                    <tr>
                        <td><%= item.getProduct().getName() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td><%= String.format("%,d", item.getProduct().getPrice()) %> đ</td>
                        <td class="text-danger">
                            <%= String.format("%,d", item.getProduct().getPrice() * item.getQuantity()) %> đ
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>

            <% } else { %>
                <p>Không có giỏ hàng.</p>
            <% } %>

        </div>
    </div>
</div>
