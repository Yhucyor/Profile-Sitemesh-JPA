package thuc.ute.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import thuc.ute.entity.Product;
import thuc.ute.service.IProductService;
import thuc.ute.service.impl.ProductServiceImpl;

@WebServlet("/product/detail")
public class ProductDetailController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final IProductService productService =
            new ProductServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam =
                req.getParameter("id");

        if (idParam == null || idParam.isBlank()) {
            resp.sendRedirect(
                    req.getContextPath() + "/product"
            );

            return;
        }

        int productId;

        try {
            productId =
                    Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            resp.sendRedirect(
                    req.getContextPath() + "/product"
            );

            return;
        }

        Product product =
                productService.findById(productId);

        if (product == null) {
            resp.sendRedirect(
                    req.getContextPath() + "/product"
            );

            return;
        }

        req.setAttribute(
                "product",
                product
        );

        req.setAttribute(
                "breadcrumbTitle",
                product.getProductName()
        );

        req.setAttribute(
                "breadcrumbParentLabel",
                "Products"
        );

        req.setAttribute(
                "breadcrumbParentUrl",
                req.getContextPath() + "/product"
        );

        req.getRequestDispatcher(
                "/views/product-detail.jsp"
        ).forward(req, resp);
    }
}
