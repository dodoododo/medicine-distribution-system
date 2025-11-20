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
    <h2><i class="fas fa-credit-card icon-med"></i> Thanh toán</h2>
    <div class="row">
        <div class="col-md-8">
            <form action="/CheckoutServlet" method="POST">
                <div class="mb-3">
                    <label for="receiverName" class="form-label">Tên người nhận</label>
                    <input type="text" class="form-control" id="receiverName" name="receiverName" required>
                </div>
                <div class="mb-3">
                    <label for="receiverPhone" class="form-label">Số điện thoại</label>
                    <input type="tel" class="form-control" id="receiverPhone" name="receiverPhone" required>
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Địa chỉ</label>
                    <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Phương thức thanh toán</label>
                    <div>
                        <input type="radio" id="bank" name="payment" value="bank" required>
                        <label for="bank">Thanh toán ngân hàng</label>
                    </div>
                    <div>
                        <input type="radio" id="cod" name="payment" value="cod">
                        <label for="cod">Tiền mặt khi nhận hàng</label>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary w-100">Đặt hàng</button>
            </form>
        </div>
        <div class="col-md-4">
            <!-- Tóm tắt giỏ hàng -->
            <div class="card">
                <div class="card-body">
                    <h5>Tóm tắt đơn hàng</h5>
                    <p>Tổng tiền: 150.000 VNĐ</p>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>