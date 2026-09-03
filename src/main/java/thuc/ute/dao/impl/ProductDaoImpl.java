package thuc.ute.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import jakarta.persistence.TypedQuery;
import thuc.ute.config.JpaConfig;
import thuc.ute.dao.IProductDao;
import thuc.ute.entity.Product;

public class ProductDaoImpl implements IProductDao {

    @Override
    public List<Product> findAll() {

        EntityManager em =
                JpaConfig.getEntityManager();

        try {

            return em.createNamedQuery(
                    "Product.findAll",
                    Product.class
            ).getResultList();

        } finally {

            em.close();
        }
    }

    @Override
    public Product findById(int id) {

        EntityManager em =
                JpaConfig.getEntityManager();

        try {

            return em.find(
                    Product.class,
                    id
            );

        } finally {

            em.close();
        }
    }

    @Override
    public void insert(Product product) {

        EntityManager em =
                JpaConfig.getEntityManager();

        EntityTransaction transaction =
                em.getTransaction();

        try {

            transaction.begin();

            em.persist(product);

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
    public void update(Product product) {

        EntityManager em =
                JpaConfig.getEntityManager();

        EntityTransaction transaction =
                em.getTransaction();

        try {

            transaction.begin();

            em.merge(product);

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
    public void delete(int id) {

        EntityManager em =
                JpaConfig.getEntityManager();

        EntityTransaction transaction =
                em.getTransaction();

        try {

            transaction.begin();

            Product product =
                    em.find(
                            Product.class,
                            id
                    );

            if (product != null) {
                em.remove(product);
            }

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
    public List<Product> findLatest(int limit) {

        EntityManager em = JpaConfig.getEntityManager();

        try {

            TypedQuery<Product> query = em.createQuery(
                    "SELECT p FROM Product p " +
                            "ORDER BY p.createdDate DESC",
                    Product.class
            );

            query.setMaxResults(limit);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findAll(int page, int pageSize) {

        EntityManager em = JpaConfig.getEntityManager();

        try {

            TypedQuery<Product> query = em.createQuery(
                    "SELECT p FROM Product p " +
                            "ORDER BY p.createdDate DESC",
                    Product.class
            );

            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    @Override
    public int count() {

        EntityManager em = JpaConfig.getEntityManager();

        try {

            Long total = em.createQuery(
                    "SELECT COUNT(p) FROM Product p",
                    Long.class
            ).getSingleResult();

            return total.intValue();

        } finally {
            em.close();
        }
    }
}