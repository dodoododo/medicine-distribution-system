<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/view/header.jsp" %>

<style>
    /* Style làm đẹp cho Sidebar dựa trên nền Bootstrap */
    .admin-wrapper {
    	flex: 1;
        background-color: #F5F7FA;
        min-height: 100%; 
    }

    .sidebar-custom {
        background: rgb(249, 252, 255);
        border-right: 1px solid #E0E0E0;
        min-height: 100%; /* Sidebar luôn dài ít nhất bằng màn hình */
        padding: 24px;
    }

    .sidebar-title {
        color: #2E7D32;
        font-weight: 700;
        margin-bottom: 24px;
        display: flex; align-items: center; gap: 10px;
    }

    /* Style cho từng mục menu */
    .nav-custom .nav-link {
        color: #374151;
        font-weight: 500;
        padding: 12px 16px;
        border-radius: 8px;
        margin-bottom: 8px;
        display: flex; align-items: center; gap: 10px;
        transition: all 0.2s;
    }

    .nav-custom .nav-link:hover {
        background-color: #E0F2F1;
        color: #0F766E;
        transform: translateX(5px);
    }

    .nav-custom .nav-link i {
        width: 18px; /* Cố định chiều rộng icon để chữ thẳng hàng */
    }
    
    .content-area {
        padding: 30px;
    }
    
    .content-card {
        background: white;
        border-radius: 16px;
        padding: 30px;
        box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
    }
</style>

<script src="https://unpkg.com/feather-icons"></script>

<div class="container-fluid admin-wrapper">
    <div class="row">
        
        <div class="col-md-3 col-lg-2 p-0">
            <div class="sidebar-custom">
                <h5 class="sidebar-title"><i data-feather="shield"></i> Admin Panel</h5>
                
                <ul class="nav flex-column nav-custom">
                    <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">
                                <i data-feather="layers"></i> Danh mục
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/products">
                                <i data-feather="package"></i> Sản phẩm
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                <i data-feather="users"></i> Người dùng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                                <i data-feather="truck"></i> Đơn Hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i data-feather="bar-chart-2"></i> Báo cáo
                            </a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>

        <div class="col-md-9 col-lg-10 content-area">
            
            <div class="content-card">
                <c:choose>
                    <c:when test="${not empty mainPage}">
                        <jsp:include page="${mainPage}" />
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5 text-muted">
                            <i data-feather="monitor" style="width: 48px; height: 48px;" class="mb-3"></i>
                            <h5>Chào mừng đến trang quản trị</h5>
                            <p>Chọn chức năng từ menu bên trái để bắt đầu</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<%@ include file="/view/footer.jsp" %>
<script>
    feather.replace();
</script>