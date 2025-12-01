<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String contextPath = request.getContextPath();
    com.medsystem.model.bean.User currentUser = (com.medsystem.model.bean.User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website Bán Thuốc Y - Đông Tây Y</title>

    <!-- Bootstrap + FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        header {
            width: 100%;
            padding: 20px 0;
            background: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    		border-bottom: 2px solid #e0e0e0;
        }

        .nav-container {
            width: 90%;
            margin: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-left {
            display: flex;
            align-items: center;
            gap: 40px;
        }

        .logo {
            margin-left: 80px;
        }

        .nav-menu {
            margin-left: 120px;
            display: flex;
            align-items: center;
            gap: 40px;
        }

        .nav-item {
            text-decoration: none;
            color: #000;
            font-size: 16px;
        }

        .nav-right {
            margin-right: 80px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .search-input {
            width: 225px;
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .icon {
            font-size: 20px;
            cursor: pointer;
        }

        .icon-med { color: #4CAF50; }
    </style>
</head>

<body>
<header class="navbar-top">
    <div class="nav-container">

        <!-- LEFT: LOGO + MENU -->
        <div class="nav-left">
            <h2 class="logo">

                <% if (currentUser != null && currentUser.isAdmin()) { %>
                    <a href="<%=contextPath%>/admin" style="text-decoration:none; color:#000;">
                        <i class="fas fa-pills icon-med me-2"></i>Sức Khỏe Việt
                    </a>
                <% } else { %>
                    <a href="<%=contextPath%>/" style="text-decoration:none; color:#000;">
                        <i class="fas fa-pills icon-med me-2"></i>Sức Khỏe Việt
                    </a>
                <% } %>

            </h2>
        </div>

        <!-- RIGHT: SEARCH + USER AREA -->
        <div class="nav-right">

            <!-- SEARCH -->
            <form action="<%=contextPath%>/" method="get">
                <input type="text" class="search-input" placeholder="Tìm kiếm sản phẩm" name="search">
            </form>

            <% if (currentUser == null) { %>

                <!-- Chưa đăng nhập -->
                <a href="<%=contextPath%>/login" class="d-inline-flex align-items-center gap-1" style="text-decoration: none">
                    <i class="fas fa-user icon-med"></i> Đăng nhập
                </a>

            <% } else { %>

                <!-- Đã đăng nhập -->
                <a href="<%=contextPath%>/cart" class="icon" title="Giỏ hàng">
                    <i class="fas fa-shopping-cart icon-med"></i>
                </a>

                <a href="<%=contextPath%>/profile?id=<%=currentUser.getId()%>" class="icon" title="Tài khoản">
                    <i class="fas fa-user-circle icon-med"></i>
                </a>

                <a href="<%=contextPath%>/logout" class="icon d-flex align-items-center" 
                   title="Đăng xuất" style="text-decoration:none;">
                    <i class="fas fa-sign-out-alt icon-med me-1"></i>
                </a>

            <% } %>

        </div>
    </div>
</header>

<!-- POPUP LOGIN -->
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

</body>
</html>
