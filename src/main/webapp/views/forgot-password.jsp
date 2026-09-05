<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu</title>
</head>

<body>

<section class="login-section auth-page">

    <div class="container">

        <div class="login-card auth-card">

            <div class="login-panel auth-visual">
                <div>
                    <span>TECHSTORE</span>
                    <h2>Recover your account</h2>
                    <p>
                        Enter your registered email and we will send you
                        an OTP code to reset your password.
                    </p>
                </div>
            </div>

            <div class="login-form-panel auth-form-panel">

                <div class="login-form-box auth-form-box">

                    <div class="auth-icon">
                        <i class="bi bi-envelope-paper"></i>
                    </div>

                    <h1>Forgot Password</h1>

                    <p class="auth-subtitle">
                        Nhập email đã đăng ký để nhận mã OTP.
                    </p>

                    <c:if test="${not empty alert}">
                        <div class="login-alert">
                            ${alert}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/forgot-password"
                          method="post">

                        <div class="login-field">
                            <input type="email"
                                   name="email"
                                   value="${param.email}"
                                   placeholder="Email Address"
                                   required>
                        </div>

                        <button type="submit"
                                class="login-submit-btn">
                            SEND OTP
                        </button>

                    </form>

                    <a href="${pageContext.request.contextPath}/login"
                       class="login-forgot-link">
                        Back to login
                    </a>

                </div>

            </div>

        </div>

    </div>

</section>

</body>

</html>
