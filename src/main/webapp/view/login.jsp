<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>

<main class="container mt-5" style="padding-bottom: 40px;">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-header text-center bg-white">
                    <h4><i class="fas fa-sign-in-alt icon-med"></i> Đăng nhập</h4>
                </div>
                <div class="card-body">
                    <!-- Hiển thị lỗi nếu có -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="<%=contextPath%>/login" method="POST">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Mật khẩu</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
                    </form>
                    <p class="text-center mt-3">
                        Chưa có tài khoản? 
                        <a href="<%=contextPath%>/register">Tạo tài khoản</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
