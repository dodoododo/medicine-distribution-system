package com.medsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.medsystem.model.bean.CartProduct;
import com.medsystem.model.dao.CartProductDAO;

@WebServlet("/cart/update")
public class UpdateCartServlet extends HttpServlet {

    private final CartProductDAO cartProductDAO = new CartProductDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        String[] ids = req.getParameterValues("cartProductId");
        String[] qtys = req.getParameterValues("quantity");

        if(ids != null && qtys != null && ids.length == qtys.length) {
            for(int i = 0; i < ids.length; i++) {
                try {
                    int cartProductId = Integer.parseInt(ids[i]);
                    int quantity = Integer.parseInt(qtys[i]);

                    CartProduct cp = new CartProduct();
                    cp.setId(cartProductId);
                    cp.setQuantity(quantity);

                    cartProductDAO.addOrUpdate(cp);

                } catch (NumberFormatException e) {
                    // Bỏ qua hoặc log lỗi nếu input không hợp lệ
                    e.printStackTrace();
                }
            }
        }

        // Redirect lại cart page, lúc này cart sẽ được render từ DB
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
