package com.medsystem.model.bo;

import com.medsystem.model.bean.User;
import com.medsystem.model.dao.AuthDAO;

public class AuthBO {
    private AuthDAO authDAO = new AuthDAO();

    public User login(String email, String password) throws Exception {
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            throw new Exception("Email và mật khẩu không được để trống!");
        }
        return authDAO.login(email, password);
    }
    
    public User register(String fullName, String email, String password, String phone, String address) throws Exception {
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            throw new Exception("Email và mật khẩu không được để trống!");
        }	
        return authDAO.register(fullName, email, password, phone, address);
    }
}
