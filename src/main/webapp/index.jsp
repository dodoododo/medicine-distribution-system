<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="view/header.jsp" %>

<main class="container mt-4">
    <!-- Banner -->
    <div id="carouselExample" class="carousel slide mb-4">
        <!-- Như mẫu, giữ nguyên -->
    </div>

    <!-- Lọc sản phẩm -->
    <section class="mb-4">
        <h2>Danh sách sản phẩm</h2>
        <div class="row mb-3">
            <div class="col-md-6">
                <select class="form-select" id="sortPrice">
                    <option value="">Lọc theo giá</option>
                    <option value="asc">Thấp → Cao</option>
                    <option value="desc">Cao → Thấp</option>
                </select>
            </div>
            <div class="col-md-6">
                <select class="form-select" id="filterCategory">
                    <option value="">Lọc theo loại</option>
                    <option value="thuoc-ho">Thuốc ho</option>
                    <option value="thuoc-cam">Thuốc cảm</option>
                    <option value="tpcn">Thực phẩm chức năng</option>
                    <option value="dong-y">Đông y</option>
                    <option value="tay-y">Tây y</option>
                </select>
            </div>
        </div>
    </section>

    <!-- Grid sản phẩm (giả sử loop từ DB) -->
    <div class="row">
        <!-- Ví dụ 1 sản phẩm -->
        <div class="col-md-3 mb-4">
            <div class="card">
                <img src="https://via.placeholder.com/300x300?text=Thuoc+Ho" class="card-img-top" alt="Thuốc Ho">
                <div class="card-body">
                    <h5 class="card-title">Thuốc Ho ABC</h5>
                    <p class="card-text">Giá: 150.000 VNĐ<br>Loại: Thuốc ho</p>
                    <button class="btn btn-primary add-to-cart" data-id="1"><i class="fas fa-cart-plus"></i> Thêm vào giỏ</button>
                </div>
            </div>
        </div>
        <!-- Thêm sản phẩm khác tương tự, loop JSP với JSTL -->
    </div>
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
    // JS for filter/sort: AJAX load products
</script>