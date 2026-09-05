<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu</title>
</head>

<body>

<section class="login-section auth-page">

    <div class="container">

        <div class="login-card auth-card">

            <div class="login-panel auth-visual">
                <div>
                    <span>NEW PASSWORD</span>
                    <h2>Secure your account</h2>
                    <p>
                        Create a new password to keep your TechStore
                        account protected.
                    </p>
                </div>
            </div>

            <div class="login-form-panel auth-form-panel">

                <div class="login-form-box auth-form-box">

                    <div class="auth-icon">
                        <i class="bi bi-lock"></i>
                    </div>

                    <c:if test="${not empty resetUsername}">
                        <div class="reset-account-name">
                            Username:
                            <strong>
                                ${resetUsername}
                            </strong>
                        </div>
                    </c:if>

                    <h1>Reset Password</h1>

                    <c:if test="${not empty alert}">
                        <div class="login-alert">
                            ${alert}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/reset-password"
                          method="post">

                        <div class="login-field">
                            <input type="password"
                                   name="password"
                                   placeholder="New Password"
                                   required>
                        </div>

                        <div class="login-field">
                            <input type="password"
                                   name="confirmPassword"
                                   placeholder="Confirm Password"
                                   required>
                        </div>

                        <button type="submit"
                                class="login-submit-btn">
                            CHANGE PASSWORD
                        </button>

                    </form>

                </div>

            </div>

        </div>

    </div>

</section>

</body>

</html>
