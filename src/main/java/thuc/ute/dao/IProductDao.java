package thuc.ute.dao;

import java.util.List;

import thuc.ute.entity.Product;

public interface IProductDao {

    List<Product> findAll();

    Product findById(int id);

    void insert(Product product);

    void update(Product product);

    void delete(int id);

    List<Product> findLatest(int limit);

    List<Product> findAll(int page, int pageSize);

    int count();
}