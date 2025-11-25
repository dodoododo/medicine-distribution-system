package com.medsystem.controller.admin;

import com.medsystem.model.bean.Category;
import com.medsystem.model.bo.CategoryBO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class CategoryAdminController extends HttpServlet {
    private final CategoryBO categoryBO = new CategoryBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("add".equals(action)) {
                req.setAttribute("mainPage", "/view/admin/category_form.jsp");
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Category c = categoryBO.getCategoryById(id);
                req.setAttribute("category", c);
                req.setAttribute("mainPage", "/view/admin/category_form.jsp");
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                categoryBO.deleteCategory(id);
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                return;
            } else {
                List<Category> list = categoryBO.getAllCategories();
                req.setAttribute("categoryList", list);
                req.setAttribute("mainPage", "/view/admin/category_list.jsp");
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("mainPage", "/view/admin/category_list.jsp");
        }

        req.getRequestDispatcher("/view/admin/admin_layout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String description = req.getParameter("description");

        Category c = new Category();
        c.setName(name);
        c.setDescription(description);

        try {
            if (idStr == null || idStr.isEmpty()) {
                categoryBO.addCategory(c);
            } else {
                c.setId(Integer.parseInt(idStr));
                categoryBO.updateCategory(c);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
            return;
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("category", c);
            req.setAttribute("mainPage", "/view/admin/category_form.jsp");
        }

        req.getRequestDispatcher("/view/admin/admin_layout.jsp").forward(req, resp);
    }
}
