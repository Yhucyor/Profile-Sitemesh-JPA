package thuc.ute.service.impl;

import java.util.List;

import thuc.ute.dao.IProductDao;
import thuc.ute.dao.impl.ProductDaoImpl;
import thuc.ute.entity.Product;
import thuc.ute.service.IProductService;

public class ProductServiceImpl implements IProductService {

    private final IProductDao productDao =
            new ProductDaoImpl();

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }

    @Override
    public Product findById(int id) {
        return productDao.findById(id);
    }

    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void update(Product product) {
        productDao.update(product);
    }

    @Override
    public void delete(int id) {
        productDao.delete(id);
    }

    @Override
    public List<Product> findLatest(int limit) {
        return productDao.findLatest(limit);
    }

    @Override
    public List<Product> findAll(int page, int pageSize) {
        return productDao.findAll(page, pageSize);
    }

    @Override
    public int count() {
        return productDao.count();
    }
}