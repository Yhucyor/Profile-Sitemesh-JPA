package thuc.ute.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaConfig {

    private static final EntityManagerFactory factory =
            Persistence.createEntityManagerFactory("jpa-crud-unit");

    public static EntityManager getEntityManager() {
        return factory.createEntityManager();
    }
}