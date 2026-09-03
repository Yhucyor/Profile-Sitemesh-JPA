package thuc.ute.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import thuc.ute.entity.Category;
import thuc.ute.entity.Product;
import thuc.ute.service.ICategoryService;
import thuc.ute.service.IProductService;
import thuc.ute.service.impl.CategoryServiceImpl;
import thuc.ute.service.impl.ProductServiceImpl;

@MultipartConfig
@WebServlet(urlPatterns = {
        "/admin/products",
        "/admin/product/add",
        "/admin/product/insert",
        "/admin/product/edit",
        "/admin/product/update",
        "/admin/product/delete"
})
public class ProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final IProductService productService =
            new ProductServiceImpl();

    private final ICategoryService categoryService =
            new CategoryServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String url =
                req.getRequestURI();

        if (url.contains("/admin/products")) {
            showProductList(req, resp);
        } else if (url.contains("/admin/product/add")) {
            showAddForm(req, resp);
        } else if (url.contains("/admin/product/edit")) {
            showEditForm(req, resp);
        } else if (url.contains("/admin/product/delete")) {
            deleteProduct(req, resp);
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String url =
                req.getRequestURI();

        if (url.contains("/admin/product/insert")) {
            insertProduct(req, resp);
        } else if (url.contains("/admin/product/update")) {
            updateProduct(req, resp);
        }
    }

    private void showProductList(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        List<Product> products =
                productService.findAll();

        req.setAttribute("listProduct", products);

        req.getRequestDispatcher(
                "/views/admin/product/product-list.jsp"
        ).forward(req, resp);
    }

    private void showAddForm(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        List<Category> categories =
                categoryService.findAll();

        req.setAttribute("listCategory", categories);

        req.getRequestDispatcher(
                "/views/admin/product/product-add.jsp"
        ).forward(req, resp);
    }

    private void insertProduct(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws IOException, ServletException {

        String productName =
                req.getParameter("productName");

        double price =
                Double.parseDouble(
                        req.getParameter("price")
                );

        int quantity =
                Integer.parseInt(
                        req.getParameter("quantity")
                );

        String description =
                req.getParameter("description");

        int status =
                Integer.parseInt(
                        req.getParameter("status")
                );

        int categoryId =
                Integer.parseInt(
                        req.getParameter("categoryId")
                );

        Category category =
                categoryService.findById(categoryId);

        Product product =
                new Product();

        product.setProductName(productName);
        product.setPrice(price);
        product.setQuantity(quantity);
        product.setDescription(description);
        product.setStatus(status);
        product.setCreatedDate(LocalDateTime.now());
        product.setCategory(category);

        Part imagePart =
                req.getPart("imageFile");

        product.setImage(
                saveImage(imagePart)
        );

        productService.insert(product);

        resp.sendRedirect(
                req.getContextPath()
                        + "/admin/products"
        );
    }

    private void showEditForm(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        int productId =
                Integer.parseInt(
                        req.getParameter("id")
                );

        Product product =
                productService.findById(productId);

        List<Category> categories =
                categoryService.findAll();

        req.setAttribute("product", product);
        req.setAttribute("listCategory", categories);

        req.getRequestDispatcher(
                "/views/admin/product/product-edit.jsp"
        ).forward(req, resp);
    }

    private void updateProduct(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws IOException, ServletException {

        int productId =
                Integer.parseInt(
                        req.getParameter("productId")
                );

        String productName =
                req.getParameter("productName");

        double price =
                Double.parseDouble(
                        req.getParameter("price")
                );

        int quantity =
                Integer.parseInt(
                        req.getParameter("quantity")
                );

        String description =
                req.getParameter("description");

        int status =
                Integer.parseInt(
                        req.getParameter("status")
                );

        int categoryId =
                Integer.parseInt(
                        req.getParameter("categoryId")
                );

        Product product =
                productService.findById(productId);

        if (product != null) {
            Category category =
                    categoryService.findById(categoryId);

            product.setProductName(productName);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setDescription(description);
            product.setStatus(status);
            product.setCategory(category);

            Part imagePart =
                    req.getPart("imageFile");

            String newImage =
                    saveImage(imagePart);

            if (newImage != null) {
                deleteImage(product.getImage());
                product.setImage(newImage);
            }

            productService.update(product);
        }

        resp.sendRedirect(
                req.getContextPath()
                        + "/admin/products"
        );
    }

    private void deleteProduct(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws IOException {

        int productId =
                Integer.parseInt(
                        req.getParameter("id")
                );

        Product product =
                productService.findById(productId);

        if (product != null) {
            deleteImage(product.getImage());
        }

        productService.delete(productId);

        resp.sendRedirect(
                req.getContextPath()
                        + "/admin/products"
        );
    }

    private String saveImage(Part imagePart)
            throws IOException {

        if (imagePart == null || imagePart.getSize() == 0) {
            return null;
        }

        String submittedFileName =
                imagePart.getSubmittedFileName();

        if (submittedFileName == null || submittedFileName.isBlank()) {
            return null;
        }

        String originalFileName =
                Paths.get(submittedFileName)
                        .getFileName()
                        .toString();

        int dotIndex =
                originalFileName.lastIndexOf(".");

        String extension = "";

        if (dotIndex > 0) {
            extension =
                    originalFileName.substring(dotIndex);
        }

        String fileName =
                System.currentTimeMillis()
                        + extension;

        String uploadPath =
                getServletContext().getRealPath("/assets/uploads");

        File uploadDir =
                new File(uploadPath);

        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        imagePart.write(
                uploadPath
                        + File.separator
                        + fileName
        );

        return fileName;
    }

    private void deleteImage(String fileName)
            throws IOException {

        if (fileName == null || fileName.isBlank()) {
            return;
        }

        Path imagePath =
                Paths.get(
                        getServletContext().getRealPath("/assets/uploads"),
                        fileName
                );

        Files.deleteIfExists(imagePath);
    }
}
