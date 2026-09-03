package thuc.ute.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import thuc.ute.entity.User;
import thuc.ute.service.IUserService;
import thuc.ute.service.impl.UserServiceImpl;

@MultipartConfig
@WebServlet(urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {

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

        // 1. Kiểm tra xem user đã đăng nhập chưa
        if (session == null
                || session.getAttribute("account") == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }

        // 2. Lấy User từ Session
        User loginUser =
                (User) session.getAttribute("account");

        // 3. Đọc lại thông tin User từ database
        //    để chắc chắn lấy dữ liệu mới nhất
        User currentUser =
                userService.findById(
                        loginUser.getId()
                );

        if (currentUser == null) {

            // User không còn tồn tại
            session.invalidate();

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }

        // 4. Đưa thông tin User vào request để hiển thị
        req.setAttribute("user", currentUser);

        // 5. Forward đến trang profile.jsp
        req.getRequestDispatcher(
                "/views/profile.jsp"
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

        // 1. Kiểm tra đăng nhập
        if (session == null
                || session.getAttribute("account") == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }

        // 2. Lấy User từ Session
        User loginUser =
                (User) session.getAttribute("account");

        // 3. Đọc User từ database
        User user =
                userService.findById(
                        loginUser.getId()
                );

        if (user == null) {

            session.invalidate();

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }

        // 4. Lấy dữ liệu từ form
        String fullname =
                req.getParameter("fullname");

        String phone =
                req.getParameter("phone");

        // 5. Cập nhật fullname và phone
        if (fullname != null && !fullname.trim().isEmpty()) {
            user.setFullname(fullname.trim());
        }

        if (phone != null && !phone.trim().isEmpty()) {
            user.setPhone(phone.trim());
        }

        // 6. Xử lý upload avatar
        try {

            Part imagePart =
                    req.getPart("image");

            System.out.println("=== DEBUG AVATAR UPLOAD ===");
            System.out.println("imagePart: " + imagePart);
            
            if (imagePart != null) {
                System.out.println("imagePart.getSize(): " + imagePart.getSize());
                System.out.println("imagePart.getSubmittedFileName(): " + imagePart.getSubmittedFileName());
            }

            if (imagePart != null
                    && imagePart.getSize() > 0) {

                String newAvatar =
                        saveAvatar(imagePart, req);

                System.out.println("newAvatar saved: " + newAvatar);

                if (newAvatar != null) {

                    // Xóa avatar cũ nếu có
                    deleteOldAvatar(
                            user.getAvatar(),
                            req
                    );

                    user.setAvatar(newAvatar);
                    System.out.println("user.getAvatar() after set: " + user.getAvatar());
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            req.setAttribute("error",
                    "Lỗi khi upload ảnh đại diện"
            );

            req.setAttribute("user", user);

            req.getRequestDispatcher(
                    "/views/profile.jsp"
            ).forward(req, resp);

            return;
        }

        // 7. Cập nhật database
        try {

            userService.update(user);

            System.out.println("After database update - user.getAvatar(): " + user.getAvatar());

            // 8. Cập nhật Session
            session.setAttribute("account", user);

            System.out.println("Session updated with new user data");
            System.out.println("=== END DEBUG ===");

            // 9. Thông báo thành công
            req.setAttribute("success",
                    "Cập nhật hồ sơ thành công"
            );

            req.setAttribute("user", user);

            req.getRequestDispatcher(
                    "/views/profile.jsp"
            ).forward(req, resp);

        } catch (Exception e) {

            e.printStackTrace();

            req.setAttribute("error",
                    "Cập nhật hồ sơ thất bại"
            );

            req.setAttribute("user", user);

            req.getRequestDispatcher(
                    "/views/profile.jsp"
            ).forward(req, resp);
        }
    }

    /**
     * Lưu avatar vào thư mục uploads
     */
    private String saveAvatar(
            Part imagePart,
            HttpServletRequest req)
            throws IOException {

        if (imagePart == null
                || imagePart.getSize() == 0) {

            return null;
        }

        String submittedFileName =
                imagePart.getSubmittedFileName();

        if (submittedFileName == null
                || submittedFileName.isBlank()) {

            return null;
        }

        String originalFileName =
                Paths.get(submittedFileName)
                        .getFileName()
                        .toString();

        int dotIndex =
                originalFileName.lastIndexOf(".");

        String extension = "";

        if (dotIndex > 0) {
            extension =
                    originalFileName.substring(dotIndex);
        }

        String fileName =
                System.currentTimeMillis()
                        + extension;

        String uploadPath =
                req.getServletContext()
                        .getRealPath("/assets/uploads");

        File uploadDir =
                new File(uploadPath);

        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        imagePart.write(
                uploadPath
                        + File.separator
                        + fileName
        );

        return fileName;
    }

    /**
     * Xóa avatar cũ
     */
    private void deleteOldAvatar(
            String fileName,
            HttpServletRequest req) {

        if (fileName == null
                || fileName.isBlank()
                || fileName.startsWith("http")) {

            return;
        }

        try {

            String uploadPath =
                    req.getServletContext()
                            .getRealPath("/assets/uploads");

            File oldFile =
                    new File(
                            uploadPath
                                    + File.separator
                                    + fileName
                    );

            if (oldFile.exists()) {
                oldFile.delete();
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}
