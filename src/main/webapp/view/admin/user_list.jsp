<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-5">
    <h3>Quản lý người dùng</h3>

    <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
        <a href="${pageContext.request.contextPath}/admin/users?action=new" class="btn btn-success mb-3">Thêm mới</a>
    </c:if>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Email</th>
                <th>Điện thoại</th>
                <th>Địa chỉ</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${userList}">
                <tr>
                    <td>${u.id}</td>
                    <td>${u.fullName}</td>
                    <td>${u.email}</td>
                    <td>${u.phone}</td>
                    <td>${u.address}</td>
                    <td>${u.role == 1 ? 'ADMIN' : 'CUSTOMER'}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${u.id}" class="btn btn-primary btn-sm">Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/users?action=delete&id=${u.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

