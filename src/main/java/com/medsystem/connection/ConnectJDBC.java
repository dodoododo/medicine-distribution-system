package com.medsystem.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectJDBC {

    // Cấu hình database
    private static final String HOST = "127.0.0.1";
    private static final int PORT = 3306; // Thay bằng port của bạn
    private static final String DB_NAME = "medsystem_db";
    private static final String USER = "root";
    private static final String PASSWORD = "DuyThai04";

    // URL kết nối đầy đủ các tham số quan trọng
    // useUnicode=true&characterEncoding=UTF-8: Để lưu/đọc tiếng Việt không lỗi
    private static final String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME + "?"
            + "useUnicode=true&characterEncoding=UTF-8"
            + "&useSSL=false"
            + "&serverTimezone=UTC"
            + "&allowPublicKeyRetrieval=true";

    // Load Driver 1 lần duy nhất khi class được nạp
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            // Nếu lỗi driver thì chương trình không chạy được, nên có thể throw RuntimeException
            throw new RuntimeException("Không tìm thấy Driver MySQL! Hãy kiểm tra thư viện.");
        }
    }

    public static Connection getConnection() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            // System.out.println("Kết nối thành công!"); // Mở ra để test nếu cần
        } catch (SQLException e) {
            System.err.println("Kết nối thất bại!");
            e.printStackTrace();
        }
        return conn;
    }
    
    // Hàm main để test nhanh kết nối (Chạy Run As Java Application)
    public static void main(String[] args) {
        Connection c = getConnection();
        if(c != null) {
            System.out.println("Test kết nối thành công!");
        } else {
            System.out.println("Test kết nối thất bại.");
        }
    }
}