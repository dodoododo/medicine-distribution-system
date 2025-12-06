<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lỗi Đặt Hàng</title>

    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body {
            background: #f1f8f5; /* xanh nhạt kiểu bệnh viện */
            font-family: "Inter", Arial, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .error-box {
            background: #ffffff;
            max-width: 600px;
            width: 100%;
            border-radius: 16px;
            padding: 40px 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            text-align: center;

            /* hiệu ứng xuất hiện */
            opacity: 0;
            transform: translateY(30px);
            animation: fadeUp 0.6s ease forwards;
        }

        @keyframes fadeUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .error-icon {
            font-size: 120px;
            color: #dc3545; /* đỏ nhạt */
        }

        .error-title {
            color: #dc3545;
            font-size: 28px;
            font-weight: 700;
            margin-top: 15px;
        }

        .error-text {
            color: #6c757d;
            font-size: 16px;
            margin-top: 15px;
            line-height: 1.6;
        }

        .btn-green {
            background-color: #28a745;
            border-color: #28a745;
            color: white;
            font-weight: 600;
        }

        .btn-green:hover {
            background-color: #218838;
        }

        .footer-note {
            margin-top: 25px;
            font-size: 14px;
            color: #6c757d;
            line-height: 1.5;
        }
    </style>
</head>

<body>

<div class="error-box">

    <!-- ICON BUỒN TINH TẾ (bootstrap icon) -->
    <div class="error-icon">
        <i class="bi bi-emoji-frown"></i>
    </div>

    <h2 class="error-title">Rất tiếc, đã có lỗi xảy ra</h2>

    <p class="error-text">
        Chúng tôi rất xin lỗi vì sự bất tiện này.<br>
        Đơn hàng của Quý khách hiện chưa thể xử lý.
    </p>

    <p class="error-text">
        Nguyên nhân có thể do:<br>
        • Giỏ hàng trống<br>
        • Lỗi kết nối hệ thống<br>
    </p>

    <div class="d-flex gap-3 justify-content-center mt-4">

        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary px-4 py-2">
            Về trang chủ
        </a>
    </div>

    <div class="footer-note">
        Trân trọng,<br>
        <strong>Nhà thuốc Sức Khỏe Việt</strong><br>
        Chăm sóc sức khỏe Việt
    </div>
</div>

<!-- Bootstrap Icons CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

</body>
</html>
