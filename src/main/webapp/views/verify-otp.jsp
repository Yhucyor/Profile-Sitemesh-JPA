<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Xác nhận OTP</title>
</head>

<body>

<section class="login-section auth-page">

    <div class="container">

        <div class="login-card auth-card">

            <div class="login-panel auth-visual">
                <div>
                    <span>ACCOUNT VERIFY</span>
                    <h2>Activate your account</h2>
                    <p>
                        Enter the OTP code from your email to finish
                        creating your TechStore account.
                    </p>
                </div>
            </div>

            <div class="login-form-panel auth-form-panel">

                <div class="login-form-box auth-form-box">

                    <div class="auth-icon">
                        <i class="bi bi-patch-check"></i>
                    </div>

                    <h1>Verify Account</h1>

                    <p class="auth-subtitle">
                        Mã OTP đã được gửi tới email của bạn.
                    </p>

                    <c:if test="${not empty alert}">
                        <div class="login-alert">
                            ${alert}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/verify-otp"
                          method="post">

                        <div class="login-field otp-field">
                            <input type="text"
                                   name="otp"
                                   maxlength="6"
                                   placeholder="OTP Code"
                                   required>
                        </div>

                        <button type="submit"
                                class="login-submit-btn">
                            CONFIRM
                        </button>

                    </form>

                    <a href="${pageContext.request.contextPath}/register"
                       class="login-forgot-link">
                        Back to register
                    </a>

                </div>

            </div>

        </div>

    </div>

</section>

</body>

</html>
