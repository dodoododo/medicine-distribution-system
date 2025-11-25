//package com.medsystem.model.bean;
//
//import java.sql.Timestamp;
//
//public class User {
//    private int id;
//    private String fullName;
//    private String email;
//    private String password;
//    private String phone;
//    private String address;
//    private int role; // 1 = admin, 0 = user
//    private Timestamp createdAt;
//
//    // 1. Constructor rỗng
//    public User() {}
//
//    // 2. Constructor đầy đủ
//    public User(int id, String fullName, String email, String password, String phone, String address, int role, Timestamp createdAt) {
//        this.id = id;
//        this.fullName = fullName;
//        this.email = email;
//        this.password = password;
//        this.phone = phone;
//        this.address = address;
//        this.role = role;
//        this.createdAt = createdAt;
//    }
//
//    // 3. Getters và Setters
//    public int getId() { return id; }
//    public void setId(int id) { this.id = id; }
//
//    public String getFullName() { return fullName; }
//    public void setFullName(String fullName) { this.fullName = fullName; }
//
//    public String getEmail() { return email; }
//    public void setEmail(String email) { this.email = email; }
//
//    public String getPassword() { return password; }
//    public void setPassword(String password) { this.password = password; }
//
//    public String getPhone() { return phone; }
//    public void setPhone(String phone) { this.phone = phone; }
//
//    public String getAddress() { return address; }
//    public void setAddress(String address) { this.address = address; }
//
//    public int getRole() { return role; }
//    public void setRole(int role) { this.role = role; }
//
//    public Timestamp getCreatedAt() { return createdAt; }
//    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
//
//    // 4. Kiểm tra người dùng có phải admin không
//    public boolean isAdmin() {
//        return role == 1;
//    }
//
//    // 5. Kiểm tra người dùng là user thường
//    public boolean isUser() {
//        return role == 0;
//    }
//}

package com.medsystem.model.bean;

import java.sql.Timestamp;

public class User {
    private int id;
    private String fullName;
    private String email;
    private String password;
    private String phone;
    private String address;
    private int role; // 1 = admin, 0 = user
    private Timestamp createdAt;

    public User() {}

    public User(int id, String fullName, String email, String password, String phone, String address, int role, Timestamp createdAt) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public int getRole() { return role; }
    public void setRole(int role) { this.role = role; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    // Kiểm tra admin
    public boolean isAdmin() {
        return role == 1;
    }

    // Kiểm tra user thường
    public boolean isUser() {
        return role == 0;
    }

    // Trả về tên role để dùng nếu cần
    public String getRoleName() {
        return role == 1 ? "ADMIN" : "USER";
    }
}
