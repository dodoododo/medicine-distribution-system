<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container mt-4">
    <h3>${category != null ? "Cập nhật danh mục" : "Thêm danh mục mới"}</h3>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/categories" method="post">
        <c:if test="${category != null}">
            <input type="hidden" name="id" value="${category.id}">
        </c:if>

        <div class="mb-3">
            <label for="name" class="form-label">Tên danh mục</label>
            <input type="text" class="form-control" name="name" id="name" value="${category != null ? category.name : ''}" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Mô tả</label>
            <textarea class="form-control" name="description" id="description">${category != null ? fn:escapeXml(category.description) : ''}</textarea>
        </div>

        <button type="submit" class="btn btn-success">${category != null ? "Cập nhật" : "Thêm mới"}</button>
        <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">Hủy</a>
    </form>
</div>

