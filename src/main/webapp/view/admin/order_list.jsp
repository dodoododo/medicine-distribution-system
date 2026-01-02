<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.medsystem.model.bean.Order" %>

<%
    List<Order> orders = (List<Order>) request.getAttribute("orderList");
%>

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="text-primary">Quản lý đơn hàng</h3>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Khách hàng</th>
                        <th>Số điện thoại</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Thanh toán</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>

                <%
                    if (orders != null) {
                        for (Order o : orders) {
                %>
                    <tr>
                        <td><%= o.getId() %></td>
                        <td><%= o.getFullName() %></td>
                        <td><%= o.getPhone() %></td>
                        <td class="text-danger fw-bold"><%= String.format("%,d", o.getTotalAmount()) %> đ</td>
                        <td>
						    <%
						        String status = o.getStatus();
						        String badgeClass = "secondary"; // default
						
						        switch (status) {
						            case "PENDING":
						                badgeClass = "secondary";
						                break;
						            case "PROCESSING":
						                badgeClass = "info";
						                break;
						            case "SHIPPING":
						                badgeClass = "primary";
						                break;
						            case "DELIVERED":
						                badgeClass = "success";
						                break;
						            case "CANCELLED":
						                badgeClass = "danger";
						                break;
						        }
						    %>
						    <span class="badge bg-<%= badgeClass %>">
						        <%= status %>
						    </span>
						</td>

                        <td>
                            <%= "DELIVERED".equalsIgnoreCase(o.getStatus()) ? "<span class='text-success fw-bold'>Đã TT</span>" :
                                                "<span class='text-danger fw-bold'>Chưa TT</span>" %>
                        </td>
                        <td>
                            <a href="<%= request.getContextPath() %>/admin/orders?action=view&id=<%= o.getId() %>"
                               class="btn btn-sm btn-primary">Xem</a>

                            <a href="<%= request.getContextPath() %>/admin/orders?action=edit&id=<%= o.getId() %>"
                               class="btn btn-sm btn-warning">Sửa</a>

                            <a href="<%= request.getContextPath() %>/admin/orders?action=delete&id=<%= o.getId() %>"
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Bạn chắc chắn muốn xóa đơn này?');">
                                Xóa
                            </a>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>

                </tbody>
            </table>
        </div>
    </div>
</div>
