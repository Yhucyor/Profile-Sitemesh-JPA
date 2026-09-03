package thuc.ute.controller;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import thuc.ute.entity.User;

@WebServlet("/waiting")
public class WaitingController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws IOException {

        HttpSession session =
                req.getSession(false);

        if (session == null
                || session.getAttribute("account") == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }

        User user =
                (User) session.getAttribute("account");

        if (user.getRoleid() == 1) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/admin/categories"
            );

        } else {

            // Tạm thời chưa có trang user riêng
            resp.sendRedirect(
                    req.getContextPath()
                            + "/admin/categories"
            );
        }
    }
}