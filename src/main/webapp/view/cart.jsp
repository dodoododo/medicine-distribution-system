<%@ page import="java.util.List" %>
<%@ page import="com.medsystem.model.bean.Product" %>
<%
    List<Product> cart = (List<Product>) session.getAttribute("cart");
    if(cart == null){
        cart = new java.util.ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart Page</title>
    <link rel="stylesheet" href="../css/cart.css">
    <style>
    	body {
		    font-family: Arial, sans-serif;
		    margin: 0;
		    padding: 0;
		    background: #fff;
		}
		
		header {
		    width: 100%;
		    padding: 20px 0;
		    background: #f8f8f8;
		    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
		}
		
		.direction {
		    margin-top: 50px;
		    font-size: 14px;
		}
		
		.navbar-top {
		    width: 100%;
		    background: #fff;
		    padding: 15px 0;
		    border-bottom: 1px solid #ddd;
		}
		
		.nav-container {
		    width: 90%;
		    margin: auto;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		}
		
		.nav-left {
		    margin-left: 80px;
		    display: flex;
		    align-items: center;
		    gap: 40px;
		}
		
		.nav-menu {
		    margin-left: 170px;
		    display: flex;
		    align-items: center;
		    gap: 50px;
		}
		
		.nav-item {
		    text-decoration: none;
		    color: #000;
		    font-size: 16px;
		}
		
		.nav-right {
		    margin-right: 80px;
		    display: flex;
		    align-items: center;
		    gap: 20px;
		}
		
		.search-input {
		    width:225px;
		    padding: 8px 12px;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		}
		
		.icon {
		    font-size: 20px;
		    cursor: pointer;
		}
		
		footer {
		    width: 100%;
		}
		
		.container {
		    width: 90%;
		    margin: auto;
		    max-width: 1200px;
		}
		
		.cart-table {
		    width: 100%;
		    border-collapse: collapse;
		    margin-top: 30px;
		}
		
		.cart-table th,
		.cart-table td {
		    padding: 15px;
		    border-bottom: 1px solid #ddd;
		    text-align: left;
		}
		
		.cart-table img {
		    width: 60px;
		}
		
		.qty-input {
		    width: 50px;
		    padding: 5px;
		}
		
		.btn {
		    padding: 10px 18px;
		    border: none;
		    cursor: pointer;
		    border-radius: 4px;
		}
		
		.btn-red {
			margin-left: auto;
		    background: #DB4444 !important;
		    color: white;
		}
		
		.btn-red1 {
		    background: #DB4444 !important;
		    color: white;
		}
		
		.btn-outline {
		    border: 1px solid black !important;
		    background: transparent;
		}
		
		.flex {
		    display: flex;
		    align-items: center;
		    gap: 20px;
		}
		
		.cart-total {
			margin-left: auto;
		    border: 1px solid #ccc;
		    padding: 20px;
		    width: 280px;
		    margin-top: 20px;
		}
		
		.cart-total div {
		    display: flex;
		    justify-content: space-between;
		    margin: 10px 0;
		}
		
		.coupon-box {
		    margin-top: 25px;
		    display: flex;
		    gap: 10px;
		    width: fit-content;
		    height: fit-content;
		}
		
		.bottom-box {
			margin-top: 25px;
		    display: flex;
		    gap: 10px;
		}
		
		footer {
		    background: #000;
		    color: #fff;
		    padding: 40px 0;
		    margin-top: 40px;
		}
		
		footer .grid {
		    display: grid;
		    grid-template-columns: repeat(4, 1fr);
		    gap: 30px;
		}
		
		footer input {
		    padding: 10px;
		    width: 80%;
		}
    </style>
</head>
<body>    
<%@ include file="/view/header.jsp" %>

<div class="container">
    <div class="direction">Home / Cart</div>
    <table class="cart-table" id="cart-table">
        <tr>
            <th>Product</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
        </tr>
        <% for(Product p : cart) { %>
        <tr data-price="<%=p.getPrice()%>">
            <td class="flex"><img src="<%=p.getImageUrl()%>"> <%=p.getName()%></td>
            <td>$<span class="price"><%=p.getPrice()%></span></td>
            <td>
                <button type="button" class="qty-btn" onclick="changeQty(this,-1)">-</button>
                <input type="number" class="qty-input" value="1" min="1" onchange="updateSubtotal(this)">
                <button type="button" class="qty-btn" onclick="changeQty(this,1)">+</button>
            </td>
            <td>$<span class="subtotal"><%=p.getPrice()%></span></td>
        </tr>
        <% } %>
    </table>

    <div class="flex" style="margin-top:20px;">
        <button class="btn btn-outline">Return To Shop</button>
        <button class="btn btn-red" onclick="updateCart()">Update Cart</button>
    </div>

    <div class="bottom-box">
        <div class="coupon-box">
            <input type="text" style="min-width: 300px; border-radius: 4px" placeholder="Coupon Code">
            <button class="btn btn-red1">Apply Coupon</button>
        </div>

        <div class="cart-total">
            <h3>Cart Total</h3>
            <div><span>Subtotal:</span><span id="total">$0</span></div>
            <div><span>Shipping:</span><span>Free</span></div>
            <div><strong>Total:</strong><strong id="grand-total">$0</strong></div>
            <button class="btn btn-red" style="width:100%; margin-top:15px;">Proceed to Checkout</button>
        </div>
    </div>
</div>

<%@ include file="/view/footer.jsp" %>

<script>
	function changeQty(btn, delta){
	    const input = btn.parentElement.querySelector('.qty-input');
	    let val = parseInt(input.value) + delta;
	    if(val < 1) val = 1;
	    input.value = val;
	    updateSubtotal(input);
	}
	
	function updateSubtotal(input){
	    const row = input.closest('tr');
	    const price = parseFloat(row.getAttribute('data-price'));
	    const qty = parseInt(input.value);
	    const subtotalElem = row.querySelector('.subtotal');
	    subtotalElem.textContent = (price * qty).toFixed(2);
	    updateTotal();
	}
	
	function updateTotal(){
	    const subtotals = document.querySelectorAll('.subtotal');
	    let total = 0;
	    subtotals.forEach(s => total += parseFloat(s.textContent));
	    document.getElementById('total').textContent = total.toFixed(2);
	    document.getElementById('grand-total').textContent = total.toFixed(2);
	}
	
	// Khởi tạo tổng khi load trang
	window.onload = updateTotal;
	
	function updateCart(){
	    alert('Cart updated! (Implement server-side update if needed)');
	}
</script>

</body>
</html>
