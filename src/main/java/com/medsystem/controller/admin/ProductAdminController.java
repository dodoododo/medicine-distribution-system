package com.medsystem.controller.admin;

import com.medsystem.model.bean.Product;
import com.medsystem.model.bean.Category;
import com.medsystem.model.bo.ProductBO;
import com.medsystem.model.bo.CategoryBO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/admin/products")
public class ProductAdminController extends HttpServlet {
    private final ProductBO productBO = new ProductBO();
    private final CategoryBO categoryBO = new CategoryBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            List<Category> categories = categoryBO.getAllCategories();
            req.setAttribute("categories", categories);

            if ("add".equals(action)) {
                req.setAttribute("mainPage", "/view/admin/product_form.jsp");
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Product p = productBO.getProductById(id);
                if (p != null) {
                    // Gán category cho product
                    Category c = categories.stream()
                                           .filter(cat -> cat.getId() == p.getCategoryId())
                                           .findFirst()
                                           .orElse(null);
                    p.setCategory(c);
                }
                req.setAttribute("product", p);
                req.setAttribute("mainPage", "/view/admin/product_form.jsp");
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                productBO.deleteProduct(id);
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            } else {
                List<Product> products = productBO.getAllProducts();

                // Gán category cho từng product bằng map để tối ưu
                Map<Integer, Category> categoryMap = categories.stream()
                        .collect(Collectors.toMap(Category::getId, c -> c));
                for (Product p : products) {
                    p.setCategory(categoryMap.get(p.getCategoryId()));
                }

                req.setAttribute("productList", products);
                req.setAttribute("mainPage", "/view/admin/product_list.jsp");
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("mainPage", "/view/admin/product_list.jsp");
        }

        req.getRequestDispatcher("/view/admin/admin_layout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        double price = Double.parseDouble(req.getParameter("price"));
        int stockQuantity = Integer.parseInt(req.getParameter("stockQuantity"));
        String imageUrl = req.getParameter("imageUrl");
        String manufacturer = req.getParameter("manufacturer");
        String expiryDateStr = req.getParameter("expiryDate");
        boolean isActive = "on".equals(req.getParameter("isActive"));

        Product p = new Product();
        p.setCategoryId(categoryId);
        p.setName(name);
        p.setDescription(description);
        p.setPrice(price);
        p.setStockQuantity(stockQuantity);
        p.setImageUrl(imageUrl);
        p.setManufacturer(manufacturer);
        if (expiryDateStr != null && !expiryDateStr.isEmpty()) {
            p.setExpiryDate(Date.valueOf(expiryDateStr));
        }
        p.setActive(isActive);

        try {
            if (idStr == null || idStr.isEmpty()) {
                productBO.addProduct(p);
            } else {
                p.setId(Integer.parseInt(idStr));
                productBO.updateProduct(p);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("product", p);
            req.setAttribute("mainPage", "/view/admin/product_form.jsp");
        }

        req.getRequestDispatcher("/view/admin/admin_layout.jsp").forward(req, resp);
    }
}
