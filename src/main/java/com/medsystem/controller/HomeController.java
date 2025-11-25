package com.medsystem.controller;

import com.medsystem.model.bo.ProductBO; 
import com.medsystem.model.bo.CategoryBO;
import com.medsystem.model.bean.Product;
import com.medsystem.model.bean.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    private final ProductBO productBO = new ProductBO();
    private final CategoryBO categoryBO = new CategoryBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // Lấy danh sách sản phẩm và danh mục từ BO
            List<Product> products = productBO.getAllProducts();
            List<Category> categories = categoryBO.getAllCategories();

            // Map categoryId → categoryName
            Map<Integer, String> categoryMap = categories.stream()
                    .collect(Collectors.toMap(Category::getId, Category::getName));

            // Lấy param filter/sort từ request
            String categoryFilter = req.getParameter("category"); // id category
            String sortPrice = req.getParameter("sortPrice"); // "asc" hoặc "desc"

            // Filter theo category nếu có
            if (categoryFilter != null && !categoryFilter.isEmpty()) {
                try {
                    int catId = Integer.parseInt(categoryFilter);
                    products = products.stream()
                            .filter(p -> p.getCategoryId() == catId)
                            .collect(Collectors.toList());
                } catch (NumberFormatException e) {
                    // Nếu không parse được thì bỏ qua filter
                }
            }

            // Sort theo price nếu có
            if ("asc".equalsIgnoreCase(sortPrice)) {
                products.sort((a, b) -> Double.compare(a.getPrice(), b.getPrice()));
            } else if ("desc".equalsIgnoreCase(sortPrice)) {
                products.sort((a, b) -> Double.compare(b.getPrice(), a.getPrice()));
            }

            // Set attributes để JSP hiển thị
            req.setAttribute("productList", products);
            req.setAttribute("categories", categories);
            req.setAttribute("categoryMap", categoryMap);

        } catch (Exception e) {
            // Bắt tất cả lỗi từ BO/DAO
            e.printStackTrace(); // log ra console để debug
            req.setAttribute("error", "Có lỗi xảy ra khi tải dữ liệu: " + e.getMessage());
        }

        // Chuyển đến trang home.jsp
        req.getRequestDispatcher("/home.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp); // POST cũng xử lý giống GET
    }
}
