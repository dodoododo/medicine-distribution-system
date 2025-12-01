<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="/view/header.jsp" %>

<main class="container mt-4">
    <!-- Banner -->
    <div id="carouselExample" class="carousel slide mb-4">
        <!-- Như mẫu, giữ nguyên -->
    </div>

	<!-- Lọc sản phẩm -->
	<form class="row g-2 align-items-end mb-4" method="get" action="<%=request.getContextPath()%>/">
	    <!-- Sort theo giá -->
	    <div class="col-md-5 col-sm-6">
	        <label for="sortPrice" class="form-label fw-semibold">Sắp xếp giá</label>
	        <select class="form-select" id="sortPrice" name="sortPrice">
	            <option value="">Mặc định</option>
	            <option value="asc" ${param.sortPrice=='asc'?'selected':''}>Thấp → Cao</option>
	            <option value="desc" ${param.sortPrice=='desc'?'selected':''}>Cao → Thấp</option>
	        </select>
	    </div>
	
	    <!-- Lọc theo loại -->
	    <div class="col-md-5 col-sm-6">
	        <label for="category" class="form-label fw-semibold">Loại sản phẩm</label>
	        <select class="form-select" id="category" name="category">
	            <option value="">Tất cả</option>
	            <c:forEach var="c" items="${categories}">
	                <option value="${c.id}" ${param.category==c.id?'selected':''}>${c.name}</option>
	            </c:forEach>
	        </select>
	    </div>
	
	    <!-- Button Lọc -->
	    <div class="col-md-2 col-sm-12 d-grid">
	        <button type="submit" class="btn btn-success w-100">Lọc</button>
	    </div>
	</form>


    <!-- Grid sản phẩm (giả sử loop từ DB) -->
	<div class="row">
	    <c:forEach var="p" items="${productList}">
	        <div class="col-md-3 mb-4">
	            <div class="card h-100">
	
	                <img src="${p.imageUrl}" class="card-img-top"
	                     alt="${p.name}" style="height: 250px; object-fit: cover;">
	
	                <div class="card-body">
	                    <h5 class="card-title">${p.name}</h5>
	                    <p class="card-text">
	                        Giá: ${p.price} VNĐ <br>
	                        Loại: ${categoryMap[p.categoryId]}
	                    </p>
	                   
	                    <button class="btn btn-primary add-to-cart "
	                    
						        data-id="${p.id}"
						        data-name="${p.name}"
						        data-price="${p.price}"
						        data-img="${p.imageUrl}">
						    <i class="fas fa-cart-plus"></i> Thêm vào giỏ
						</button>
	                </div>
	            </div>
	        </div>
	    </c:forEach>
	</div>

</main>

<%@ include file="view/footer.jsp" %>

<script>
	document.querySelectorAll('.add-to-cart').forEach(btn => {
	    btn.addEventListener('click', function() {
	        <% if (session.getAttribute("user") == null) { %>
	            new bootstrap.Modal(document.getElementById('loginModal')).show();
	        <% } else { %>
		        const productId = this.dataset.id;
	            const form = document.createElement('form');
	            form.method = 'POST';
	            form.action = '<%=request.getContextPath()%>/cart/add';
	
	            const input = document.createElement('input');
	            input.type = 'hidden';
	            input.name = 'productId';
	            input.value = productId;
	
	            form.appendChild(input);
	            document.body.appendChild(form);
	            form.submit();
	        <% } %>
	    });
	});

    // JS for filter/sort: AJAX load products
</script>