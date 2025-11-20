package com.medsystem.controller;

import com.medsystem.model.bean.Category;
import com.medsystem.model.bean.Product;
import com.medsystem.model.bo.CategoryBO;
import com.medsystem.model.bo.ProductBO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/home"})
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductBO productBO = new ProductBO();
    private CategoryBO categoryBO = new CategoryBO(); // Thêm CategoryBO


    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}