package thuc.ute.controller;

import java.io.IOException;
import java.time.LocalDate;
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
import thuc.ute.utils.ValidationUtils;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final IUserService userService =
            new UserServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher(
                "/views/register.jsp"
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

        String username =
                req.getParameter("username");

        String fullname =
                req.getParameter("fullname");

        String password =
                req.getParameter("password");

        String confirmPassword =
                req.getParameter("confirmPassword");

        String phone =
                req.getParameter("phone");

        String roleidParam =
                req.getParameter("roleid");

        // 1. Kiểm tra dữ liệu rỗng
        if (isBlank(email)
                || isBlank(username)
                || isBlank(fullname)
                || isBlank(password)
                || isBlank(confirmPassword)
                || isBlank(roleidParam)) {

            req.setAttribute(
                    "alert",
                    "Vui lòng nhập đầy đủ thông tin bắt buộc"
            );

            req.getRequestDispatcher(
                    "/views/register.jsp"
            ).forward(req, resp);

            return;
        }

        // Parse roleid
        int roleid;
        try {
            roleid = Integer.parseInt(roleidParam);
        } catch (NumberFormatException e) {
            req.setAttribute(
                    "alert",
                    "Vai trò không hợp lệ"
            );

            req.getRequestDispatcher(
                    "/views/register.jsp"
            ).forward(req, resp);

            return;
        }

        // 2. Validate email format
        if (!ValidationUtils.isValidEmail(email)) {
            req.setAttribute(
                    "alert",
                    "Email không hợp lệ"
            );

            req.getRequestDispatcher(
                    "/views/register.jsp"
            ).forward(req, resp);

            return;
        }

        // 3. Validate username format
        if (!ValidationUtils.isValidUsername(username)) {
            req.setAttribute(
                    "alert",
                    "Tên đăng nhập phải từ 3-50 ký tự và chỉ chứa chữ, số, dấu gạch dưới"
            );

            req.getRequestDispatcher(
                    "/views/register.jsp"
            ).forward(req, resp);

            return;
        }

        // 4. Validate fullname
        if (!ValidationUtils.isValidFullname(fullname)) {
            req.setAttribute(
                    "alert",
                    "Họ tên phải từ 3-100 ký tự"
            );

            req.getRequestDispatcher(
                    "/views/register.jsp"
            ).forward(req, resp);

            return;
        }

        // 5. Validate password
        if (!ValidationUtils.isValidPassword(password)) {
            req.setAttribute(
                    "alert",
                    "Mật khẩu phải có ít nhất 6 ký tự"
            );

            req.getRequestDispatcher(
                    "/views/register.jsp"
            ).forward(req, resp);

            return;
        }

        // 6. Validate phone (if provided)
        if (!ValidationUtils.isValidPhone(phone)) {
            req.setAttribute(
                    "alert",
                    "Số điện thoại không hợp lệ (phải là 10-11 số, bắt đầu bằng 0)"
            );

            req.getRequestDispatcher(
                    "/views/register.jsp"
            ).forward(req, resp);

            return;
        }

        // 7. Validate roleid
        if (!ValidationUtils.isValidRoleId(roleid)) {
            req.setAttribute(
                    "alert",
                    "Vai trò không hợp lệ"
            );

            req.getRequestDispatcher(
                    "/views/register.jsp"
            ).forward(req, resp);

            return;
        }

        // 8. Kiểm tra xác nhận mật khẩu
        if (!password.equals(confirmPassword)) {

            req.setAttribute(
                    "alert",
                    "Mật khẩu xác nhận không khớp"
            );

            req.getRequestDispatcher(
                    "/views/register.jsp"
            ).forward(req, resp);

            return;
        }

        // 9. Kiểm tra email đã tồn tại
        if (userService.checkExistEmail(email.trim())) {

            req.setAttribute(
                    "alert",
                    "Email đã tồn tại"
            );

            req.getRequestDispatcher(
                    "/views/register.jsp"
            ).forward(req, resp);

            return;
        }

        // 10. Kiểm tra username đã tồn tại
        if (userService.checkExistUsername(username.trim())) {

            req.setAttribute(
                    "alert",
                    "Tên đăng nhập đã tồn tại"
            );

            req.getRequestDispatcher(
                    "/views/register.jsp"
            ).forward(req, resp);

            return;
        }

        // 11. Kiểm tra phone đã tồn tại (nếu user có nhập)
        if (!isBlank(phone)
                && userService.checkExistPhone(phone.trim())) {

            req.setAttribute(
                    "alert",
                    "Số điện thoại đã tồn tại"
            );

            req.getRequestDispatcher(
                    "/views/register.jsp"
            ).forward(req, resp);

            return;
        }

        // 12. Sinh OTP
        String otp =
                OtpUtil.generateOtp();

        // 13. Tạo User (trim all inputs)
        User user = new User();

        user.setEmail(email.trim());
        user.setUsername(username.trim());
        user.setFullname(fullname.trim());
        user.setPassword(password);
        user.setPhone(phone != null ? phone.trim() : null);

        user.setRoleid(roleid);
        user.setCreatedDate(LocalDate.now());

        // Chưa kích hoạt
        user.setActive(false);

        user.setOtp(otp);

        // OTP hết hạn sau 5 phút
        user.setOtpExpiry(
                LocalDateTime.now().plusMinutes(5)
        );

        try {

            // 8. Lưu User
            userService.insert(user);

            // 9. Gửi OTP
            EmailUtils.sendOtp(
                    email,
                    otp
            );

            // 10. Lưu email tạm để Verify OTP biết user nào
            req.getSession()
                    .setAttribute(
                            "verifyEmail",
                            email
                    );

            resp.sendRedirect(
                    req.getContextPath()
                            + "/verify-otp"
            );

        } catch (MessagingException e) {

            e.printStackTrace();

            req.setAttribute(
                    "alert",
                    "Không thể gửi OTP qua email"
            );

            req.getRequestDispatcher(
                    "/views/register.jsp"
            ).forward(req, resp);

        } catch (Exception e) {

            e.printStackTrace();

            req.setAttribute(
                    "alert",
                    "Đăng ký tài khoản thất bại"
            );

            req.getRequestDispatcher(
                    "/views/register.jsp"
            ).forward(req, resp);
        }
    }

    private boolean isBlank(String value) {
        return value == null
                || value.trim().isEmpty();
    }
}