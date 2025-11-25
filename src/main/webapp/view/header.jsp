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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        header {
		    width: 100%;
		    padding: 20px 0;
		    background: #f8f8f8;
		    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
		}
		
		.direction {
		    margin-top: 50px;
		    font-size: 14px;
		}
		
		.navbar-top {
		    width: 100%;
		    background: #fff;
		    padding: 15px 0;
		    border-bottom: 1px solid #ddd;
		}
		
		.nav-container {
		    width: 90%;
		    margin: auto;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		}
		
		.nav-left {
		    margin-left: 80px;
		    display: flex;
		    align-items: center;
		    gap: 40px;
		}
		
		.nav-menu {
		    margin-left: 170px;
		    display: flex;
		    align-items: center;
		    gap: 50px;
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
		    width:225px;
		    padding: 8px 12px;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		}
		
		.icon {
		    font-size: 20px;
		    cursor: pointer;
		}
    </style>
</head>
<body>
<header class="navbar-top">
        <div class="nav-container">
            <div class="nav-left">
                <h2 class="logo">CNWFinal</h2>

                <nav class="nav-menu">
                    <a href="#" class="nav-item">Home</a>
                    <a href="#" class="nav-item">Contact</a>
                    <a href="#" class="nav-item">About</a>
                    <a href="#" class="nav-item">Signup</a>
                </nav>
            </div>

            <div class="nav-right">
                <input type="text" class="search-input" placeholder="Search here...">
                <% if (currentUser == null) { %>
                    <a href="<%=contextPath%>/login" class="me-3" style="text-decoration: none;"><i class="fas fa-user icon-med"></i> Đăng nhập</a>
                <% } else { %>
					<div class="d-flex align-items-center justify-content-end">
						<span class="icon">❤</span>
					    <a href="<%=contextPath%>/cart.jsp" class="d-inline-flex align-items-center me-3" style="text-decoration: none;">
					        <span class="icon">🛒</span>
					    </a>
					    <span class="icon">👤</span>
					
					    <% if (currentUser.isAdmin()) { %>
					        <a href="<%=contextPath%>/admin/dashboard.jsp" class="d-inline-flex align-items-center me-3" style="text-decoration: none;">
					            <i class="fas fa-chart-bar icon-med me-1"></i>
					            <span>Dashboard</span>
					        </a>
					        <a href="<%=contextPath%>/admin/orders.jsp" class="d-inline-flex align-items-center me-3" style="text-decoration: none;">
					            <i class="fas fa-box icon-med me-1"></i>
					            <span>Đơn hàng</span>
					        </a>
					    <% } %>
					    
					    <a href="<%=contextPath%>/profile?id=<%=currentUser.getId()%>" class="d-inline-flex align-items-center me-3" style="text-decoration: none;">
					        <i class="fas fa-user-circle icon-med fs-3 me-1"></i>
					    </a>
						
					    <a href="<%=contextPath%>/logout" class="d-inline-flex align-items-center me-3" style="text-decoration: none;">
					        <i class="fas fa-sign-out-alt icon-med me-1"></i>
					        <span>Đăng xuất</span>
					    </a>
					</div>
                <% } %>
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

