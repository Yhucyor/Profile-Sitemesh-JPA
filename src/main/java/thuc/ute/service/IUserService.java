package thuc.ute.service;

import java.util.List;

import thuc.ute.entity.User;

public interface IUserService {

    List<User> findAll();

    User findById(int id);

    User login(
            String username,
            String password
    );

    User findByUsername(
            String username
    );

    void insert(User user);

    boolean register(
            String username,
            String password,
            String email,
            String fullname,
            String phone
    );

    boolean register(
            String username,
            String password,
            String email,
            String fullname,
            String phone,
            int roleid
    );

    boolean checkExistEmail(
            String email
    );

    boolean checkExistUsername(
            String username
    );

    boolean checkExistPhone(
            String phone
    );

    void update(User user);

    User findByEmail(String email);
}