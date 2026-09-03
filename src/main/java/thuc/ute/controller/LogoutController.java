package thuc.ute.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import thuc.ute.utils.Constants;

@WebServlet(urlPatterns = {"/logout"})
public class LogoutController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        // 1. Lấy session hiện tại
        HttpSession session =
                req.getSession(false);

        // 2. Hủy session nếu tồn tại
        if (session != null) {

            session.invalidate();
        }

        // 3. Xóa cookie Remember Me
        deleteRememberMe(
                req,
                resp
        );

        // 4. Chuyển về trang login
        resp.sendRedirect(
                req.getContextPath()
                        + "/login"
        );
    }

    /**
     * Xóa cookie Remember Me
     */
    private void deleteRememberMe(
            HttpServletRequest req,
            HttpServletResponse resp) {

        Cookie cookie =
                new Cookie(
                        Constants.COOKIE_REMEMBER,
                        ""
                );

        // Làm cookie hết hạn ngay lập tức
        cookie.setMaxAge(0);

        /*
         * Path phải giống với path
         * lúc tạo cookie trong LoginController
         */
        String contextPath =
                req.getContextPath();

        if (contextPath == null
                || contextPath.isEmpty()) {

            contextPath = "/";
        }

        cookie.setPath(contextPath);

        cookie.setHttpOnly(true);

        resp.addCookie(cookie);
    }
}