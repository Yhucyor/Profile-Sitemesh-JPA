package thuc.ute.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

import thuc.ute.config.JpaConfig;
import thuc.ute.dao.ICategoryDao;
import thuc.ute.entity.Category;

public class CategoryDao implements ICategoryDao {

    @Override
    public void insert(Category category) {

        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {

            transaction.begin();

            // Thêm mới Category vào database
            em.persist(category);

            transaction.commit();

        } catch (Exception e) {

            e.printStackTrace();

            if (transaction.isActive()) {
                transaction.rollback();
            }

            throw e;

        } finally {

            em.close();
        }
    }


    @Override
    public void update(Category category) {

        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {

            transaction.begin();

            // Cập nhật Category
            em.merge(category);

            transaction.commit();

        } catch (Exception e) {

            e.printStackTrace();

            if (transaction.isActive()) {
                transaction.rollback();
            }

            throw e;

        } finally {

            em.close();
        }
    }


    @Override
    public void delete(int cateid) throws Exception {

        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {

            transaction.begin();

            // Tìm Category theo ID trước
            Category category = em.find(Category.class, cateid);

            if (category != null) {

                // Xóa Category
                em.remove(category);

            } else {

                throw new Exception("Không tìm thấy Category");
            }

            transaction.commit();

        } catch (Exception e) {

            e.printStackTrace();

            if (transaction.isActive()) {
                transaction.rollback();
            }

            throw e;

        } finally {

            em.close();
        }
    }


    @Override
    public Category findById(int cateid) {

        EntityManager em = JpaConfig.getEntityManager();

        try {

            return em.find(Category.class, cateid);

        } finally {

            em.close();
        }
    }


    @Override
    public Category findByCategoryname(String name) throws Exception {

        EntityManager em = JpaConfig.getEntityManager();

        String jpql =
                "SELECT c FROM Category c " +
                        "WHERE c.categoryname = :catename";

        try {

            TypedQuery<Category> query =
                    em.createQuery(jpql, Category.class);

            query.setParameter("catename", name);

            List<Category> result = query.getResultList();

            if (result.isEmpty()) {
                return null;
            }

            return result.get(0);

        } finally {

            em.close();
        }
    }


    @Override
    public List<Category> findAll() {

        EntityManager em = JpaConfig.getEntityManager();

        try {

            TypedQuery<Category> query =
                    em.createNamedQuery(
                            "Category.findAll",
                            Category.class
                    );

            return query.getResultList();

        } finally {

            em.close();
        }
    }


    @Override
    public List<Category> searchByName(String catname) {

        EntityManager em = JpaConfig.getEntityManager();

        String jpql =
                "SELECT c FROM Category c " +
                        "WHERE c.categoryname LIKE :catename";

        try {

            TypedQuery<Category> query =
                    em.createQuery(jpql, Category.class);

            query.setParameter(
                    "catename",
                    "%" + catname + "%"
            );

            return query.getResultList();

        } finally {

            em.close();
        }
    }


    @Override
    public List<Category> findAll(int page, int pagesize) {

        EntityManager em = JpaConfig.getEntityManager();

        try {

            TypedQuery<Category> query =
                    em.createNamedQuery(
                            "Category.findAll",
                            Category.class
                    );

            query.setFirstResult(page * pagesize);
            query.setMaxResults(pagesize);

            return query.getResultList();

        } finally {

            em.close();
        }
    }


    @Override
    public int count() {

        EntityManager em = JpaConfig.getEntityManager();

        try {

            String jpql =
                    "SELECT COUNT(c) FROM Category c";

            Query query = em.createQuery(jpql);

            Long result = (Long) query.getSingleResult();

            return result.intValue();

        } finally {

            em.close();
        }
    }
}