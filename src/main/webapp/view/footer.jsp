<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    /* --- 1. Cấu hình Flexbox cho Body --- */
    html, body {
        margin: 0;
    }

    body {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    /* --- 2. CSS cho Footer --- */
    footer {
        background: #1B3A24;
        color: #fff;
        padding: 60px 0 20px;
        margin-top: auto; 
        
        width: 100%;
        position: relative; 
    }
    
    /* Grid layout bên trong giữ nguyên */
    footer .grid-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 30px;
        width: 90%;
        max-width: 1200px;
        margin: auto;
    }
    
    footer h3 { font-size: 20px; margin-bottom: 20px; font-weight: 700; }
    footer p { color: #dbdbdb; font-size: 14px; line-height: 1.6; }
    footer input { padding: 10px; border: 2px solid #333; border-radius: 4px; background: transparent; color: white; width: 100%; margin-top: 10px; }
    /* --- CSS MỚI CHO LINK VÀ TEXT --- */
    footer p, footer span { color: #dbdbdb; font-size: 14px; line-height: 1.6; margin-bottom: 10px; }
    
    /* Style cho các đường link chức năng */
    footer a.footer-link {
        display: block; /* Xuống dòng */
        color: #dbdbdb;
        text-decoration: none;
        margin-bottom: 12px;
        font-size: 14px;
        transition: color 0.2s, padding-left 0.2s;
    }

    footer a.footer-link:hover {
        color: #fff;
        padding-left: 5px; /* Hiệu ứng đẩy nhẹ sang phải khi di chuột */
    }

    .sub-input {
        position: relative;
        width: 100%;
    }
    footer input { 
        padding: 12px 40px 12px 12px; 
        border: 1px solid #fff; 
        border-radius: 4px; 
        background: transparent; 
        color: white; 
        width: 100%; 
        outline: none;
    }
    .send-icon {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
    }

    /* Style cho Social Icons (Github, FB...) */
    .social-icons {
        display: flex;
        gap: 15px;
        margin-top: 20px;
    }
    .social-icons a {
        color: #fff;
        font-size: 24px;
        transition: transform 0.2s;
    }
    .social-icons a:hover {
        transform: scale(1.2); /* Phóng to icon khi di chuột */
        color: #4CAF50; /* Màu xanh lá tạo điểm nhấn */
    }
</style>

<footer>
    <div class="grid-container">

        <div>
            <h3>Hỗ trợ</h3>
            <p><i class="fas fa-map-marker-alt me-2"></i>Đại Học Bách Khoa Đà Nẵng, 54 Nguyễn Lương Bằng</p>
            <p><i class="fas fa-envelope me-2"></i>tn.hau1115@gmail.com</p>
            <p><i class="fas fa-phone-alt me-2"></i>09050say0ve</p>
        </div>

        <div>
            <h3>Chức Năng</h3>
            <a href="${pageContext.request.contextPath}/" class="footer-link">Trang Chủ</a>
        </div>

        <div>
            <h3>Kết nối</h3>
            <p>Theo dõi chúng tôi trên mạng xã hội:</p>
            
            <div class="social-icons">
                <a href="https://github.com/dodoododo/medicine-distribution-system" target="_blank" title="Github">
                    <i class="fab fa-github"></i>
                </a>
                
                <a href="https://facebook.com" target="_blank" title="Facebook">
                    <i class="fab fa-facebook-f"></i>
                </a>

                <a href="https://linkedin.com" target="_blank" title="LinkedIn">
                    <i class="fab fa-linkedin-in"></i>
                </a>
                
                <a href="https://youtube.com" target="_blank" title="Youtube">
                    <i class="fab fa-youtube"></i>
                </a>
            </div>
        </div>
    </div>
    
    <div style="text-align: center; border-top: 1px solid #555; margin-top: 40px; padding-top: 20px; font-size: 14px; color: #666;">
        &copy; Copyright BKDN 2025. All right reserved | Developed by <a href="https://vnn-imgs-f.vgcloud.vn/2018/11/16/10/noi-com-dien-gia-re-1.jpg?width=0&s=l6CZQKS4Pyto38daweDHJg" target="_blank" style="color: #888; text-decoration: none;">Hội anh em đam mê nồi cơm điện Việt Nam</a>
    </div>
</footer>