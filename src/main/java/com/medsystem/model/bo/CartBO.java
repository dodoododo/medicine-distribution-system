package com.medsystem.model.bo;

import com.medsystem.model.bean.Cart;
import com.medsystem.model.bean.CartProduct;
import com.medsystem.model.dao.CartDAO; // Chỉ phụ thuộc vào Interface

import java.util.List;

public class CartBO {
    private CartDAO cartDAO;

    public CartBO() {
        this.cartDAO = new CartDAO();
    }

    public Cart getCartByUserId(int userId) {
        Cart cart = cartDAO.getCartByUserId(userId);
        if (cart != null) {
            List<CartProduct> items = cartDAO.getCartProductsByCartId(cart.getId());
            cart.setItems(items);
            
        }
        return cart;
    }

    public boolean addOrUpdateProduct(int cartId, int productId, int quantity) {
        CartProduct existingItem = cartDAO.getCartProductByCartAndProduct(cartId, productId);
        
        if (existingItem != null) {
            int newQuantity = existingItem.getQuantity() + quantity;
            existingItem.setQuantity(newQuantity);
            return cartDAO.updateCartProduct(existingItem);
        } else {
            CartProduct newItem = new CartProduct(cartId, productId, quantity);
            return cartDAO.addCartProduct(newItem);
        }
    }
 
    public double calculateCartTotal(Cart cart) {
        if (cart == null || cart.getItems() == null) {
            return 0.0;
        }
        
        double total = 0.0;
        for (CartProduct item : cart.getItems()) {
            total += item.getSubTotal(); 
        }
        return total;
    }

}