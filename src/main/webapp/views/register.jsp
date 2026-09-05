<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản</title>
</head>

<body>

<section class="login-section register-section">

    <div class="container">

        <div class="login-card register-card">

            <div class="login-panel register-panel">

                <div class="login-panel-content">

                    <h2>
                        Already have an account?
                    </h2>

                    <p>
                        Sign in to continue managing your TechStore
                        profile and product workspace.
                    </p>

                    <a href="${pageContext.request.contextPath}/login"
                       class="login-create-btn">
                        LOG IN
                    </a>

                </div>

            </div>

            <div class="login-form-panel register-form-panel">

                <div class="login-form-box register-form-box">

                    <h1>
                        CREATE AN ACCOUNT
                    </h1>

                    <c:if test="${not empty alert}">
                        <div class="login-alert">
                            ${alert}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register"
                          method="post">

                        <div class="register-field-grid">

                            <div class="login-field">
                                <input type="email"
                                       name="email"
                                       value="${param.email}"
                                       placeholder="Email"
                                       required>
                            </div>

                            <div class="login-field">
                                <input type="text"
                                       name="username"
                                       value="${param.username}"
                                       placeholder="Username"
                                       required>
                            </div>

                            <div class="login-field">
                                <input type="text"
                                       name="fullname"
                                       value="${param.fullname}"
                                       placeholder="Full name"
                                       required>
                            </div>

                            <div class="login-field">
                                <input type="text"
                                       name="phone"
                                       value="${param.phone}"
                                       placeholder="Phone">
                            </div>

                            <div class="login-field">
                                <input type="password"
                                       name="password"
                                       placeholder="Password"
                                       required>
                            </div>

                            <div class="login-field">
                                <input type="password"
                                       name="confirmPassword"
                                       placeholder="Confirm password"
                                       required>
                            </div>

                        </div>

                        <div class="login-field register-select-field">
                            <select name="roleid"
                                    required>
                                <option value="">
                                    Select role
                                </option>
                                <option value="1" ${param.roleid == '1' ? 'selected' : ''}>
                                    Admin
                                </option>
                                <option value="2" ${param.roleid == '2' ? 'selected' : ''}>
                                    Manager
                                </option>
                                <option value="3" ${param.roleid == '3' ? 'selected' : ''}>
                                    User
                                </option>
                                <option value="4" ${param.roleid == '4' ? 'selected' : ''}>
                                    Guest
                                </option>
                            </select>
                        </div>

                        <button type="submit"
                                class="login-submit-btn">
                            REGISTER
                        </button>

                    </form>

                    <a href="${pageContext.request.contextPath}/login"
                       class="login-forgot-link">
                        Already have an account?
                    </a>

                </div>

            </div>

        </div>

    </div>

</section>

</body>

</html>
