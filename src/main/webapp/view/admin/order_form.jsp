<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.medsystem.model.bean.Order" %>

<%
    Order order = (Order) request.getAttribute("order");
    boolean isEdit = (order != null && order.getId() > 0);
%>

<div class="container mt-4">

    <a href="<%= request.getContextPath() %>/admin/orders" class="btn btn-secondary mb-3">
        ← Quay lại danh sách
    </a>

    <div class="card shadow-sm">
        <div class="card-body">

            <h3 class="text-primary mb-3">
                <%= isEdit ? "Chỉnh sửa đơn hàng" : "Thêm đơn hàng mới" %>
            </h3>

            <form method="post" action="<%= request.getContextPath() %>/admin/orders">

                <% if (isEdit) { %>
                    <input type="hidden" name="id" value="<%= order.getId() %>">
                <% } %>

                <div class="mb-3">
                    <label class="form-label">Họ tên khách hàng</label>
                    <input type="text" class="form-control" name="fullName"
                           value="<%= isEdit ? order.getFullName() : "" %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Số điện thoại</label>
                    <input type="text" class="form-control" name="phone"
                           value="<%= isEdit ? order.getPhone() : "" %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Địa chỉ giao hàng</label>
                    <textarea class="form-control" name="shippingAddress" required><%= isEdit ? order.getShippingAddress() : "" %>
                    </textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Tổng tiền</label>
                    <input type="number" class="form-control" name="totalAmount"
                           value="<%= isEdit ? order.getTotalAmount() : 0 %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Trạng thái</label>
                    <select class="form-select" name="status">
						<option value="PENDING" <%= isEdit && "PENDING".equals(order.getStatus()) ? "selected" : "" %>>
						    Chờ xác nhận
						</option>
						
						<option value="PROCESSING" <%= isEdit && "PROCESSING".equals(order.getStatus()) ? "selected" : "" %>>
						    Đang gói hàng
						</option>
						
						<option value="SHIPPING" <%= isEdit && "SHIPPING".equals(order.getStatus()) ? "selected" : "" %>>
						    Đang giao
						</option>
						
						<option value="DELIVERED" <%= isEdit && "DELIVERED".equals(order.getStatus()) ? "selected" : "" %>>
						    Đã giao
						</option>
						
						<option value="CANCELLED" <%= isEdit && "CANCELLED".equals(order.getStatus()) ? "selected" : "" %>>
						    Đã hủy
						</option>
                    </select>
                </div>
                
                <div class="mb-3">
				    <label class="form-label">Loại thanh toán</label>
				    <select class="form-control" name="payment" required>
				        <option value="false" <%= isEdit && order.isPayment() == false ? "selected" : "" %>>
				            Tiền mặt
				        </option>
				        <option value="true" <%= isEdit && order.isPayment() == true ? "selected" : "" %>>
				            Banking
				        </option>
				    </select>
				</div>
				
				<% if (isEdit) { %>
				    <input type="hidden" name="cartId" value="<%= order.getCartId() %>">
				<% } %>
                <button class="btn btn-success px-4">Lưu</button>

            </form>
        </div>
    </div>
</div>
