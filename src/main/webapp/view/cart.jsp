<%@ page import="java.util.List" %>
<%@ page import="com.medsystem.model.bean.CartProduct" %>
<%@ page import="com.medsystem.model.bean.Product" %>
<%
    List<CartProduct> items = (List<CartProduct>) request.getAttribute("cartItems");
    if(items == null) items = new java.util.ArrayList<>();
    double totalPrice = 0;
    for(CartProduct cp : items) {
        Product p = cp.getProduct();
        if(p != null) {
            totalPrice += p.getPrice() * cp.getQuantity();
        }
    }

    session.setAttribute("cartTotal", totalPrice);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cart Page</title>
    <link rel="stylesheet" href="../css/cart.css">
    <style>
        body { font-family: Arial, sans-serif; margin:0; padding:0; background:#fff; }
        .container { width:90%; margin:auto; max-width:1200px; }
        .direction { margin-top:50px; font-size:14px; }
        .cart-table { width:100%; border-collapse:collapse; margin-top:30px; }
        .cart-table th, .cart-table td { padding:15px; border-bottom:1px solid #ddd; text-align:left; }
        .cart-table img { width:60px; }
        .qty-input { width:50px; padding:5px; }
        .btn { padding:10px 18px; border:none; cursor:pointer; border-radius:4px; }
        .btn-red { margin-left:auto; background:#DB4444 !important; color:white; }
        .btn-red1 { background:#DB4444 !important; color:white; max-height:40px; }
        .btn-outline { border:1px solid black !important; background:transparent; }
        .flex { display:flex; align-items:center; gap:20px; }
        .cart-total { margin-left:auto; border:1px solid #ccc; padding:20px; width:280px; margin-top:20px; }
        .cart-total div { display:flex; justify-content:space-between; margin:10px 0; }
        .coupon-box { margin-top:25px; display:flex; gap:10px; width:fit-content; }
        .bottom-box { margin-top:25px; display:flex; gap:10px; }
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
        <% for(CartProduct cp : items) {
               Product p = cp.getProduct();
               if(p != null) { %>
        <tr data-price="<%=p.getPrice()%>" data-cart-product-id="<%=cp.getId()%>">
            <td class="flex">
                <img src="<%=p.getImageUrl()%>" alt="<%=p.getName()%>">
                <span><%=p.getName()%></span>
                <button class="btn btn-outline" onclick="removeItem(this)" style="margin-left:10px; color:red; font-weight:bold;">x</button>
            </td>
            <td>$<span class="price"><%=p.getPrice()%></span></td>
            <td>
                <button type="button" onclick="changeQty(this,-1)">-</button>
                <input type="number" class="qty-input" value="<%=cp.getQuantity()%>" min="1" onchange="updateSubtotal(this)">
                <button type="button" onclick="changeQty(this,1)">+</button>
            </td>
            <td>$<span class="subtotal"><%=p.getPrice() * cp.getQuantity()%></span></td>
        </tr>
        <% } } %>
    </table>

    <div class="flex" style="margin-top:20px;">
        <button class="btn btn-outline" onclick="window.location.href='<%=request.getContextPath()%>/'">Return To Shop</button>
        <button class="btn btn-red" onclick="updateCart()">Update Cart</button>
    </div>

    <div class="bottom-box">
        <div class="coupon-box">
            <input type="text" style="min-width:300px; max-height:40px; border-radius:4px" placeholder="Coupon Code">
            <button class="btn btn-red1">Apply Coupon</button>
        </div>

        <div class="cart-total">
            <h3>Cart Total</h3>
            <div><span>Subtotal:</span><span id="total">$0</span></div>
            <div><span>Shipping:</span><span>Free</span></div>
            <div><strong>Total:</strong><strong id="grand-total">$0</strong></div>
            <button class="btn btn-red" style="width:100%; margin-top:15px;" onclick="window.location.href='<%=request.getContextPath()%>/view/checkout.jsp'">
                Proceed to Checkout
            </button>
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

window.onload = updateTotal;

function updateCart(){
    const rows = document.querySelectorAll('#cart-table tr[data-cart-product-id]');
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '<%=request.getContextPath()%>/cart/update';

    rows.forEach(row=>{
        const cartProductId = row.getAttribute('data-cart-product-id');
        const qty = row.querySelector('.qty-input').value;

        const inputId = document.createElement('input');
        inputId.type = 'hidden';
        inputId.name = 'cartProductId';
        inputId.value = cartProductId;
        form.appendChild(inputId);

        const inputQty = document.createElement('input');
        inputQty.type = 'hidden';
        inputQty.name = 'quantity';
        inputQty.value = qty;
        form.appendChild(inputQty);
    });

    document.body.appendChild(form);
    form.submit();
}

function removeItem(btn){
    const row = btn.closest('tr');
    const cartProductId = row.getAttribute('data-cart-product-id');

    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '<%=request.getContextPath()%>/cart/remove';

    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'cartProductId';
    input.value = cartProductId;
    form.appendChild(input);

    document.body.appendChild(form);
    form.submit();
}
</script>

</body>
</html>
