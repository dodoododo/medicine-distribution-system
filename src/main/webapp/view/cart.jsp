<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %> 
<%@ page import="com.medsystem.model.bean.CartProduct" %>
<%@ page import="com.medsystem.model.bean.Product" %>

<%
    List<CartProduct> items = (List<CartProduct>) request.getAttribute("cartItems");
    if(items == null) items = new java.util.ArrayList<>();
    int cartId = (int) request.getAttribute("cartId");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Cart</title>
    <link rel="stylesheet" href="../css/cart.css">
	<style>
		/* --- BODY & CONTAINER --- */
		body {
		    font-family: Arial, sans-serif;
		    margin: 0;
		    padding: 0;
		    background: #fff;
		}
		
		.direction {
		    margin-top: 50px;
		    font-size: 30px;
		    margin-bottom: 20px;
		    font-weight: bold;
		}
		
		.container {
		    width: 90%;
		    margin: auto;
		    max-width: 1200px;
		    margin-bottom: 60px;
		}
		
		/* --- CART TABLE --- */
		.cart-table {
		    width: 100%;
		    border-collapse: collapse;
		    margin-top: 30px;
		}
		
		.cart-table th,
		.cart-table td {
		    border-bottom: 1px solid #ddd;
		    text-align: left;
		    vertical-align: middle; /* căn giữa theo chiều dọc */
		    padding-top: 10px;
		    padding-bottom: 10px;
		}
		
		.cart-table th {
		    background-color: #f8f8f8;
		}
		
		.cart-table img {
		    width: 60px;
		    height: 60px;
		    object-fit: cover;
		    vertical-align: middle;
		    border-radius: 4px;
		}
		
		/* --- FLEX ITEM (HÌNH + TÊN) --- */
		.flex {
		    display: flex;
		    align-items: center; /* căn giữa theo chiều dọc */
		    justify-items: center;
		    gap: 15px;
		}
		
		/* --- SỐ LƯỢNG & BUTTONS --- */
		.qty-input {
		    width: 50px;
		    padding: 5px;
		    text-align: center;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		    font-size: 14px;
		}
		
		.qty-btn {
		    padding: 6px 12px;
		    margin: 0 2px;
		    border: 1px solid #ccc;
		    background-color: #f8f8f8;
		    cursor: pointer;
		    border-radius: 4px;
		    font-size: 14px;
		}
		
		.qty-btn:hover {
		    background-color: #e0e0e0;
		}
		
		/* --- BUTTON CHUNG --- */
		.btn {
		    padding: 10px 18px;
		    border: none;
		    cursor: pointer;
		    border-radius: 4px;
		}
		
		.btn-red {
		    background: #DB4444 !important;
		    color: white;
		    transition: 0.2s;
		}
		
		.btn-red:hover {
		    background: #c0392b !important;
		}
		
		.btn-outline {
		    border: 1px solid black !important;
		    background: transparent;
		    transition: 0.2s;
		}
		
		.btn-outline:hover {
		    background: #f0f0f0;
		}
		
		/* --- CART TOTAL --- */
		.cart-total {
		    margin-left: auto;
		    border: 1px solid #ccc;
		    padding: 20px;
		    width: 500px;
		    margin-top: 20px;
		    border-radius: 6px;
		    background-color: #fafafa;
		}
		
		.cart-total h3 {
		    margin-top: 0;
		    font-size: 20px;
		    text-align: center;
		}
		
		.cart-total div {
		    display: flex;
		    justify-content: space-between;
		    margin: 10px 0;
		    font-size: 16px;
		}
		
		/* --- BOTTOM BOX --- */
		.bottom-box {
		    margin-top: 25px;
		    display: flex;
		    gap: 10px;
		}
		
		/* --- RESPONSIVE --- */
		@media screen and (max-width: 768px) {
		    .flex {
		        flex-direction: column;
		        align-items: flex-start;
		        gap: 10px;
		    }
		    
		    .cart-total {
		        width: 100%;
		        margin-left: 0;
		    }
		
		    .cart-table th, .cart-table td {
		        padding: 10px;
		        font-size: 14px;
		    }
		
		    .qty-input, .qty-btn {
		        width: 40px;
		        padding: 4px;
		        font-size: 12px;
		    }
		
		    .btn {
		        padding: 8px 14px;
		        font-size: 14px;
		    }
		}
	</style>

</head>

<body>
<%@ include file="/view/header.jsp" %>

<div class="container">
    <div class="direction">Giỏ Hàng Của Tôi</div>

    <a href="<%=request.getContextPath()%>/">
        <button class="btn btn-outline">Quay về Trang Chủ</button>
    </a>

    <table class="cart-table">
        <tr>
            <th>Sản Phẩm</th>
            <th>Giá</th>
            <th>Số Lượng</th>
            <th>Tổng</th>
            <th>Hành Động</th>
        </tr>

        <% for(CartProduct cp : items) {
               Product p = cp.getProduct();
               if(p != null) { %>

        <tr>
            <td class="flex">
                <img src="<%=p.getImageUrl()%>" alt="<%=p.getName()%>">
                <%=p.getName()%>
            </td>
            <td><%=p.getPrice()%> VND</td>


			<td class="flex-center">
			    <form method="post" action="<%=request.getContextPath()%>/cart" style="display:inline;">
			        <input type="hidden" name="userId" value="<%=request.getParameter("userId")%>">
			        <input type="hidden" name="action" value="update">
			        <input type="hidden" name="productId" value="<%=p.getId()%>">
			        <input type="hidden" name="quantity" value="<%=cp.getQuantity()-1%>">
			        <button type="submit" class="btn btn-outline" <%= (cp.getQuantity() <= 1) ? "disabled" : "" %>>-</button>
			    </form>
			
			    <input type="number" class="qty-input" value="<%=cp.getQuantity()%>" disabled>
			
			    <form method="post" action="<%=request.getContextPath()%>/cart" style="display:inline;">
			        <input type="hidden" name="userId" value="<%=request.getParameter("userId")%>">
			        <input type="hidden" name="action" value="update">
			        <input type="hidden" name="productId" value="<%=p.getId()%>">
			        <input type="hidden" name="quantity" value="<%=cp.getQuantity()+1%>">
			        <button type="submit" class="btn btn-outline">+</button>
			    </form>
			</td>

            <td><%= String.format("%,d", p.getPrice() * cp.getQuantity())%> VND</td>

            <td>
                <form method="post" action="<%=request.getContextPath()%>/cart">
                    <input type="hidden" name="userId" value="<%=request.getParameter("userId")%>">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="productId" value="<%=p.getId()%>">
                    <button type="submit" class="btn btn-red">Xóa</button>
                </form>
            </td>
        </tr>

        <% } } %>
    </table>

    <div class="bottom-box">
        <div class="cart-total">
            <h3>Tổng Thanh Toán</h3>

            <div><span>Giá Hàng:</span><span>
                <%
				    int subtotal = items.stream()
				        .mapToInt(cp -> cp.getProduct().getPrice() * cp.getQuantity())
				        .sum();
				%>
				<%= String.format("%,d", subtotal) %> VND
            </span></div>

            <div><span>Giá Ship:</span><span>Miễn Phí</span></div>
            <div><strong>Tổng Thanh Toán:</strong>
                <strong>  
					<%= String.format("%,d", subtotal) %> VND
                </strong>
            </div>

            <button class="btn btn-red" style="width:100%; margin-top:15px;"
                onclick="window.location.href='<%=request.getContextPath()%>/cart?action=checkout&userId=<%=request.getParameter("userId")%>'">
                Đặt Hàng
            </button>
        </div>
    </div>

</div>

<%@ include file="/view/footer.jsp" %>

</body>
</html>
