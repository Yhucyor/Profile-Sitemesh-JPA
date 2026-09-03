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

@WebServlet(urlPatterns = {"/", "/home"})
public class HomeController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final IProductService productService =
            new ProductServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        List<Product> latestProducts =
                productService.findLatest(10);

        req.setAttribute(
                "latestProducts",
                latestProducts
        );

        req.getRequestDispatcher(
                "/views/home.jsp"
        ).forward(req, resp);
    }
}