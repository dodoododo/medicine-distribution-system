package com.medsystem.controller;

import com.medsystem.model.bean.Product;
import com.medsystem.model.bo.ProductBO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// Khi người dùng gõ /home, nó sẽ chạy vào đây
@WebServlet(urlPatterns = {"/home"})
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductBO productBO = new ProductBO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Lấy danh sách sản phẩm từ Database (thông qua BO)
        List<Product> list = productBO.getProductList();
        
        // 2. Gắn danh sách vào request để trang JSP có thể dùng
        request.setAttribute("productList", list);
        
        // 3. Chuyển tiếp (Forward) về trang index.jsp
        // Lưu ý: Đường dẫn này tính từ thư mục webapp
        RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}