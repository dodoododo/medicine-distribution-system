<%@ page import="com.medsystem.model.bean.CartProduct" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    com.medsystem.model.bean.User user = (com.medsystem.model.bean.User) request.getAttribute("user");
	List<CartProduct> cartItems = (List<CartProduct>) request.getAttribute("cartItems");
	Double subtotal = (Double) request.getAttribute("cartSubtotal");
	Double total = (Double) request.getAttribute("cartTotal");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
    	body { font-family: Arial, sans-serif; margin:0; padding:0; background:#fff; } 
    	.direction { margin-left: 10%; margin-top: 50px; font-size: 14px; } 
    	.checkout-container { display: flex; width: 90%; margin: auto; max-width: 1350px; gap: 20px; flex-wrap: wrap; margin-bottom: 60px;} 
    	.billing, .order-summary { background: #f3f3f3; padding: 20px; border-radius: 8px; } 
    	.billing { flex: 2; min-width: 300px; margin-top: 50px; } .order-summary { flex: 1; min-width: 250px; margin-top: 50px; } 
    	.form-control, 
    	.btn { margin-bottom: 15px; } 
    	.btn-apply { margin-left: 10px; }
    </style>
</head>

<body>

<%@ include file="/view/header.jsp" %>

<div class="checkout-container">

    <!-- BILLING DETAILS -->
    <div class="billing">
        <h3>Thông Tin Giao Hàng</h3>

        <form action="<%=request.getContextPath()%>/placeOrder" method="post">

            <input type="text"
                   name="fullName"
                   class="form-control"
                   placeholder="Họ Tên"
                   value="<%= currentUser.getFullName() %>"
                   required>

            <input type="text"
                   name="streetAddress"
                   class="form-control"
                   placeholder="Địa Chỉ*"
                   value="<%= currentUser.getAddress() %>"
                   required>

            <input type="text"
                   name="phone"
                   class="form-control"
                   placeholder="Số Điện Thoại*"
                   value="<%= currentUser.getPhone() %>"
                   required>
    </div>

    <!-- ORDER SUMMARY -->
    <div class="order-summary">

        <h4>Đơn Hàng Của Bạn</h4>
        
        <!-- CART ITEMS SUMMARY -->
		<div style="width: 100%;">
		
		    <h5>Chi Tiết Sản Phẩm</h5>

			<table class="table table-secondary table-striped table-hover mb-3">
			    <thead>
			    <tr>
			        <th>Sản phẩm</th>
			        <th>SL</th>
			        <th>Giá</th>
			        <th>Thành tiền</th>
			    </tr>
			    </thead>
			    <tbody>
			    <%
			        if (cartItems != null) {
			            for (CartProduct cp : cartItems) {
			                double lineTotal = cp.getProduct().getPrice() * cp.getQuantity();
			    %>
			
			    <tr>
			        <td><%= cp.getProduct().getName() %></td>
			        <td><%= cp.getQuantity() %></td>
			        <td><%= String.format("%.0f", cp.getProduct().getPrice()) %> VND</td>
			        <td><%= String.format("%.0f", lineTotal) %> VND</td>
			    </tr>
			
			    <%
			            }
			        }
			    %>
			    </tbody>
			</table>
		</div>
        

        <div class="d-flex justify-content-between">
            <span>Tổng Tiền Hàng:</span>
            <span><%= String.format("%.0f", subtotal) %> VND</span>
        </div>

        <div class="d-flex justify-content-between">
            <span>Phí Ship:</span>
            <span>Free</span>
        </div>

        <div class="d-flex justify-content-between fw-bold mt-2">
            <span>Tổng:</span>
            <span><%= String.format("%.0f", total) %> VND</span>
        </div>

        <hr>

        <div class="mb-2">
            <div class="form-check">
                <input class="form-check-input" type="radio" name="paymentMethod" value="bank" id="bank">
                <label class="form-check-label" for="bank">Chuyển Khoản</label>
            </div>

            <div class="form-check mt-1">
                <input class="form-check-input" type="radio" name="paymentMethod" value="cod" id="cod" checked>
                <label class="form-check-label" for="cod">Tiền Mặt</label>
            </div>
        </div>
        <div id="bankImageContainer" style="display: flex; align-item: center ;justify-content: center; margin-top: 15px;">
		    <img src="https://techcombank.com/content/dam/techcombank/public-site/articles/blog/gui-ma-qr-ngan-hang-thumbnail-165c1139c7.jpeg"
		         alt="QR Chuyển khoản"
		         class="img-fluid rounded">
			<h4>Đây là QR Mẫu - Chuyển Khoản Vào Đây</h4>
		</div>
        

        <button type="submit" class="btn btn-danger w-100">Đặt Đơn Hàng</button>

        </form>
    </div>
</div>

<%@ include file="/view/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const bankRadio = document.getElementById("bank");
    const codRadio = document.getElementById("cod");
    const imgBox   = document.getElementById("bankImageContainer");

    function updateImage() {
        if (bankRadio.checked) {
            imgBox.style.display = "block";
        } else {
            imgBox.style.display = "none";
        }
    }

    bankRadio.addEventListener("change", updateImage);
    codRadio.addEventListener("change", updateImage);

    updateImage(); // chạy lúc load trang
});
</script>
</html>
