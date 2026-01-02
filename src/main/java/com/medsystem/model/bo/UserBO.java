package com.medsystem.model.bo;

import com.medsystem.model.bean.User;
import com.medsystem.model.dao.UserDAO;

import java.sql.SQLException;
import java.util.List;

public class UserBO {
    private final UserDAO dao = new UserDAO();

    public List<User> getAllUsers() throws SQLException { return dao.getAllUsers(); }
    public User getUserById(int id) throws SQLException { return dao.getUserById(id); }
    public boolean addUser(User u) throws SQLException { return dao.addUser(u); }

    public boolean updateUserInfo(User u) throws SQLException {
        return dao.updateUserInfo(u);
    }

    public boolean updatePassword(int id, String newPassword) throws SQLException {
        return dao.updatePassword(id, newPassword);
    }
    public boolean deleteUser(int id) throws SQLException { return dao.deleteUser(id); }
}
