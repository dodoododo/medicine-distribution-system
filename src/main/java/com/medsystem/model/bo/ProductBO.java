package com.medsystem.model.bo;

import com.medsystem.model.bean.Product;
import com.medsystem.model.dao.ProductDAO;

import java.sql.SQLException;
import java.util.List;

public class ProductBO {
    private final ProductDAO dao = new ProductDAO();

    public List<Product> getAllProducts() throws SQLException { return dao.getAllProducts(); }
    public Product getProductById(int id) throws SQLException { return dao.getProductById(id); }
    public void addProduct(Product p) throws SQLException { dao.insertProduct(p); }
    public void updateProduct(Product p) throws SQLException { dao.updateProduct(p); }
    public void deleteProduct(int id) throws SQLException { dao.deleteProduct(id); }
}
