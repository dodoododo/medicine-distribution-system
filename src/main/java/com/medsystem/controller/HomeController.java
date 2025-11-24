package com.medsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.medsystem.model.bo.ProductBO;
import com.medsystem.model.bo.CategoryBO;
import com.medsystem.model.bean.Product;
import com.medsystem.model.bean.Category;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet("/")
public class HomeController extends HttpServlet {

    private ProductBO productBO = new ProductBO();
    private CategoryBO categoryBO = new CategoryBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Lấy param filter/sort
        String sortPrice = req.getParameter("sortPrice"); // asc hoặc desc
        String categoryFilter = req.getParameter("category"); // id category

        List<Product> products = productBO.getProductList(); // Bạn sẽ thêm logic lọc bên ProductBO
        List<Category> categories = categoryBO.getAllCategories();

        // Map categoryId → categoryName
        Map<Integer, String> categoryMap = new HashMap<>();
        for (Category c : categories) {
            categoryMap.put(c.getId(), c.getName());
        }

        // Filter theo category
        if (categoryFilter != null && !categoryFilter.isEmpty()) {
            int catId = Integer.parseInt(categoryFilter);
            products.removeIf(p -> p.getCategoryId() != catId);
        }

        // Sort theo price
        if ("asc".equalsIgnoreCase(sortPrice)) {
            products.sort((a, b) -> Double.compare(a.getPrice(), b.getPrice()));
        } else if ("desc".equalsIgnoreCase(sortPrice)) {
            products.sort((a, b) -> Double.compare(b.getPrice(), a.getPrice()));
        }

        req.setAttribute("productList", products);
        req.setAttribute("categoryMap", categoryMap);
        req.setAttribute("categories", categories); // Nếu muốn hiển thị dropdown từ DB

        req.getRequestDispatcher("/home.jsp").forward(req, resp);
    }
}

