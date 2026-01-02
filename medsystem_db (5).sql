-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 13, 2025 lúc 04:21 PM
-- Phiên bản máy phục vụ: 8.0.42
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `medsystem_db`
--
CREATE DATABASE IF NOT EXISTS `medsystem_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `medsystem_db`;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart`
--

CREATE TABLE `cart` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `created_at`) VALUES
(1, NULL, '2025-12-05 06:18:24'),
(2, NULL, '2025-12-05 06:18:24'),
(3, NULL, '2025-12-05 06:18:24'),
(4, 3, '2025-12-05 06:18:24'),
(5, 3, '2025-12-05 06:18:24'),
(6, 4, '2025-12-05 06:18:24'),
(7, 5, '2025-12-05 06:18:24'),
(8, 1, '2025-12-05 06:18:24'),
(9, 7, '2025-12-05 06:18:24'),
(10, 8, '2025-12-06 03:59:19'),
(11, 8, '2025-12-06 04:43:36'),
(12, 7, '2025-12-06 04:47:34'),
(13, 7, '2025-12-06 04:47:43'),
(14, 7, '2025-12-06 04:48:07'),
(15, 7, '2025-12-06 04:55:47'),
(16, 7, '2025-12-06 05:10:38'),
(17, 8, '2025-12-06 05:15:15'),
(18, 7, '2025-12-06 06:51:57'),
(19, 7, '2025-12-06 07:15:04'),
(20, 7, '2025-12-06 07:20:18'),
(21, 7, '2025-12-06 07:26:14'),
(22, 5, '2025-12-06 08:03:03'),
(23, 4, '2025-12-06 08:05:38'),
(24, 7, '2025-12-06 09:37:07'),
(25, 7, '2025-12-06 10:04:01'),
(26, 7, '2025-12-06 10:05:09'),
(27, 1, '2025-12-06 10:06:07'),
(28, 5, '2025-12-13 06:12:12');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart_product`
--

CREATE TABLE `cart_product` (
  `id` int NOT NULL,
  `cart_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `cart_product`
--

INSERT INTO `cart_product` (`id`, `cart_id`, `product_id`, `quantity`) VALUES
(1, 1, 2, 1),
(2, 1, 3, 2),
(3, 2, 2, 1),
(4, 3, 3, 2),
(5, 4, 3, 1),
(6, 5, 4, 2),
(9, 6, 1, 8),
(11, 9, 1, 13),
(12, 9, 4, 7),
(13, 9, 8, 8),
(14, 6, 2, 1),
(15, 6, 4, 1),
(16, 8, 3, 1),
(17, 7, 6, 1),
(18, 10, 1, 1),
(19, 10, 5, 2),
(20, 10, 4, 1),
(21, 12, 2, 1),
(22, 13, 3, 1),
(23, 14, 3, 2),
(24, 15, 1, 1),
(25, 11, 8, 1),
(26, 16, 2, 1),
(27, 18, 1, 2),
(28, 18, 7, 2),
(29, 18, 6, 3),
(30, 19, 1, 1),
(31, 20, 1, 1),
(32, 21, 1, 2),
(33, 21, 7, 2),
(34, 21, 8, 1),
(35, 21, 4, 3),
(36, 21, 3, 1),
(37, 24, 3, 4),
(38, 25, 3, 4),
(39, 22, 1, 2),
(40, 22, 7, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1, 'Thuốc giảm đau', 'Các loại thuốc giảm đau, hạ sốt thông thường'),
(2, 'Kháng sinh', 'Thuốc kháng sinh điều trị nhiễm khuẩn'),
(3, 'Vitamin & Khoáng chất', 'Thực phẩm bổ sung vitamin và khoáng chất'),
(4, 'Dụng cụ y tế', 'Bông băng, nhiệt kế, máy đo huyết áp'),
(5, 'Dược mỹ phẩm', 'Sản phẩm chăm sóc da và vệ sinh cá nhân');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `cart_id` int DEFAULT NULL,
  `full_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `shipping_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_amount` int NOT NULL,
  `status` enum('PENDING','PROCESSING','SHIPPING','DELIVERED','CANCELLED') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'PENDING',
  `payment` tinyint(1) NOT NULL DEFAULT '0',
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `cart_id`, `full_name`, `phone`, `shipping_address`, `total_amount`, `status`, `payment`, `order_date`) VALUES
(16, 20, 'Hau', '012345678', '123 Nguyen Sinh Sac                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    ', 13000, 'DELIVERED', 1, '2025-12-06 07:26:14'),
(17, 7, 'Tang Ngoc Hau', '0944556677', '321 Võ Văn Kiệt, Cần Thơ\r\n                    ', 350000, 'DELIVERED', 0, '2025-12-06 08:03:03'),
(18, 6, 'Lê Hoàng Cường', '0933445566', '789 Trần Hưng Đạo, Đà Nẵng\r\n                    ', 242000, 'DELIVERED', 0, '2025-12-06 08:05:38'),
(19, 21, 'Hau', '012345678', 'Hello\r\n                    ', 1971000, 'DELIVERED', 0, '2025-12-06 09:37:07'),
(20, 24, 'Hau', '012345678', 'Hello\r\n                    ', 1000000, 'DELIVERED', 0, '2025-12-06 10:04:01'),
(21, 25, 'Hau', '012345678', 'Hello\r\n                    ', 1000000, 'DELIVERED', 0, '2025-12-06 10:05:09'),
(22, 8, 'Quản Trị Viên', '0901234567', 'Hà Nội\r\n                    ', 250000, 'DELIVERED', 0, '2025-12-06 10:06:07'),
(23, 22, 'Tang Ngoc Hau', '0944556677', '321 Võ Văn Kiệt, Cần Thơ\r\n                    ', 1326000, 'DELIVERED', 1, '2025-12-13 06:12:12');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `price` int NOT NULL,
  `stock_quantity` int DEFAULT '0',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manufacturer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `price`, `stock_quantity`, `image_url`, `manufacturer`, `expiry_date`, `is_active`) VALUES
(1, 1, 'Panadol Extra', 'Thuốc giảm đau hạ sốt hiệu quả nhanh', 13000, 100, 'https://cdn11.bigcommerce.com/s-vhzbg5/images/stencil/1280x1280/products/1685/4601/apienjn0l__79221.1499347775.jpg?c=2', 'GSK', '2026-12-31', 1),
(2, 1, 'Efferalgan 500mg', 'Viên sủi giảm đau hạ sốt', 18000, 80, 'https://cdn.upharma.vn/unsafe/3840x0/filters:quality(90)/san-pham/8255.png', 'UPSA', '2026-10-20', 1),
(3, 2, 'Augmentin 625mg', 'Kháng sinh phổ rộng', 250000, 50, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToAdVvzvQLhrE4A8_5yKnycl0DkR5DZCyxow&s', 'GSK', '2025-08-15', 1),
(4, 2, 'Klamentin', 'Kháng sinh điều trị nhiễm khuẩn', 120000, 60, 'https://trungsoncare.com/images/detailed/16/1_xskx-4o.png', 'Dược Hậu Giang', '2025-09-10', 1),
(5, 3, 'Vitamin C 1000mg', 'Tăng sức đề kháng', 80000, 200, 'https://production-cdn.pharmacity.io/digital/828x828/plain/e-com/images/ecommerce/20250508081130-0-P25086_1.png?versionId=OuIKxjEc9yGfO8DAPs0bP9GSGJOeUSpf', 'Kirkland', '2027-01-01', 1),
(6, 3, 'Omega 3 Fish Oil', 'Dầu cá bổ mắt, tốt cho tim mạch', 350000, 40, 'https://trungsoncare.com/images/detailed/14/1_56vp-3d.png', 'Nature Made', '2027-05-20', 1),
(7, 4, 'Nhiệt kế điện tử Omron', 'Đo nhiệt độ cơ thể chính xác', 650000, 20, 'https://www.moby.com.vn/data/ck/images/b9603c9932634afe9012629c1701576f.jpg', 'Omron', '2030-01-01', 1),
(8, 4, 'Băng cá nhân Urgo', 'Hộp 100 miếng', 35000, 300, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/443/082/products/10-white-png.png?v=1676862567247', 'Urgo', '2028-01-01', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `full_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `role` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password`, `phone`, `address`, `role`, `created_at`) VALUES
(1, 'Quản Trị Viên', 'admin@medsystem.com', '123456', '0901234567', 'Hà Nội', 1, '2025-11-23 23:46:30'),
(3, 'Trần Thị Bích', 'bich@email.com', '123456', '0987654321', '456 Nguyễn Huệ, TP.HCM', 0, '2025-11-23 23:46:30'),
(4, 'Lê Hoàng Cường', 'cuong@email.com', '1234567', '0933445566', '789 Trần Hưng Đạo, Đà Nẵng', 0, '2025-11-23 23:46:30'),
(5, 'Tang Ngoc Hau', 'hau@email.com', '123456', '0944556677', '321 Võ Văn Kiệt, Cần Thơ', 0, '2025-11-23 23:46:30'),
(6, 'Nguyen Van A', 'a@gmail.com', '123456', '0123456789', '12', 0, '2025-11-27 14:11:18'),
(7, 'Hau', 'user@gmail.com', '123456', '012345678', 'Hello', 0, '2025-12-02 11:29:14'),
(8, 'Fake', 'hau123@gmail.com', 'Hau123.', '0123456798', '', 0, '2025-12-06 03:48:26');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `cart_product`
--
ALTER TABLE `cart_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_id` (`cart_id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT cho bảng `cart_product`
--
ALTER TABLE `cart_product`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `cart_product`
--
ALTER TABLE `cart_product`
  ADD CONSTRAINT `cart_product_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_product_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
