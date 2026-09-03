package thuc.ute.controller;

import java.io.IOException;
import java.time.LocalDateTime;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import thuc.ute.entity.User;
import thuc.ute.service.IUserService;
import thuc.ute.service.impl.UserServiceImpl;

@WebServlet("/verify-otp")
public class VerifyOtpController extends HttpServlet {

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
                || session.getAttribute("verifyEmail") == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/register"
            );

            return;
        }

        req.getRequestDispatcher(
                "/views/verify-otp.jsp"
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
                || session.getAttribute("verifyEmail") == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/register"
            );

            return;
        }

        String email =
                (String) session.getAttribute("verifyEmail");

        String otpInput =
                req.getParameter("otp");

        User user =
                userService.findByEmail(email);

        if (user == null) {

            req.setAttribute(
                    "alert",
                    "Không tìm thấy tài khoản"
            );

            req.getRequestDispatcher(
                    "/views/verify-otp.jsp"
            ).forward(req, resp);

            return;
        }

        if (user.getOtp() == null
                || !user.getOtp().equals(otpInput)) {

            req.setAttribute(
                    "alert",
                    "Mã OTP không chính xác"
            );

            req.getRequestDispatcher(
                    "/views/verify-otp.jsp"
            ).forward(req, resp);

            return;
        }

        if (user.getOtpExpiry() == null
                || LocalDateTime.now()
                .isAfter(user.getOtpExpiry())) {

            req.setAttribute(
                    "alert",
                    "Mã OTP đã hết hạn"
            );

            req.getRequestDispatcher(
                    "/views/verify-otp.jsp"
            ).forward(req, resp);

            return;
        }

        // Kích hoạt tài khoản
        user.setActive(true);

        // Xóa OTP sau khi xác nhận thành công
        user.setOtp(null);
        user.setOtpExpiry(null);

        userService.update(user);

        session.removeAttribute("verifyEmail");

        resp.sendRedirect(
                req.getContextPath() + "/login"
        );
    }
}