<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - Thuốc Y Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Roboto', sans-serif; background-color: #F8F9FA; }
        .btn-primary { background-color: #4CAF50; border-color: #4CAF50; }
        .icon-med { color: #4CAF50; }
    </style>
</head>

<main class="container mt-5">
    <h2><i class="fas fa-shopping-cart icon-med"></i> Giỏ hàng</h2>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Hình ảnh</th>
                <th>Tên sản phẩm</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Tổng</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <!-- Loop từ session cart -->
            <tr>
                <td><img src="https://via.placeholder.com/50" alt="Product"></td>
                <td>Thuốc Ho ABC</td>
                <td>150.000 VNĐ</td>
                <td><input type="number" value="1" min="1" class="form-control w-50 update-qty"></td>
                <td>150.000 VNĐ</td>
                <td><button class="btn btn-danger btn-sm"><i class="fas fa-trash"></i> Xóa</button></td>
            </tr>
            <!-- Thêm row khác -->
        </tbody>
    </table>
    <div class="text-end">
        <h4>Tổng tiền: 150.000 VNĐ</h4>
        <a href="/checkout.jsp" class="btn btn-primary">Checkout</a>
    </div>
</main>

<%@ include file="footer.jsp" %>

<script>
    // JS for update qty/delete: AJAX to CartServlet
</script>