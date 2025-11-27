<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
    com.medsystem.model.bean.User user = (com.medsystem.model.bean.User) request.getAttribute("user");
%>

<main class="container mt-5" style="padding-bottom: 40px;">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-white text-center">
                    <h4><i class="fas fa-user icon-med me-2"></i> Thông tin cá nhân</h4>
                </div>
                <div class="card-body">
                    <% if(request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                    <% } %>
                    <% if(request.getAttribute("success") != null) { %>
                        <div class="alert alert-success"><%= request.getAttribute("success") %></div>
                    <% } %>

                    <form action="<%=request.getContextPath()%>/profile" method="POST">
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" value="<%=user.getEmail()%>" disabled>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Role</label>
                            <input type="text" class="form-control" value="<%=user.isAdmin() ? "Admin" : "User"%>" disabled>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ngày tạo</label>
                            <input type="text" class="form-control" value="<%=user.getCreatedAt()%>" disabled>
                        </div>
						<div class="mb-3">
						    <label class="form-label">Họ và tên</label>
						    <input type="text" class="form-control" name="fullName" value="<%=user.getFullName()%>" required>
						</div>
						<div class="mb-3">
						    <label class="form-label">Số điện thoại</label>
						    <input type="text" class="form-control" name="phone" value="<%=user.getPhone()%>">
						</div>
						<div class="mb-3">
						    <label class="form-label">Địa chỉ</label>
						    <textarea class="form-control" name="address"><%=user.getAddress()%></textarea>
						</div>
						
						<!-- Button dẫn tới trang đổi mật khẩu -->
						<div class="mb-3 text-end">
						    <a href="<%=request.getContextPath()%>/changepassword?id=<%=user.getId()%>" class="btn btn-warning">Đổi mật khẩu</a>
						</div>
                        <button type="submit" class="btn btn-primary w-100">Cập nhật</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>
