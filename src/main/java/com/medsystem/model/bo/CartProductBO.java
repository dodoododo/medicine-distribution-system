package com.medsystem.model.bo;

import com.medsystem.model.bean.CartProduct;
import com.medsystem.model.dao.CartProductDAO;

public class CartProductBO {
    
    private CartProductDAO cartProductDAO;

    public CartProductBO() {
        this.cartProductDAO = new CartProductDAO();
    }

    public boolean addOrUpdateProduct(int cartId, int productId, int quantityChange) {
        CartProduct existingItem = cartProductDAO.getByCartAndProduct(cartId, productId);
        
        if (existingItem != null) {
            int newQuantity = existingItem.getQuantity() + quantityChange;
            
            if (newQuantity <= 0) {
                return cartProductDAO.delete(existingItem.getId());
            }
            existingItem.setQuantity(newQuantity);
            return cartProductDAO.addOrUpdate(existingItem);
        } else {
            if (quantityChange > 0) {
                CartProduct newItem = new CartProduct(cartId, productId, quantityChange);
                return cartProductDAO.add(newItem);
            }
            return true; 
        }
    }

    public boolean setProductQuantity(int cartId, int productId, int newQuantity) {
        if (newQuantity <= 0) {
            CartProduct item = cartProductDAO.getByCartAndProduct(cartId, productId);
            if (item != null) {
                return cartProductDAO.delete(item.getId());
            }
            return true; 
        }
        
        CartProduct existingItem = cartProductDAO.getByCartAndProduct(cartId, productId);
        
        if (existingItem != null) {
            existingItem.setQuantity(newQuantity);
            return cartProductDAO.addOrUpdate(existingItem);
        } else {
            CartProduct newItem = new CartProduct(cartId, productId, newQuantity);
            return cartProductDAO.add(newItem);
        }
    }

    public boolean removeProductFromCart(int cartId, int productId) {
        CartProduct item = cartProductDAO.getByCartAndProduct(cartId, productId);
        if (item != null) {
            return cartProductDAO.delete(item.getId());
        }
        return true; 
    }
}