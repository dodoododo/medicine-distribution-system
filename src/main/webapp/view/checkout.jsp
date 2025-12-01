<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Lấy subtotal từ session (giả sử đã lưu trong session khi view cart)
    Double subtotal = (Double) session.getAttribute("cartSubtotal");
    if (subtotal == null) subtotal = 0.0;

    // Lấy total từ session hoặc view cart (có thể bao gồm phí ship, coupon,...)
    Double total = (Double) session.getAttribute("cartTotal");
    if (total == null) total = subtotal; // nếu chưa có total thì dùng subtotal
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
        .checkout-container { display: flex; width: 90%; margin: auto; max-width: 1200px; gap: 20px; flex-wrap: wrap; }
        .billing, .order-summary { background: #f9f9f9; padding: 20px; border-radius: 8px; }
        .billing { flex: 2; min-width: 300px; margin-top: 50px; }
        .order-summary { flex: 1; min-width: 250px; margin-top: 50px; }
        .form-control, .btn { margin-bottom: 15px; }
        .btn-apply { margin-left: 10px; }
    </style>
</head>
<body>

<%@ include file="/view/header.jsp" %>

<div class="direction">
    <a href="<%=request.getContextPath()%>/home">Home</a> /
    <a href="<%=request.getContextPath()%>/view/cart.jsp">Cart</a> /
    <a href="<%=request.getContextPath()%>/checkout">Check Out</a>
</div>

<div class="checkout-container">
    <!-- Billing Details -->
    <div class="billing">
        <h4>Billing Details</h4>
        <form action="<%=request.getContextPath()%>/placeOrder" method="post">
            <input type="text" name="fullName" class="form-control" placeholder="Full Name*" required>
            <input type="text" name="streetAddress" class="form-control" placeholder="Street Address*" required>
            <input type="text" name="phone" class="form-control" placeholder="Phone Number*" required>
            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" id="saveInfo" name="saveInfo">
                <label class="form-check-label" for="saveInfo">Save this information for faster check-out next time</label>
            </div>
    </div>

    <!-- Order Summary -->
    <div class="order-summary">
        <h4>Your Order</h4>

        <div class="d-flex justify-content-between">
            <span>Subtotal:</span>
            <span>$<%= String.format("%.2f", subtotal) %></span>
        </div>
        <div class="d-flex justify-content-between">
            <span>Shipping:</span>
            <span>Free</span>
        </div>
        <div class="d-flex justify-content-between fw-bold mt-2">
            <span>Total:</span>
            <span>$<%= String.format("%.2f", total) %></span>
        </div>

        <div class="mb-3 mt-3">
            <div class="form-check">
                <input class="form-check-input" type="radio" name="paymentMethod" value="bank" id="bank">
                <label class="form-check-label" for="bank">Bank</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="paymentMethod" value="cod" id="cod" checked>
                <label class="form-check-label" for="cod">Cash on delivery</label>
            </div>
        </div>

        <div class="d-flex mb-3">
            <input type="text" name="coupon" class="form-control" placeholder="Coupon Code">
            <button type="button" class="btn btn-danger btn-apply">Apply Coupon</button>
        </div>

        <button type="submit" class="btn btn-danger w-100">Place Order</button>
    </div>
    </form>
</div>

<%@ include file="/view/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
	const checkoutForm = document.querySelector('.billing form');
	
	checkoutForm.addEventListener('submit', function(e){
	 e.preventDefault();
	
	 const formData = new FormData(checkoutForm);
	
	 formData.append('subtotal', '<%= String.format("%.2f", subtotal) %>');
	 formData.append('total', '<%= String.format("%.2f", total) %>');
	
	 fetch('<%=request.getContextPath()%>/placeOrder', {
	     method: 'POST',
	     body: formData
	 })
	 .then(response => response.json())
	 .then(data => {
	     if(data.success){
	         alert('Order placed successfully!');
	         window.location.href = '<%=request.getContextPath()%>/order/confirmation?id=' + data.orderId;
	     } else {
	         alert('Error: ' + data.message);
	     }
	 })
	 .catch(err => {
	     console.error(err);
	     alert('Server error. Please try again.');
	 });
	});
</script>
</body>
</html>
