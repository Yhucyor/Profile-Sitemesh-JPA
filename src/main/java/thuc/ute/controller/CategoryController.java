package thuc.ute.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import thuc.ute.entity.Category;
import thuc.ute.service.ICategoryService;
import thuc.ute.service.impl.CategoryServiceImpl;

@MultipartConfig
@WebServlet(urlPatterns = {
        "/admin/categories",
        "/admin/category/add",
        "/admin/category/insert",
        "/admin/category/edit",
        "/admin/category/update",
        "/admin/category/delete"
})
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ICategoryService cateService =
            new CategoryServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String url = req.getRequestURI();

        if (url.contains("/admin/categories")) {

            List<Category> list =
                    cateService.findAll();

            req.setAttribute("listcate", list);

            req.getRequestDispatcher(
                    "/views/admin/category/category-list.jsp"
            ).forward(req, resp);

        } else if (url.contains("/admin/category/add")) {

            req.getRequestDispatcher(
                    "/views/admin/category/category-add.jsp"
            ).forward(req, resp);

        } else if (url.contains("/admin/category/edit")) {

            int id =
                    Integer.parseInt(
                            req.getParameter("id")
                    );

            Category category =
                    cateService.findById(id);

            req.setAttribute("cate", category);

            req.getRequestDispatcher(
                    "/views/admin/category/category-edit.jsp"
            ).forward(req, resp);

        } else if (url.contains("/admin/category/delete")) {

            int id =
                    Integer.parseInt(
                            req.getParameter("id")
                    );

            try {

                cateService.delete(id);

            } catch (Exception e) {

                e.printStackTrace();
            }

            resp.sendRedirect(
                    req.getContextPath()
                            + "/admin/categories"
            );
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String url = req.getRequestURI();

        if (url.contains("/admin/category/insert")) {

            insertCategory(req, resp);

        } else if (url.contains("/admin/category/update")) {

            updateCategory(req, resp);
        }
    }

    private void insertCategory(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String categoryname =
                req.getParameter("categoryname");

        int status =
                Integer.parseInt(
                        req.getParameter("status")
                );

        String images =
                req.getParameter("images");

        Category category = new Category();

        category.setCategoryname(categoryname);
        category.setStatus(status);

        String uploadPath =
                getServletContext().getRealPath("/assets/uploads");

        File uploadDir = new File(uploadPath);

        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {

            Part part =
                    req.getPart("images1");

            if (part != null && part.getSize() > 0) {

                String filename =
                        Paths.get(
                                part.getSubmittedFileName()
                        ).getFileName().toString();

                int index =
                        filename.lastIndexOf(".");

                String ext = "";

                if (index > 0) {
                    ext = filename.substring(index + 1);
                }

                String fname =
                        System.currentTimeMillis()
                                + "."
                                + ext;

                part.write(
                        uploadPath
                                + File.separator
                                + fname
                );

                category.setImages(fname);

            } else if (images != null
                    && !images.isBlank()) {

                category.setImages(images);

            } else {

                category.setImages("avatar.png");
            }

        } catch (FileNotFoundException e) {

            e.printStackTrace();
        }

        cateService.insert(category);

        resp.sendRedirect(
                req.getContextPath()
                        + "/admin/categories"
        );
    }

    private void updateCategory(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        int categoryid =
                Integer.parseInt(
                        req.getParameter("categoryid")
                );

        String categoryname =
                req.getParameter("categoryname");

        int status =
                Integer.parseInt(
                        req.getParameter("status")
                );

        String images =
                req.getParameter("images");

        Category category =
                cateService.findById(categoryid);

        if (category == null) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/admin/categories"
            );

            return;
        }

        String oldFile =
                category.getImages();

        category.setCategoryname(categoryname);
        category.setStatus(status);

        String uploadPath =
                getServletContext().getRealPath("/assets/uploads");

        File uploadDir =
                new File(uploadPath);

        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {

            Part part =
                    req.getPart("images1");

            if (part != null && part.getSize() > 0) {

                if (oldFile != null
                        && !oldFile.startsWith("http")) {

                    Path oldPath =
                            Paths.get(
                                    uploadPath,
                                    oldFile
                            );

                    Files.deleteIfExists(oldPath);
                }

                String filename =
                        Paths.get(
                                part.getSubmittedFileName()
                        ).getFileName().toString();

                int index =
                        filename.lastIndexOf(".");

                String ext = "";

                if (index > 0) {
                    ext = filename.substring(index + 1);
                }

                String fname =
                        System.currentTimeMillis()
                                + "."
                                + ext;

                part.write(
                        uploadPath
                                + File.separator
                                + fname
                );

                category.setImages(fname);

            } else if (images != null
                    && !images.isBlank()) {

                category.setImages(images);

            } else {

                category.setImages(oldFile);
            }

        } catch (FileNotFoundException e) {

            e.printStackTrace();
        }

        cateService.update(category);

        resp.sendRedirect(
                req.getContextPath()
                        + "/admin/categories"
        );
    }
}
