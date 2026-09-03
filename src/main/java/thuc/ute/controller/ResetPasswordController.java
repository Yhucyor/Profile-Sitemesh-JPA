package thuc.ute.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import thuc.ute.entity.User;
import thuc.ute.service.IUserService;
import thuc.ute.service.impl.UserServiceImpl;

@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final IUserService userService =
            new UserServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session =
                req.getSession(false);

        if (session == null
                || session.getAttribute("forgotEmail") == null
                || session.getAttribute("resetPasswordAllowed") == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/forgot-password"
            );

            return;
        }

        Boolean allowed =
                (Boolean) session.getAttribute(
                        "resetPasswordAllowed"
                );

        if (!Boolean.TRUE.equals(allowed)) {

            resp.sendRedirect(
                    req.getContextPath() + "/forgot-password"
            );

            return;
        }

        req.getRequestDispatcher(
                "/views/reset-password.jsp"
        ).forward(req, resp);
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session =
                req.getSession(false);

        if (session == null
                || session.getAttribute("forgotEmail") == null
                || session.getAttribute("resetPasswordAllowed") == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/forgot-password"
            );

            return;
        }

        Boolean allowed =
                (Boolean) session.getAttribute(
                        "resetPasswordAllowed"
                );

        if (!Boolean.TRUE.equals(allowed)) {

            resp.sendRedirect(
                    req.getContextPath() + "/forgot-password"
            );

            return;
        }

        String password =
                req.getParameter("password");

        String confirmPassword =
                req.getParameter("confirmPassword");

        if (isBlank(password)
                || isBlank(confirmPassword)) {

            req.setAttribute(
                    "alert",
                    "Vui lòng nhập đầy đủ mật khẩu"
            );

            req.getRequestDispatcher(
                    "/views/reset-password.jsp"
            ).forward(req, resp);

            return;
        }

        if (!password.equals(confirmPassword)) {

            req.setAttribute(
                    "alert",
                    "Mật khẩu xác nhận không khớp"
            );

            req.getRequestDispatcher(
                    "/views/reset-password.jsp"
            ).forward(req, resp);

            return;
        }

        String email =
                (String) session.getAttribute(
                        "forgotEmail"
                );

        User user =
                userService.findByEmail(email);

        if (user == null) {

            session.removeAttribute("forgotEmail");
            session.removeAttribute("resetPasswordAllowed");

            resp.sendRedirect(
                    req.getContextPath() + "/forgot-password"
            );

            return;
        }

        // Cập nhật mật khẩu mới
        user.setPassword(password);

        // OTP đã dùng xong -> xóa
        user.setOtp(null);
        user.setOtpExpiry(null);

        userService.update(user);

        // Xóa session phục vụ reset password
        session.removeAttribute("forgotEmail");
        session.removeAttribute("resetPasswordAllowed");

        session.setAttribute(
                "success",
                "Đổi mật khẩu thành công. Vui lòng đăng nhập."
        );

        resp.sendRedirect(
                req.getContextPath() + "/login"
        );
    }

    private boolean isBlank(String value) {
        return value == null
                || value.trim().isEmpty();
    }
}