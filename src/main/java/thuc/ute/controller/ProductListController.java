package thuc.ute.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import thuc.ute.entity.Product;
import thuc.ute.service.IProductService;
import thuc.ute.service.impl.ProductServiceImpl;

@WebServlet("/product")
public class ProductListController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final IProductService productService =
            new ProductServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        int page = 1;

        int pageSize = 6;

        String pageParam =
                req.getParameter("page");

        if (pageParam != null
                && !pageParam.isBlank()) {

            try {
                page = Integer.parseInt(pageParam);

            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        if (page < 1) {
            page = 1;
        }

        int totalProducts =
                productService.count();

        int totalPages =
                (int) Math.ceil(
                        (double) totalProducts
                                / pageSize
                );

        if (totalPages > 0
                && page > totalPages) {

            page = totalPages;
        }

        /*
         * DAO đang dùng:
         *
         * setFirstResult(page * pageSize)
         *
         * nên phải truyền:
         *
         * page - 1
         */

        List<Product> products =
                productService.findAll(
                        page - 1,
                        pageSize
                );

        req.setAttribute(
                "products",
                products
        );

        req.setAttribute(
                "currentPage",
                page
        );

        req.setAttribute(
                "totalPages",
                totalPages
        );

        req.setAttribute(
                "totalProducts",
                totalProducts
        );

        req.getRequestDispatcher(
                "/views/product.jsp"
        ).forward(req, resp);
    }
}