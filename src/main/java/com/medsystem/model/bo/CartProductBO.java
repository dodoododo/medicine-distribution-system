package com.medsystem.model.bo;

import com.medsystem.model.bean.CartProduct;
import com.medsystem.model.dao.CartProductDAO;

public class CartProductBO {

    private final CartProductDAO cartProductDAO;

    public CartProductBO() {
        this.cartProductDAO = new CartProductDAO();
    }

    // Thêm hoặc cập nhật số lượng sản phẩm trong giỏ
    public boolean addOrUpdateProduct(int cartId, int productId, int quantityChange) {
        try {
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
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật số lượng sản phẩm cụ thể
    public boolean setProductQuantity(int cartId, int productId, int newQuantity) {
        try {
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
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa sản phẩm khỏi giỏ
    public boolean removeProductFromCart(int cartId, int productId) {
        try {
            CartProduct item = cartProductDAO.getByCartAndProduct(cartId, productId);
            if (item != null) {
                return cartProductDAO.delete(item.getId());
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public CartProduct getCartProduct(int cartId, int productId) {
        try {
            return cartProductDAO.getByCartAndProduct(cartId, productId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
