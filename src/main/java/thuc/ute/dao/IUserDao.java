package thuc.ute.dao;

import java.util.List;

import thuc.ute.entity.User;

public interface IUserDao {

    List<User> findAll();

    User findById(int id);

    void insert(User user);

    User findByUsername(String username);

    boolean checkExistEmail(String email);

    boolean checkExistUsername(String username);

    boolean checkExistPhone(String phone);

    void update(User user);

    User login(String username, String password);

    User findByEmail(String email);

}