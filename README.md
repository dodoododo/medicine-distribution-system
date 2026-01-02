# 📦 Medicine Distribution System

> **Medicine Distribution System** is a web-based application designed to manage the online distribution and sale of medicines. The system allows users to browse available medicines, place orders, and track order status, while administrators can manage inventory, users, and orders. The project is built using **Java Servlet (MVC architecture)** with **MySQL** as the database.

---

## 🧠 Features

- 🧑‍💼 User registration and authentication
- 🛍️ Browse medicine catalog
- 🛒 Shopping cart and order placement
- 📦 Order management and tracking
- 💳 Payment workflow (basic / placeholder)
- ⚙️ Admin panel for managing medicines, users, and orders

---

## 🛠️ Technologies Used

| Layer | Technology |
|------|-----------|
| Backend | Java Servlet (MVC) |
| Frontend | JSP, HTML, CSS, JavaScript, bootstrap |
| Database | MySQL |
| Server | Apache Tomcat |
| Tools | Git, GitHub |
| Database Tool | phpMyAdmin |

---

## 📁 Project Structure
```
medicine-distribution-system/
├── src/main/java/ # Java Servlets, Controllers, DAO
├── WebContent/ # JSP views, CSS, JS
├── medsystem_db (5).sql # MySQL database schema and sample data
├── .project
├── .classpath
├── README.md
└── .gitignore
```
---

## 🗃️ Database Schema (From SQL File)

### 📌 `users`

| Column | Type | Description |
|------|------|-------------|
| id | INT | Primary key |
| full_name | VARCHAR(100) | User full name |
| email | VARCHAR(100) | Email address |
| password | VARCHAR(255) | Encrypted password |
| phone | VARCHAR(20) | Phone number |
| address | TEXT | Shipping address |
| role | TINYINT(1) | 0 = User, 1 = Admin |
| created_at | TIMESTAMP | Account creation time |

---

### 📌 `categories`

| Column | Type | Description |
|------|------|-------------|
| id | INT | Primary key |
| name | VARCHAR(100) | Category name |
| description | TEXT | Category description |

---

### 📌 `products`

| Column | Type | Description |
|------|------|-------------|
| id | INT | Primary key |
| category_id | INT | Foreign key (categories) |
| name | VARCHAR(255) | Medicine name |
| description | TEXT | Medicine description |
| price | INT | Price |
| stock_quantity | INT | Available stock |
| image_url | VARCHAR(255) | Product image path |
| manufacturer | VARCHAR(100) | Manufacturer |
| expiry_date | DATE | Expiry date |
| is_active | TINYINT(1) | Active status |

---

### 📌 `cart`

| Column | Type | Description |
|------|------|-------------|
| id | INT | Primary key |
| user_id | INT | Foreign key (users) |
| created_at | TIMESTAMP | Cart creation time |

---

### 📌 `cart_product`

| Column | Type | Description |
|------|------|-------------|
| id | INT | Primary key |
| cart_id | INT | Foreign key (cart) |
| product_id | INT | Foreign key (products) |
| quantity | INT | Quantity |

---

### 📌 `orders`

| Column | Type | Description |
|------|------|-------------|
| id | INT | Primary key |
| cart_id | INT | Foreign key (cart) |
| full_name | VARCHAR(100) | Receiver name |
| phone | VARCHAR(20) | Contact phone |
| shipping_address | TEXT | Delivery address |
| total_amount | INT | Total price |
| status | ENUM | `PENDING`, `PROCESSING`, `SHIPPING`, `DELIVERED`, `CANCELLED` |
| created_at | TIMESTAMP | Order date |

---

## 🚀 Installation & Setup

### ✅ Requirements

- Java JDK 8+
- Apache Tomcat 10.1+
- MySQL Server
- IDE (Eclipse / IntelliJ IDEA)
- phpMyAdmin (recommended)

---

### 🪄 Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/dodoododo/medicine-distribution-system.git
2. Import as **Dynamic Web Project**

---

## 🗄️ Create Database

```sql
CREATE DATABASE medsystem_db;
USE medsystem_db;
SOURCE medsystem_db (5).sql;
```

## 🔧 Configure Database Connection

Update database credentials in DAO or configuration file:

```
jdbc.url=jdbc:mysql://localhost:3306/medsystem_db
jdbc.username=root
jdbc.password=your_password
```

## ▶️ Run Project

Deploy on Apache Tomcat

Open browser:
```
http://localhost:8080/medicine-distribution-system
```

## 🧑‍💻 How to Use

### 🔐 Login & Register
- Users can create an account
- Login using email and password

---

### 🛍️ Browse Medicines
- View medicines by category
- Check price, and manufacturer

---

### 🛒 Cart & Checkout
- Add products to cart
- Enter shipping information
- Place order

---

### 📦 Order Tracking
- Track order status
- View order history

---
### ⚙️ Admin Panel
Admins can:
- Manage categories
- Manage medicines
- Manage users
- See shop statistics
- Update order status


## 🖼️ Demonstration Screenshots


### Home Page
<img width="1919" height="969" alt="Screenshot 2025-12-13 230938" src="https://github.com/user-attachments/assets/1592686a-b5c6-45c0-8a36-a3cd78476120" />

### Login/Sign-up

<img width="1919" height="970" alt="Screenshot 2025-12-13 231325" src="https://github.com/user-attachments/assets/ed8eca99-14da-4ef6-98ae-7b6988132451" />
<img width="1916" height="970" alt="Screenshot 2025-12-13 231421" src="https://github.com/user-attachments/assets/b8c8a613-773d-4f58-85b0-6fb24375dfce" />

### Sort product by price/category
<img width="1919" height="973" alt="Screenshot 2025-12-13 232045" src="https://github.com/user-attachments/assets/856315f2-5888-4778-a91e-46c8d9c16110" />


### User's cart
<img width="1919" height="969" alt="Screenshot 2025-12-13 232356" src="https://github.com/user-attachments/assets/e9045d80-9fdb-45e5-ae7c-48705c9a3260" />


### Checkout Form
<img width="1919" height="963" alt="Screenshot 2025-12-13 232524" src="https://github.com/user-attachments/assets/04d815d8-e591-4e0d-845d-8c1a7cde24c5" />


### Order Success
<img width="1919" height="961" alt="Screenshot 2025-12-13 233152" src="https://github.com/user-attachments/assets/db1ea6c8-6645-4f6a-a747-f7e84343a127" />


### Order Failed
<img width="1919" height="968" alt="Screenshot 2025-12-13 233236" src="https://github.com/user-attachments/assets/70bc76c9-03bc-45fd-a44d-22ec92f40db6" />


### Track order status/ View order history
<img width="1919" height="967" alt="Screenshot 2025-12-13 233331" src="https://github.com/user-attachments/assets/98e16a48-6f99-4e0e-98d5-d83891a338d1" />
<img width="1919" height="956" alt="Screenshot 2025-12-13 233707" src="https://github.com/user-attachments/assets/529e2155-ad54-4b6b-97a6-ebb970fd594a" />


### User profile
<img width="1919" height="966" alt="Screenshot 2025-12-13 234557" src="https://github.com/user-attachments/assets/982475f0-ac34-423d-a4e6-8b294311cbf0" />


## Admin features

### Admin Screen - Catergory Management
<img width="1919" height="966" alt="Screenshot 2025-12-13 234831" src="https://github.com/user-attachments/assets/b4cd5ca0-736b-41df-ae17-5302834d4882" />


### Product management
<img width="1919" height="958" alt="Screenshot 2025-12-13 235305" src="https://github.com/user-attachments/assets/28632f45-d8c8-4ff7-a6c2-bab60aafebea" />


### User Managemnt
<img width="1919" height="964" alt="Screenshot 2025-12-13 235430" src="https://github.com/user-attachments/assets/6dbd9cb3-9fb3-465f-a9e7-f7dd2602f9be" />


### Order Management
<img width="1919" height="963" alt="Screenshot 2025-12-14 000505" src="https://github.com/user-attachments/assets/eefa3a6e-0be8-4258-9845-8e2cd24fbc65" />


### Order Details
<img width="1919" height="961" alt="Screenshot 2025-12-14 000556" src="https://github.com/user-attachments/assets/6cc1450f-10a1-4b4b-acba-bf016a69c9b7" />


### Update Order's status
<img width="1919" height="969" alt="Screenshot 2025-12-14 000639" src="https://github.com/user-attachments/assets/3350ec02-2f09-4a17-ab79-7fb181aa67ab" />


### Store's statistics
<img width="1919" height="971" alt="Screenshot 2025-12-14 000722" src="https://github.com/user-attachments/assets/e065af75-2fb2-405f-a5bd-fbc9a2c07d2c" />
<img width="1919" height="972" alt="Screenshot 2025-12-14 000937" src="https://github.com/user-attachments/assets/65272886-56e9-4412-ac90-2f33e32d5f4f" />
<img width="1919" height="967" alt="Screenshot 2025-12-14 000954" src="https://github.com/user-attachments/assets/2ed89a65-9954-4de3-998f-9c328b0a9844" />


## 🤝 Contributors
- [Me](https://github.com/dodoododo)
- [Ngoc](https://github.com/sangoonthego)
- [Thai](https://github.com/Chipp4)
