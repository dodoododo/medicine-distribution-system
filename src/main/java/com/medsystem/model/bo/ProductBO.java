package com.medsystem.model.bo;

import com.medsystem.model.bean.Product;
import com.medsystem.model.dao.ProductDAO;

import java.util.List;

public class ProductBO {
    
    private ProductDAO productDAO = new ProductDAO();

    public List<Product> getProductList() {
        // Tại đây có thể thêm logic kiểm tra nghiệp vụ nếu cần
        // Ví dụ: Chỉ lấy sản phẩm đang hoạt động (is_active = true)
        return productDAO.getAllProducts();
    }
}