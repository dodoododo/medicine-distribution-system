<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            background: #f1f8f5; /* Xanh nhạt kiểu bệnh viện cao cấp */
            font-family: 'Inter', sans-serif;
            padding: 20px;
        }

        .success-wrapper {
            max-width: 600px;
            margin: 50px auto;
            background: #ffffff;
            padding: 40px 35px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            animation: fadeUp 0.6s ease-out;
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .success-icon {
            width: 120px;
            height: 120px;
            margin-bottom: 20px;
            animation: pop 0.5s ease-out;
        }

        @keyframes pop {
            0% { transform: scale(0.5); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }

        h2 {
            color: #28a745;
            font-weight: 700;
            margin-bottom: 15px;
        }

        .order-code {
            font-weight: 600;
            color: #1b7a36;
            background: #e8f5e8;
            padding: 8px 14px;
            display: inline-block;
            border-radius: 8px;
            margin: 10px 0 20px 0;
        }

        .btn-main {
            background: #28a745;
            border: none;
        }

        .btn-main:hover {
            background: #218838;
        }

        .btn-outline {
            border-color: #28a745;
            color: #28a745;
        }

        .btn-outline:hover {
            background: #e8f5e8;
        }

        .footer-note {
            margin-top: 30px;
            font-size: 14px;
            color: #6c757d;
            line-height: 1.5;
        }

    </style>
</head>

<body>

<div class="success-wrapper text-center">

    <!-- Icon tick xanh -->
    <img class="success-icon" src="https://cdn-icons-png.flaticon.com/512/190/190411.png" alt="Success">

    <h2>Đặt hàng thành công ✓</h2>

    <p class="text-muted mb-2">Chúng tôi đã nhận được đơn hàng của Quý khách.</p>
    <p class="text-muted mb-2">Đơn hàng đang được dược sĩ kiểm tra và đóng gói cẩn thận.</p>
    <p class="text-muted mb-2">Nhà thuốc sẽ giao hàng trong thời gian sớm nhất.</p>
    <p class="text-muted mb-3">Sức khỏe của Quý khách là điều chúng tôi luôn đặt lên hàng đầu.</p>

    <!-- Buttons -->
    <div class="d-flex gap-3 justify-content-center mt-4">
        <a href="${pageContext.request.contextPath}/order?action=tracking"
           class="btn btn-main px-4 py-2">Theo dõi đơn hàng</a>

        <a href="${pageContext.request.contextPath}/"
           class="btn btn-outline px-4 py-2">Về trang chủ</a>
    </div>

    <div class="footer-note mt-4">
        Trân trọng,<br>
        <strong>Nhà thuốc MedSystem</strong><br>
        Chăm sóc sức khỏe Việt
    </div>
</div>

</body>
</html>
