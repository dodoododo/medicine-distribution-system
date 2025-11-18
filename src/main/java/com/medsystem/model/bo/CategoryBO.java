package com.medsystem.model.bo;

import com.medsystem.model.bean.Category;
import com.medsystem.model.dao.CategoryDAO;
import java.util.List;

public class CategoryBO {
    private CategoryDAO categoryDAO = new CategoryDAO();
    public List<Category> getAllCategories() {
        return categoryDAO.getAllCategories();
    }
}