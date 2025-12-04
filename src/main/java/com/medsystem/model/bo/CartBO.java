package com.medsystem.model.bo;

import com.medsystem.model.bean.Cart;
import com.medsystem.model.bean.CartProduct;
import com.medsystem.model.dao.CartDAO;
import java.util.List;

public class CartBO {

    private final CartDAO cartDAO;
    private final CartProductBO cartProductBO;

    public CartBO() {
        this.cartDAO = new CartDAO();
        this.cartProductBO = new CartProductBO(); // thêm BO để thao tác sản phẩm
    }

    public Cart getCartByUserId(int userId) {
        Cart cart = cartDAO.getCartByUserId(userId);
        if (cart != null) {
            List<CartProduct> items = cartDAO.getCartProductsByCartId(cart.getId());
            cart.setItems(items);
        }
        return cart;
    }

    // Thêm wrapper để xóa sản phẩm qua CartProductBO
    public boolean removeProductFromCart(int cartId, int productId) {
        return cartProductBO.removeProductFromCart(cartId, productId);
    }

    // Thêm wrapper nếu cần set số lượng
    public boolean setProductQuantity(int cartId, int productId, int quantity) {
        return cartProductBO.setProductQuantity(cartId, productId, quantity);
    }

    // Thêm wrapper để add/update
    public boolean addOrUpdateProduct(int cartId, int productId, int quantityChange) {
        return cartProductBO.addOrUpdateProduct(cartId, productId, quantityChange);
    }

    // Lấy CartProduct riêng
    public CartProduct getCartProduct(int cartId, int productId) {
        return cartProductBO.getCartProduct(cartId, productId);
    }
}
