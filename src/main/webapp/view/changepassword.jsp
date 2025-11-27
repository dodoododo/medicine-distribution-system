<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<main class="container mt-5" style="padding-bottom: 40px;">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-header bg-white text-center">
                    <h4><i class="fas fa-key icon-med me-2"></i> Đổi mật khẩu</h4>
                </div>
                <div class="card-body">
                    <% if(request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                    <% } %>
                    <% if(request.getAttribute("success") != null) { %>
                        <div class="alert alert-success"><%= request.getAttribute("success") %></div>
                    <% } %>

                    <form action="<%=request.getContextPath()%>/changepassword" method="POST">
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu hiện tại</label>
                            <input type="password" class="form-control" name="currentPassword" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu mới</label>
                            <input type="password" class="form-control" name="newPassword" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Xác nhận mật khẩu mới</label>
                            <input type="password" class="form-control" name="confirmPassword" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Cập nhật mật khẩu</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>
