<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
    com.medsystem.model.bean.User currentUser = null;
    HttpSession sessionObj = request.getSession(false); // false → không tạo session mới
    if (sessionObj != null) {
        currentUser = (com.medsystem.model.bean.User) sessionObj.getAttribute("user");
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website Bán Thuốc Y - Đông Tây Y</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="icon" type="image/png" href="https://thumbs.dreamstime.com/b/medical-cross-helping-hands-charity-logo-compassionate-design-featuring-embraced-symbolizing-care-support-charitable-aid-380842391.jpg">
    <style>
        body { font-family: 'Roboto', sans-serif; background-color: #F8F9FA; }
        .btn-primary { background-color: #4CAF50; border-color: #4CAF50; }
        .btn-secondary { background-color: #3FA7F5; border-color: #3FA7F5; }
        .a { color: #3FA7F5; text-decoration: none; }
        .header-bg { background-color: #FFFFFF; border-bottom: 1px solid #E0E0E0; }
        .icon-med { color: #4CAF50; }
    </style>
</head>
<body>
<header class="header-bg py-2">
    <div class="container">
<div class="row align-items-center flex-nowrap">
    <!-- Logo -->
    <div class="col-md-3">
        <a href="<%=contextPath%>/" class="fw-bold fs-4 text-decoration-none">
            <i class="fas fa-pills icon-med me-2"></i>Sức Khỏe Việt
        </a>
    </div>

    <!-- Search bar -->
    <div class="col-md-6">
        <form class="d-flex w-100">
            <input class="form-control me-2" type="search" placeholder="Tìm kiếm sản phẩm...">
            <button class="btn btn-primary" type="submit">
                <i class="fas fa-search"></i>
            </button>
        </form>
    </div>

    <!-- Icons bên phải -->
    <div class="col-md-4">
        <% if (currentUser == null) { %>
            <div class="d-flex justify-content-end gap-3">
                <a href="<%=contextPath%>/login" class="d-inline-flex align-items-center gap-1" style="text-decoration: none">
                    <i class="fas fa-user icon-med"></i> Đăng nhập
                </a>
            </div>
        <% } else { %>

        <div class="d-flex justify-content-end gap-3">

            <a href="<%=contextPath%>/cart.jsp" class="d-inline-flex align-items-center" style="text-decoration: none">
                <i class="fas fa-shopping-cart icon-med fs-5"></i>
            </a>

            <% if (currentUser.isAdmin()) { %>
                <a href="<%=contextPath%>/admin/dashboard.jsp" class="d-inline-flex align-items-center gap-1" style="text-decoration: none">
                    <i class="fas fa-chart-bar icon-med fs-5"></i>
                    <span>Dashboard</span>
                </a>

                <a href="<%=contextPath%>/admin/orders.jsp" class="d-inline-flex align-items-center gap-1" style="text-decoration: none">
                    <i class="fas fa-box icon-med fs-5"></i> Đơn hàng
                </a>
            <% } %>

            <a href="<%=contextPath%>/profile?id=<%=currentUser.getId()%>"
               class="d-inline-flex align-items-center" style="text-decoration: none">
                <i class="fas fa-user-circle icon-med fs-3"></i>
            </a>

            <a href="<%=contextPath%>/logout" class="d-inline-flex align-items-center gap-1" style="text-decoration: none">
                <i class="fas fa-sign-out-alt icon-med fs-5"></i>
                <span>Đăng xuất</span>
            </a>
        </div>

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
