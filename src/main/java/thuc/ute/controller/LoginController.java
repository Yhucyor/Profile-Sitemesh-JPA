package thuc.ute.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import thuc.ute.entity.User;
import thuc.ute.service.IUserService;
import thuc.ute.service.impl.UserServiceImpl;
import thuc.ute.utils.Constants;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final IUserService userService =
            new UserServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        // 1. Kiểm tra nếu user đã đăng nhập rồi
        HttpSession session =
                req.getSession(false);

        if (session != null
                && session.getAttribute("account") != null) {

            resp.sendRedirect(
                    req.getContextPath() + "/waiting"
            );

            return;
        }

        // 2. Kiểm tra cookie Remember Me
        Cookie[] cookies =
                req.getCookies();

        if (cookies != null) {

            for (Cookie cookie : cookies) {

                if (Constants.COOKIE_REMEMBER
                        .equals(cookie.getName())) {

                    String username =
                            cookie.getValue();

                    User rememberedUser =
                            userService.findByUsername(username);

                    // Chỉ tự động login nếu tài khoản đã kích hoạt
                    if (rememberedUser != null
                            && rememberedUser.isActive()) {

                        session =
                                req.getSession(true);

                        session.setAttribute(
                                "account",
                                rememberedUser
                        );

                        resp.sendRedirect(
                                req.getContextPath()
                                        + "/waiting"
                        );

                        return;
                    }
                }
            }
        }

        // 3. Chưa login -> mở trang login.jsp
        req.getRequestDispatcher(
                Constants.LOGIN
        ).forward(req, resp);
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType(
                "text/html; charset=UTF-8"
        );

        // 2. Lấy dữ liệu từ form
        String username =
                req.getParameter("username");

        String password =
                req.getParameter("password");

        // Hỗ trợ form cũ nếu dùng uname/psw
        if (isBlank(username)) {
            username =
                    req.getParameter("uname");
        }

        if (isBlank(password)) {
            password =
                    req.getParameter("psw");
        }

        boolean isRememberMe =
                "on".equals(
                        req.getParameter("remember")
                );

        // 3. Kiểm tra rỗng
        if (isBlank(username)
                || isBlank(password)) {

            req.setAttribute(
                    "alert",
                    "Tài khoản hoặc mật khẩu không được để trống"
            );

            req.getRequestDispatcher(
                    Constants.LOGIN
            ).forward(req, resp);

            return;
        }

        // 4. Validate username length
        if (username.trim().length() < 3) {

            req.setAttribute(
                    "alert",
                    "Tên đăng nhập phải có ít nhất 3 ký tự"
            );

            req.getRequestDispatcher(
                    Constants.LOGIN
            ).forward(req, resp);

            return;
        }

        // 5. Validate password length
        if (password.length() < 6) {

            req.setAttribute(
                    "alert",
                    "Mật khẩu phải có ít nhất 6 ký tự"
            );

            req.getRequestDispatcher(
                    Constants.LOGIN
            ).forward(req, resp);

            return;
        }

        // 6. Gọi Service kiểm tra login
        User user =
                userService.login(
                        username.trim(),
                        password
                );

        // 7. Login thành công
        if (user != null) {

            HttpSession session =
                    req.getSession(true);

            session.setAttribute(
                    "account",
                    user
            );

            if (isRememberMe) {
                saveRememberMe(
                        resp,
                        username.trim()
                );
            }

            resp.sendRedirect(
                    req.getContextPath()
                            + "/waiting"
            );

            return;
        }

        // 8. Login thất bại
        req.setAttribute(
                "alert",
                "Tài khoản hoặc mật khẩu không đúng hoặc tài khoản chưa được kích hoạt"
        );

        req.getRequestDispatcher(
                Constants.LOGIN
        ).forward(req, resp);
    }

    private void saveRememberMe(
            HttpServletResponse resp,
            String username) {

        Cookie cookie =
                new Cookie(
                        Constants.COOKIE_REMEMBER,
                        username
                );

        // Cookie tồn tại 30 phút
        cookie.setMaxAge(30 * 60);

        resp.addCookie(cookie);
    }

    private boolean isBlank(String value) {

        return value == null
                || value.trim().isEmpty();
    }
}