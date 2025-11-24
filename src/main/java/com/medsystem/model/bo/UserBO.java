package com.medsystem.model.bo;

import com.medsystem.model.bean.User;
import com.medsystem.model.dao.UserDAO;

public class UserBO {
    private final UserDAO userDAO = new UserDAO();

    public User getUserById(int id) throws Exception {
        return userDAO.getUserById(id);
    }

    public void updateUser(User user) throws Exception {
        userDAO.updateUser(user);
    }
}
