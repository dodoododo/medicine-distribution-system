<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/view/header.jsp" %>

<style>
/* ===== MODERN PHARMACY DESIGN ===== */
:root {
    --primary-color: #4ECDC4;
    --primary-dark: #3BAAA3;
    --secondary-color: #44B89D;
    --accent-color: #FFE66D;
    --text-dark: #2C3E50;
    --text-light: #6C757D;
    --bg-light: #F8FBFF;
    --bg-white: #FFFFFF;
    --border-color: #E8F4F8;
    --shadow-sm: 0 2px 8px rgba(78, 205, 196, 0.1);
    --shadow-md: 0 4px 16px rgba(78, 205, 196, 0.15);
    --shadow-lg: 0 8px 24px rgba(78, 205, 196, 0.2);
    --border-radius: 16px;
    --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

body {
    background: linear-gradient(135deg, #F8FBFF 0%, #EFF8FF 100%);
    font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif;
    color: var(--text-dark);
    line-height: 1.6;
}

.container {
    max-width: 1320px;
}

/* ===== BANNER CAROUSEL ===== */
.carousel {
    border-radius: var(--border-radius);
    overflow: hidden;
    box-shadow: var(--shadow-lg);
    margin-bottom: 3rem;
    background: var(--bg-white);
}

.carousel-inner {
    border-radius: var(--border-radius);
}

/* ===== FILTER SECTION ===== */
.filter-section {
    background: var(--bg-white);
    border-radius: var(--border-radius);
    padding: 2rem;
    box-shadow: var(--shadow-md);
    margin-bottom: 3rem;
    border: 2px solid var(--border-color);
    position: relative;
    overflow: hidden;
}

.filter-section::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
}

.filter-section .form-label {
    color: var(--text-dark);
    font-weight: 600;
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: 0.75rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.filter-section .form-label::before {
    content: '○';
    color: var(--primary-color);
    font-size: 1.2rem;
}

.filter-section .form-select {
    border: 2px solid var(--border-color);
    border-radius: 12px;
    padding: 0.875rem 1.25rem;
    font-size: 0.95rem;
    color: var(--text-dark);
    background-color: var(--bg-light);
    transition: var(--transition);
    cursor: pointer;
}

.filter-section .form-select:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 0 4px rgba(78, 205, 196, 0.1);
    background-color: var(--bg-white);
    outline: none;
}

.filter-section .form-select:hover {
    border-color: var(--primary-color);
    background-color: var(--bg-white);
}

.filter-btn {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: white;
    border: none;
    border-radius: 12px;
    padding: 0.875rem 2rem;
    font-weight: 600;
    font-size: 1rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    transition: var(--transition);
    box-shadow: var(--shadow-sm);
    cursor: pointer;
    position: relative;
    overflow: hidden;
}

.filter-btn::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
    transition: left 0.5s;
}

.filter-btn:hover::before {
    left: 100%;
}

.filter-btn:hover {
    transform: translateY(-2px);
    box-shadow: var(--shadow-md);
}

.filter-btn:active {
    transform: translateY(0);
}

/* ===== PRODUCT GRID ===== */
.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 2rem;
    margin-bottom: 3rem;
}

@media (max-width: 768px) {
    .product-grid {
        grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
        gap: 1.5rem;
    }
}

/* ===== PRODUCT CARD ===== */
.product-card {
    background: var(--bg-white);
    border-radius: var(--border-radius);
    overflow: hidden;
    box-shadow: var(--shadow-sm);
    transition: var(--transition);
    border: 2px solid var(--border-color);
    height: 100%;
    display: flex;
    flex-direction: column;
    position: relative;
}

.product-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
    transform: scaleX(0);
    transition: transform 0.3s ease;
}

.product-card:hover {
    transform: translateY(-8px);
    box-shadow: var(--shadow-lg);
    border-color: var(--primary-color);
}

.product-card:hover::before {
    transform: scaleX(1);
}

.product-image-wrapper {
    position: relative;
    overflow: hidden;
    background: linear-gradient(135deg, #F0F9FF 0%, #E0F2FE 100%);
    height: 280px;
}

.product-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: var(--transition);
}

.product-card:hover .product-image {
    transform: scale(1.08);
}

.product-badge {
    position: absolute;
    top: 12px;
    right: 12px;
    background: linear-gradient(135deg, var(--accent-color), #FFD93D);
    color: var(--text-dark);
    padding: 0.4rem 0.8rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 700;
    text-transform: uppercase;
    box-shadow: var(--shadow-sm);
    letter-spacing: 0.5px;
}

.product-body {
    padding: 1.5rem;
    flex-grow: 1;
    display: flex;
    flex-direction: column;
}

.product-category {
    display: inline-block;
    background: linear-gradient(135deg, rgba(78, 205, 196, 0.1), rgba(68, 184, 157, 0.1));
    color: var(--primary-color);
    padding: 0.35rem 0.9rem;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
    margin-bottom: 0.75rem;
    border: 1px solid rgba(78, 205, 196, 0.2);
}

.product-title {
    font-size: 1.1rem;
    font-weight: 700;
    color: var(--text-dark);
    margin-bottom: 0.75rem;
    line-height: 1.4;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.product-info {
    margin-top: auto;
}

.product-price {
    font-size: 1.5rem;
    font-weight: 800;
    color: var(--primary-color);
    margin-bottom: 1rem;
    display: flex;
    align-items: baseline;
    gap: 0.5rem;
}

.price-label {
    font-size: 0.85rem;
    font-weight: 600;
    color: var(--text-light);
}

.product-actions {
    display: flex;
    gap: 0.75rem;
}

.btn-add-cart {
    flex: 1;
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: white;
    border: none;
    border-radius: 12px;
    padding: 0.875rem 1.5rem;
    font-weight: 600;
    font-size: 0.95rem;
    transition: var(--transition);
    box-shadow: var(--shadow-sm);
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    position: relative;
    overflow: hidden;
}

.btn-add-cart::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 0;
    height: 0;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.3);
    transform: translate(-50%, -50%);
    transition: width 0.6s, height 0.6s;
}

.btn-add-cart:hover::before {
    width: 300px;
    height: 300px;
}

.btn-add-cart:hover {
    transform: translateY(-2px);
    box-shadow: var(--shadow-md);
}

.btn-add-cart:active {
    transform: translateY(0);
}

.btn-add-cart i {
    font-size: 1.1rem;
}

/* ===== SECTION HEADER ===== */
.section-header {
    text-align: center;
    margin-bottom: 3rem;
}

.section-title {
    font-size: 2.5rem;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 0.75rem;
    position: relative;
    display: inline-block;
}

.section-title::after {
    content: '';
    position: absolute;
    bottom: -10px;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 4px;
    background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
    border-radius: 2px;
}

.section-subtitle {
    font-size: 1.1rem;
    color: var(--text-light);
    margin-top: 1.5rem;
}

/* ===== RESPONSIVE ===== */
@media (max-width: 768px) {
    .filter-section {
        padding: 1.5rem;
    }

    .section-title {
        font-size: 2rem;
    }

    .product-image-wrapper {
        height: 220px;
    }

    .product-title {
        font-size: 1rem;
    }

    .product-price {
        font-size: 1.3rem;
    }

    .btn-add-cart {
        padding: 0.75rem 1rem;
        font-size: 0.9rem;
    }
}

/* ===== EMPTY STATE ===== */
.empty-state {
    text-align: center;
    padding: 4rem 2rem;
    background: var(--bg-white);
    border-radius: var(--border-radius);
    box-shadow: var(--shadow-md);
}

.empty-state i {
    font-size: 4rem;
    color: var(--primary-color);
    margin-bottom: 1.5rem;
}

.empty-state h3 {
    color: var(--text-dark);
    margin-bottom: 1rem;
}

.empty-state p {
    color: var(--text-light);
}

/* ===== LOADING ANIMATION ===== */
@keyframes shimmer {
    0% { background-position: -1000px 0; }
    100% { background-position: 1000px 0; }
}

.loading-card {
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 1000px 100%;
    animation: shimmer 2s infinite;
}
</style>

<main class="container mt-4" style="padding-bottom: 60px;">
    <!-- Banner -->
    <div id="carouselExample" class="carousel slide mb-4">
        <!-- Giữ nguyên nội dung banner hiện tại -->
    </div>

    <!-- Section Header -->
    <div class="section-header">
        <h1 class="section-title">Sản Phẩm Y Tế</h1>
        <p class="section-subtitle">Chất lượng cao - Giá cả phải chăng - Giao hàng nhanh chóng</p>
    </div>

    <!-- Lọc sản phẩm -->
    <form class="filter-section" method="get" action="<%=request.getContextPath()%>/">
        <div class="row g-3 align-items-end">
            <!-- Sort theo giá -->
            <div class="col-lg-5 col-md-6 col-sm-12">
                <label for="sortPrice" class="form-label">Sắp xếp giá</label>
                <select class="form-select" id="sortPrice" name="sortPrice">
                    <option value="">Mặc định</option>
                    <option value="asc" ${param.sortPrice=='asc'?'selected':''}>Giá: Thấp → Cao</option>
                    <option value="desc" ${param.sortPrice=='desc'?'selected':''}>Giá: Cao → Thấp</option>
                </select>
            </div>

            <!-- Lọc theo loại -->
            <div class="col-lg-5 col-md-6 col-sm-12">
                <label for="category" class="form-label">Loại sản phẩm</label>
                <select class="form-select" id="category" name="category">
                    <option value="">Tất cả danh mục</option>
                    <c:forEach var="c" items="${categories}">
                        <option value="${c.id}" ${param.category==c.id?'selected':''}>${c.name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Button Lọc -->
            <div class="col-lg-2 col-md-12 col-sm-12">
                <button type="submit" class="filter-btn w-100">
                    <i class="fas fa-filter"></i> Lọc
                </button>
            </div>
        </div>
    </form>

    <!-- Product Grid -->
    <div class="product-grid">
        <c:forEach var="p" items="${productList}">
            <div class="product-card">
                <div class="product-image-wrapper">
                    <img src="${p.imageUrl}" class="product-image" alt="${p.name}">
                    <span class="product-badge">
                        <i class="fas fa-check-circle"></i> Có sẵn
                    </span>
                </div>
                
                <div class="product-body">
                    <span class="product-category">
                        <i class="fas fa-tag"></i> ${categoryMap[p.categoryId]}
                    </span>
                    
                    <h5 class="product-title">${p.name}</h5>
                    
                    <div class="product-info">
                        <div class="product-price">
                            <span class="price-label">Giá:</span>
                            <fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0" /> VNĐ
                        </div>
                        
                        <form method="post" action="<%=request.getContextPath()%>/cart" class="add-cart-form">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="${p.id}">
                            <input type="hidden" name="quantity" value="1">
                            <button type="submit" class="btn-add-cart">
                                <i class="fas fa-cart-plus"></i>
                                <span>Thêm vào giỏ</span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Empty State -->
    <c:if test="${empty productList}">
        <div class="empty-state">
            <i class="fas fa-pills"></i>
            <h3>Không tìm thấy sản phẩm</h3>
            <p>Vui lòng thử lại với bộ lọc khác hoặc quay lại trang chủ</p>
        </div>
    </c:if>
</main>

<%@ include file="view/footer.jsp" %>

<script>
    document.querySelectorAll('.add-to-cart').forEach(btn => {
        btn.addEventListener('click', () => {
            <% if (session.getAttribute("user") == null) { %>
                new bootstrap.Modal(document.getElementById('loginModal')).show();
            <% } else { %>
                // AJAX call to AddToCartServlet
                alert('Thêm thành công!');
            <% } %>
        });
    });

    // Smooth scroll behavior
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });

    // Add loading animation on form submit
    document.querySelector('.filter-section form')?.addEventListener('submit', function(e) {
        const btn = this.querySelector('.filter-btn');
        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang tải...';
    });
</script>