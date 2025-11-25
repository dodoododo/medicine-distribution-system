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
    public boolean updateUser(User u) throws SQLException { return dao.updateUser(u); }
    public boolean deleteUser(int id) throws SQLException { return dao.deleteUser(id); }
}
