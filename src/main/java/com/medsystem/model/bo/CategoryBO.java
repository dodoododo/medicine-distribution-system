package com.medsystem.model.bo;

import com.medsystem.model.bean.Category;
import com.medsystem.model.dao.CategoryDAO;

import java.sql.SQLException;
import java.util.List;

public class CategoryBO {
    private final CategoryDAO dao = new CategoryDAO();

    public List<Category> getAllCategories() throws SQLException { return dao.getAllCategories(); }
    public Category getCategoryById(int id) throws SQLException { return dao.getCategoryById(id); }
    public void addCategory(Category c) throws SQLException { dao.insertCategory(c); }
    public void updateCategory(Category c) throws SQLException { dao.updateCategory(c); }
    public void deleteCategory(int id) throws SQLException { dao.deleteCategory(id); }
}
