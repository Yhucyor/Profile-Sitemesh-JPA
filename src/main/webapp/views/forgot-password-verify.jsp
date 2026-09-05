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
                    <span>SECURITY CODE</span>
                    <h2>Verify reset OTP</h2>
                    <p>
                        Use the code sent to your email to continue
                        resetting your TechStore password.
                    </p>
                </div>
            </div>

            <div class="login-form-panel auth-form-panel">

                <div class="login-form-box auth-form-box">

                    <div class="auth-icon">
                        <i class="bi bi-shield-check"></i>
                    </div>

                    <h1>Confirm OTP</h1>

                    <p class="auth-subtitle">
                        Mã OTP đã được gửi đến email của bạn.
                    </p>

                    <c:if test="${not empty alert}">
                        <div class="login-alert">
                            ${alert}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/forgot-password/verify"
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
                            VERIFY OTP
                        </button>

                    </form>

                    <a href="${pageContext.request.contextPath}/forgot-password"
                       class="login-forgot-link">
                        Back
                    </a>

                </div>

            </div>

        </div>

    </div>

</section>

</body>

</html>
