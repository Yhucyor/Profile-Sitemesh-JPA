<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
</head>

<body>

<section class="login-section">

    <div class="container">

        <div class="login-card">

            <div class="login-panel">

                <div class="login-panel-content">

                    <h2>
                        New to our website?
                    </h2>

                    <p>
                        Create an account to manage your profile,
                        products and personal information.
                    </p>

                    <a href="${pageContext.request.contextPath}/register"
                       class="login-create-btn">
                        CREATE AN ACCOUNT
                    </a>

                </div>

            </div>

            <div class="login-form-panel">

                <div class="login-form-box">

                    <h1>
                        LOG IN TO ENTER
                    </h1>

                    <c:if test="${not empty alert}">
                        <div class="login-alert">
                            ${alert}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login"
                          method="post">

                        <div class="login-field">
                            <input type="text"
                                   name="username"
                                   value="${param.username}"
                                   placeholder="Username"
                                   required>
                        </div>

                        <div class="login-field">
                            <input type="password"
                                   name="password"
                                   placeholder="Password"
                                   required>
                        </div>

                        <label class="login-remember">
                            <input type="checkbox"
                                   name="remember">

                            <span>
                                Keep me logged in
                            </span>
                        </label>

                        <button type="submit"
                                class="login-submit-btn">
                            LOG IN
                        </button>

                    </form>

                    <a href="${pageContext.request.contextPath}/forgot-password"
                       class="login-forgot-link">
                        Forgot Password?
                    </a>

                </div>

            </div>

        </div>

    </div>

</section>

</body>
</html>
