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

<h2>Đăng nhập</h2>

<c:if test="${not empty alert}">
    <p style="color: red;">
        ${alert}
    </p>
</c:if>

<form action="${pageContext.request.contextPath}/login"
      method="post">

    <div>
        <label>Tên đăng nhập:</label>
        <br>

        <input type="text"
               name="username"
               value="${param.username}"
               required>
    </div>

    <br>

    <div>
        <label>Mật khẩu:</label>
        <br>

        <input type="password"
               name="password"
               required>
    </div>

    <br>

    <div>
        <input type="checkbox"
               name="remember">

        <label>Ghi nhớ đăng nhập</label>
    </div>

    <br>

<button type="submit">
    Đăng nhập
</button>

</form>

<br>

<p>
    <a href="${pageContext.request.contextPath}/forgot-password">
        Quên mật khẩu?
    </a>
</p>

<p>
    Chưa có tài khoản?

    <a href="${pageContext.request.contextPath}/register">
        Đăng ký
    </a>
</p>
</body>
</html>