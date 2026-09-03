package thuc.ute.service.impl;

import java.time.LocalDate;
import java.util.List;

import thuc.ute.dao.IUserDao;
import thuc.ute.dao.impl.UserDaoImpl;
import thuc.ute.entity.User;
import thuc.ute.service.IUserService;

public class UserServiceImpl
        implements IUserService {

    private final IUserDao userDao =
            new UserDaoImpl();

    @Override
    public List<User> findAll() {

        return userDao.findAll();
    }

    @Override
    public User findById(int id) {

        return userDao.findById(id);
    }

    @Override
    public User login(
            String username,
            String password) {

        User user =
                userDao.findByUsername(username);

        if (user == null) {
            return null;
        }

        if (!user.isActive()) {
            return null;
        }

        if (!user.getPassword().equals(password)) {
            return null;
        }

        return user;
    }
    @Override
    public User findByUsername(
            String username) {

        return userDao
                .findByUsername(username);
    }

    @Override
    public void insert(User user) {

        userDao.insert(user);
    }

    @Override
    public boolean register(
            String username,
            String password,
            String email,
            String fullname,
            String phone) {

        return register(
                username,
                password,
                email,
                fullname,
                phone,
                5
        );
    }

    @Override
    public boolean register(
            String username,
            String password,
            String email,
            String fullname,
            String phone,
            int roleid) {

        if (userDao
                .checkExistUsername(username)) {

            return false;
        }

        if (userDao
                .checkExistEmail(email)) {

            return false;
        }

        if (userDao
                .checkExistPhone(phone)) {

            return false;
        }

        User user =
                new User();

        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setFullname(fullname);
        user.setPhone(phone);

        user.setRoleid(roleid);

        user.setAvatar(null);

        user.setCreatedDate(
                LocalDate.now()
        );

        userDao.insert(user);

        return true;
    }

    @Override
    public boolean checkExistEmail(
            String email) {

        return userDao
                .checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(
            String username) {

        return userDao
                .checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(
            String phone) {

        return userDao
                .checkExistPhone(phone);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }
}