<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container mt-4">
    <h3>${product != null ? "Cập nhật sản phẩm" : "Thêm sản phẩm mới"}</h3>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/products" method="post">
        <c:if test="${product != null}">
            <input type="hidden" name="id" value="${product.id}">
        </c:if>

        <!-- Danh mục -->
        <div class="mb-3">
            <label for="categoryId" class="form-label">Danh mục</label>
            <select class="form-control" name="categoryId" required>
                <c:forEach var="c" items="${categories}">
                    <option value="${c.id}" 
                        <c:if test="${product != null && product.categoryId == c.id}">selected</c:if>>
                        ${c.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <!-- Tên sản phẩm -->
        <div class="mb-3">
            <label for="name" class="form-label">Tên sản phẩm</label>
            <input type="text" class="form-control" name="name" value="${product != null ? product.name : ''}" required>
        </div>

        <!-- Mô tả -->
        <div class="mb-3">
            <label for="description" class="form-label">Mô tả</label>
            <textarea class="form-control" name="description">${product != null ? fn:escapeXml(product.description) : ''}</textarea>
        </div>

        <!-- Giá -->
        <div class="mb-3">
            <label for="price" class="form-label">Giá</label>
            <input type="number" step="1000" class="form-control" name="price" value="${product != null ? product.price : 0}" required>
        </div>

        <!-- Số lượng -->
        <div class="mb-3">
            <label for="stockQuantity" class="form-label">Số lượng</label>
            <input type="number" class="form-control" name="stockQuantity" value="${product != null ? product.stockQuantity : 0}" required>
        </div>
        
        <!-- Ảnh -->
        <div class="mb-3">
            <label for="imageUrl" class="form-label">Ảnh</label>
            <input type="text" class="form-control" name="imageUrl" value="${product != null ? product.imageUrl : 0}">
        </div>

        <!-- Nhà sản xuất -->
        <div class="mb-3">
            <label for="manufacturer" class="form-label">Nhà sản xuất</label>
            <input type="text" class="form-control" name="manufacturer" value="${product != null ? product.manufacturer : ''}">
        </div>

        <!-- Hạn sử dụng -->
        <div class="mb-3">
            <label for="expiryDate" class="form-label">Hạn sử dụng</label>
            <input type="date" class="form-control" name="expiryDate" value="${product != null ? product.expiryDate : ''}">
        </div>

        <!-- Kích hoạt -->
        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" name="isActive" 
                <c:if test="${product != null && product.active}">checked</c:if>>
            <label class="form-check-label" for="isActive">Kích hoạt</label>
        </div>

        <button type="submit" class="btn btn-success">${product != null ? "Cập nhật" : "Thêm mới"}</button>
        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Hủy</a>
    </form>
</div>

