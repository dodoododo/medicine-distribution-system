<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/view/header.jsp" %>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-2 bg-light vh-100 p-3">
            <h5>Admin Panel</h5>
            <ul class="nav flex-column">
                <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
                    <li class="nav-item mb-2">
                        <a class="nav-link btn btn-outline-primary w-100" 
                           href="${pageContext.request.contextPath}/admin/categories">Category</a>
                    </li>
                    <li class="nav-item mb-2">
                        <a class="nav-link btn btn-outline-success w-100" 
                           href="${pageContext.request.contextPath}/admin/products">Product</a>
                    </li>
                    <li class="nav-item mb-2">
                        <a class="nav-link btn btn-outline-warning w-100" 
                           href="${pageContext.request.contextPath}/admin/users">User</a>
                    </li>
                </c:if>
            </ul>
        </div>

        <!-- Main content -->
        <div class="col-10 p-3">
            <c:choose>
                <c:when test="${not empty mainPage}">
                    <jsp:include page="${mainPage}" />
                </c:when>
                <c:otherwise>
                    <h5>Chưa chọn nội dung hiển thị</h5>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<%@ include file="/view/footer.jsp" %>
