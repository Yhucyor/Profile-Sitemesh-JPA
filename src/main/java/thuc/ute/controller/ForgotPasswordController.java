package thuc.ute.controller;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import thuc.ute.entity.User;
import thuc.ute.service.IUserService;
import thuc.ute.service.impl.UserServiceImpl;
import thuc.ute.utils.EmailUtils;
import thuc.ute.utils.OtpUtil;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final IUserService userService =
            new UserServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher(
                "/views/forgot-password.jsp"
        ).forward(req, resp);
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String email =
                req.getParameter("email");

        // 1. Kiểm tra email rỗng
        if (email == null
                || email.trim().isEmpty()) {

            req.setAttribute(
                    "alert",
                    "Vui lòng nhập email"
            );

            req.getRequestDispatcher(
                    "/views/forgot-password.jsp"
            ).forward(req, resp);

            return;
        }

        // 2. Tìm user theo email
        User user =
                userService.findByEmail(
                        email.trim()
                );

        if (user == null) {

            req.setAttribute(
                    "alert",
                    "Email không tồn tại trong hệ thống"
            );

            req.getRequestDispatcher(
                    "/views/forgot-password.jsp"
            ).forward(req, resp);

            return;
        }

        // 3. Kiểm tra OTP cũ còn hiệu lực hay không
        if (user.getOtp() != null
                && user.getOtpExpiry() != null
                && LocalDateTime.now()
                .isBefore(user.getOtpExpiry())) {

            long secondsLeft =
                    Duration.between(
                            LocalDateTime.now(),
                            user.getOtpExpiry()
                    ).getSeconds();

            long minutesLeft =
                    secondsLeft / 60;

            long remainSeconds =
                    secondsLeft % 60;

            req.setAttribute(
                    "alert",
                    "Mã OTP đã được gửi. "
                            + "Vui lòng chờ "
                            + minutesLeft
                            + " phút "
                            + remainSeconds
                            + " giây trước khi yêu cầu mã mới."
            );

            req.getRequestDispatcher(
                    "/views/forgot-password.jsp"
            ).forward(req, resp);

            return;
        }

        // 4. OTP cũ hết hạn -> sinh OTP mới
        String otp =
                OtpUtil.generateOtp();

        // 5. Lưu OTP mới
        user.setOtp(otp);

        // OTP có hiệu lực 5 phút
        user.setOtpExpiry(
                LocalDateTime.now()
                        .plusMinutes(5)
        );

        userService.update(user);

        try {

            // 6. Gửi OTP qua email
            EmailUtils.sendOtp(
                    user.getEmail(),
                    otp
            );

            // 7. Lưu email vào session
            // để controller xác nhận OTP biết user nào
            req.getSession()
                    .setAttribute(
                            "forgotEmail",
                            user.getEmail()
                    );

            // 8. Chuyển sang trang nhập OTP
            resp.sendRedirect(
                    req.getContextPath()
                            + "/forgot-password/verify"
            );

        } catch (MessagingException e) {

            e.printStackTrace();

            req.setAttribute(
                    "alert",
                    "Không thể gửi mã OTP qua email"
            );

            req.getRequestDispatcher(
                    "/views/forgot-password.jsp"
            ).forward(req, resp);
        }
    }
}