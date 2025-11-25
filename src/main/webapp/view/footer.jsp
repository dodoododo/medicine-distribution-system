<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - Thuốc Y Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
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
		
		.container {
		    width: 90%;
		    margin: auto;
		    max-width: 1200px;
		}
    </style>
</head>

<footer>
    <div class="container grid">
        <div>
            <h3>Exclusive</h3>
            <p>Get 10% off your first order</p>
            <input type="text" placeholder="Enter Email">
        </div>
        <div>
            <h3>Support</h3>
            <p>11 Bijoy Sarani, Dhaka, Bangladesh</p>
            <p>exclusive@gmail.com</p>
            <p>+88015-88888-9999</p>
        </div>
        <div>
            <h3>Account</h3>
            <p>My Account</p>
            <p>Login / Register</p>
            <p>Cart</p>
            <p>Wishlist</p>
        </div>
        <div>
            <h3>Download App</h3>
            <p>Save $3 on your first purchase</p>
            <img src="qr.png" width="120">
        </div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>