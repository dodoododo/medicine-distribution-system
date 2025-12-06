<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="container mt-4">
    <h3>Quản lý sản phẩm</h3>

    <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
        <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn-success mb-3">Thêm mới</a>
    </c:if>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên sản phẩm</th>
                <th>Danh mục</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Nhà sản xuất</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="p" items="${productList}">
                <tr>
                    <td>${p.id}</td>
                    <td>${p.name}</td>
                    <!-- An toàn khi category null -->
                    <td>
                        <c:choose>
                            <c:when test="${p.category != null}">
                                ${p.category.name}
                            </c:when>
                            <c:otherwise>
                                Chưa có danh mục
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0" /></td>
                    <td>${p.stockQuantity}</td>
                    <td>${p.manufacturer}</td>
                    <td>
                        <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
                            <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.id}" class="btn btn-primary btn-sm">Sửa</a>
                            <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${p.id}" class="btn btn-danger btn-sm" onclick="return confirm('Xác nhận xóa?');">Xóa</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
