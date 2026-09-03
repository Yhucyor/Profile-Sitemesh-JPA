package thuc.ute.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.util.List;

import thuc.ute.config.JpaConfig;
import thuc.ute.dao.IUserDao;
import thuc.ute.entity.User;

public class UserDaoImpl implements IUserDao {

    @Override
    public List<User> findAll() {

        EntityManager em =
                JpaConfig.getEntityManager();

        try {

            return em.createNamedQuery(
                    "User.findAll",
                    User.class
            ).getResultList();

        } finally {

            em.close();
        }
    }

    @Override
    public User findById(int id) {

        EntityManager em =
                JpaConfig.getEntityManager();

        try {

            return em.find(User.class, id);

        } finally {

            em.close();
        }
    }

    @Override
    public void insert(User user) {

        EntityManager em =
                JpaConfig.getEntityManager();

        EntityTransaction transaction =
                em.getTransaction();

        try {

            transaction.begin();

            em.persist(user);

            transaction.commit();

        } catch (Exception e) {

            if (transaction.isActive()) {
                transaction.rollback();
            }

            throw e;

        } finally {

            em.close();
        }
    }

    @Override
    public User findByUsername(String username) {

        EntityManager em =
                JpaConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT u FROM User u "
                            + "WHERE u.username = :username";

            TypedQuery<User> query =
                    em.createQuery(
                            jpql,
                            User.class
                    );

            query.setParameter(
                    "username",
                    username
            );

            return query.getSingleResult();

        } catch (NoResultException e) {

            return null;

        } finally {

            em.close();
        }
    }

    @Override
    public boolean checkExistEmail(String email) {

        EntityManager em =
                JpaConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT COUNT(u) "
                            + "FROM User u "
                            + "WHERE u.email = :email";

            Long count =
                    em.createQuery(
                                    jpql,
                                    Long.class
                            )
                            .setParameter(
                                    "email",
                                    email
                            )
                            .getSingleResult();

            return count > 0;

        } finally {

            em.close();
        }
    }

    @Override
    public boolean checkExistUsername(
            String username) {

        EntityManager em =
                JpaConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT COUNT(u) "
                            + "FROM User u "
                            + "WHERE u.username = :username";

            Long count =
                    em.createQuery(
                                    jpql,
                                    Long.class
                            )
                            .setParameter(
                                    "username",
                                    username
                            )
                            .getSingleResult();

            return count > 0;

        } finally {

            em.close();
        }
    }

    @Override
    public boolean checkExistPhone(
            String phone) {

        EntityManager em =
                JpaConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT COUNT(u) "
                            + "FROM User u "
                            + "WHERE u.phone = :phone";

            Long count =
                    em.createQuery(
                                    jpql,
                                    Long.class
                            )
                            .setParameter(
                                    "phone",
                                    phone
                            )
                            .getSingleResult();

            return count > 0;

        } finally {

            em.close();
        }
    }

    @Override
    public void update(User user) {

        EntityManager em =
                JpaConfig.getEntityManager();

        EntityTransaction transaction =
                em.getTransaction();

        try {
            transaction.begin();

            em.merge(user);

            transaction.commit();

        } catch (Exception e) {

            if (transaction.isActive()) {
                transaction.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }

    @Override
    public User login(String username, String password) {
        return null;
    }

    @Override
    public User findByEmail(String email) {

        EntityManager em =
                JpaConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT u FROM User u "
                            + "WHERE u.email = :email";

            TypedQuery<User> query =
                    em.createQuery(
                            jpql,
                            User.class
                    );

            query.setParameter(
                    "email",
                    email
            );

            return query.getResultStream()
                    .findFirst()
                    .orElse(null);

        } finally {

            em.close();
        }
    }
}