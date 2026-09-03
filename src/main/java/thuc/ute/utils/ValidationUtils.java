package thuc.ute.utils;

import jakarta.servlet.http.Part;

import java.util.regex.Pattern;

public class ValidationUtils {

    private ValidationUtils() {
        // Utility class
    }

    // Email validation
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile(
                    "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
            );

    // Username validation (alphanumeric + underscore)
    private static final Pattern USERNAME_PATTERN =
            Pattern.compile("^[a-zA-Z0-9_]{3,50}$");

    // Phone validation (10-11 digits, start with 0)
    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^0[0-9]{9,10}$");

    // Allowed image extensions
    private static final String[] ALLOWED_IMAGE_TYPES = {
            "image/jpeg",
            "image/jpg",
            "image/png",
            "image/gif"
    };

    // Max file size: 5MB
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024;

    /**
     * Kiểm tra email hợp lệ
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    /**
     * Kiểm tra username hợp lệ
     * - Độ dài: 3-50 ký tự
     * - Chỉ chứa chữ, số và dấu gạch dưới
     */
    public static boolean isValidUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }
        return USERNAME_PATTERN.matcher(username.trim()).matches();
    }

    /**
     * Kiểm tra password hợp lệ
     * - Độ dài tối thiểu: 6 ký tự
     */
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }

    /**
     * Kiểm tra phone hợp lệ
     * - Format: 0xxxxxxxxx (10-11 số)
     */
    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return true; // Phone là optional
        }
        return PHONE_PATTERN.matcher(phone.trim()).matches();
    }

    /**
     * Kiểm tra fullname hợp lệ
     * - Độ dài: 3-100 ký tự
     */
    public static boolean isValidFullname(String fullname) {
        if (fullname == null || fullname.trim().isEmpty()) {
            return false;
        }
        String trimmed = fullname.trim();
        return trimmed.length() >= 3 && trimmed.length() <= 100;
    }

    /**
     * Kiểm tra roleid hợp lệ
     * - Chỉ cho phép: 1, 2, 3, 4
     */
    public static boolean isValidRoleId(int roleid) {
        return roleid >= 1 && roleid <= 4;
    }

    /**
     * Kiểm tra file image hợp lệ
     */
    public static boolean isValidImageFile(Part part) {
        if (part == null || part.getSize() == 0) {
            return true; // File là optional
        }

        String contentType = part.getContentType();
        if (contentType == null) {
            return false;
        }

        for (String allowedType : ALLOWED_IMAGE_TYPES) {
            if (contentType.equalsIgnoreCase(allowedType)) {
                return true;
            }
        }

        return false;
    }

    /**
     * Kiểm tra file size
     */
    public static boolean isValidFileSize(Part part) {
        if (part == null || part.getSize() == 0) {
            return true; // File là optional
        }

        return part.getSize() <= MAX_FILE_SIZE;
    }

    /**
     * Kiểm tra file size với max size tùy chỉnh
     */
    public static boolean isValidFileSize(Part part, long maxSizeBytes) {
        if (part == null || part.getSize() == 0) {
            return true;
        }

        return part.getSize() <= maxSizeBytes;
    }

    /**
     * Format file size sang MB
     */
    public static String formatFileSize(long sizeBytes) {
        double sizeMB = sizeBytes / (1024.0 * 1024.0);
        return String.format("%.2f MB", sizeMB);
    }

    /**
     * Kiểm tra price hợp lệ
     */
    public static boolean isValidPrice(double price) {
        return price >= 0 && price <= 999999999;
    }

    /**
     * Kiểm tra quantity hợp lệ
     */
    public static boolean isValidQuantity(int quantity) {
        return quantity >= 0 && quantity <= 999999;
    }

    /**
     * Kiểm tra string rỗng hoặc null
     */
    public static boolean isBlank(String str) {
        return str == null || str.trim().isEmpty();
    }

    /**
     * Sanitize string - loại bỏ ký tự đặc biệt nguy hiểm
     */
    public static String sanitize(String input) {
        if (input == null) {
            return null;
        }
        // Loại bỏ các ký tự có thể gây XSS
        return input.trim()
                .replaceAll("<", "&lt;")
                .replaceAll(">", "&gt;")
                .replaceAll("\"", "&quot;")
                .replaceAll("'", "&#x27;")
                .replaceAll("/", "&#x2F;");
    }
}
