<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-4">
    <h3>Quản lý danh mục</h3>

    <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
        <a href="${pageContext.request.contextPath}/admin/categories?action=add" class="btn btn-success mb-3">Thêm mới</a>
    </c:if>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên danh mục</th>
                <th>Mô tả</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="c" items="${categoryList}">
                <tr>
                    <td>${c.id}</td>
                    <td>${c.name}</td>
                    <td>${c.description}</td>
                    <td>
                        <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
                            <a href="${pageContext.request.contextPath}/admin/categories?action=edit&id=${c.id}" class="btn btn-primary btn-sm">Sửa</a>
                            <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${c.id}" class="btn btn-danger btn-sm" onclick="return confirm('Xác nhận xóa?');">Xóa</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

