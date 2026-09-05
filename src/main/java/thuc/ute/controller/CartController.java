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

@WebServlet("/cart")
public class CartController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final IProductService productService =
            new ProductServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        List<Product> cartProducts =
                productService.findLatest(2);

        double cartTotal = 0;

        for (Product product : cartProducts) {
            cartTotal += product.getPrice();
        }

        req.setAttribute(
                "cartProducts",
                cartProducts
        );

        req.setAttribute(
                "cartTotal",
                cartTotal
        );

        req.setAttribute(
                "breadcrumbTitle",
                "Cart"
        );

        req.getRequestDispatcher(
                "/views/cart.jsp"
        ).forward(req, resp);
    }
}
