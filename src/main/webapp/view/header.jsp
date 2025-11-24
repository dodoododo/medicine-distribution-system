<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website Bán Thuốc Y - Đông Tây Y</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Roboto', sans-serif; background-color: #F8F9FA; }
        .btn-primary { background-color: #4CAF50; border-color: #4CAF50; }
        .btn-secondary { background-color: #3FA7F5; border-color: #3FA7F5; }
        a { color: #3FA7F5; }
        .header-bg { background-color: #FFFFFF; border-bottom: 1px solid #E0E0E0; }
        .icon-med { color: #4CAF50; }
    </style>
</head>
<body>
<header class="header-bg py-2">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-3">
                <a href="<%=contextPath%>/" class="fw-bold fs-4 text-decoration-none"><i class="fas fa-pills icon-med me-2"></i>Sức Khỏe Việt</a>
            </div>
            <div class="col-md-6">
                <form class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="Tìm kiếm sản phẩm..." aria-label="Search">
                    <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
                </form>
            </div>
            <div class="col-md-3 text-end">
                <% if (session.getAttribute("user") == null) { %>
                    <a href="<%=contextPath%>/login" class="me-3" style="text-decoration: none;"><i class="fas fa-user icon-med"></i> Đăng nhập</a>
                <% } else { %>
                    <a href="/profile.jsp" class="me-3"><i class="fas fa-user-circle icon-med fs-3"></i></a>
                    <a href="/cart.jsp" class="me-3"><i class="fas fa-shopping-cart icon-med"></i> Giỏ hàng</a>
                    <a href="/LogoutServlet"><i class="fas fa-sign-out-alt icon-med"></i> Đăng xuất</a>
                <% } %>
            </div>
        </div>
    </div>
</header>

<!-- Popup Modal for Login Suggestion -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Vui lòng đăng nhập</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Bạn cần đăng nhập để thêm sản phẩm vào giỏ hàng.</p>
            </div>
            <div class="modal-footer">
                <a href="<%=contextPath%>/login" class="btn btn-primary">Đăng nhập</a>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>