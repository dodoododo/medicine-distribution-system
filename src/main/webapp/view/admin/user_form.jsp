<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-5">
    <h3><c:choose>
        <c:when test="${formAction == 'edit'}">Cập nhật người dùng</c:when>
        <c:otherwise>Thêm mới người dùng</c:otherwise>
    </c:choose></h3>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/users" method="post">
        <input type="hidden" name="formAction" value="${formAction}" />
        <c:if test="${formAction == 'edit'}">
            <input type="hidden" name="id" value="${user.id}" />
        </c:if>

        <div class="mb-3">
            <label>Họ tên</label>
            <input type="text" name="fullName" class="form-control" value="${user.fullName}" required>
        </div>

        <div class="mb-3">
            <label>Email</label>
            <input type="email" name="email" class="form-control" value="${user.email}" required>
        </div>

        <div class="mb-3">
            <label>Mật khẩu</label>
            <input type="password" name="password" class="form-control" value="${user.password}" required>
        </div>

        <div class="mb-3">
            <label>Điện thoại</label>
            <input type="text" name="phone" class="form-control" value="${user.phone}">
        </div>

        <div class="mb-3">
            <label>Địa chỉ</label>
            <input type="text" name="address" class="form-control" value="${user.address}">
        </div>

        <div class="mb-3">
            <label>Role</label>
            <select name="role" class="form-control">
                <option value="1" ${user.role == 1 ? 'selected' : ''}>ADMIN</option>
                <option value="0" ${user.role == 0 ? 'selected' : ''}>CUSTOMER</option>
            </select>
        </div>

        <button type="submit" class="btn btn-success">
            <c:choose>
                <c:when test="${formAction == 'edit'}">Cập nhật</c:when>
                <c:otherwise>Thêm mới</c:otherwise>
            </c:choose>
        </button>
        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Hủy</a>
    </form>
</div>
