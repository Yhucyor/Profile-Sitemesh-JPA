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

<h2>Đăng ký tài khoản</h2>

<c:if test="${not empty alert}">
    <p style="color: red;">
        ${alert}
    </p>
</c:if>

<form action="${pageContext.request.contextPath}/register"
      method="post">

    <div>
        <label>Email:</label>
        <br>
        <input type="email"
               name="email"
               value="${param.email}"
               required>
    </div>

    <br>

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
        <label>Họ và tên:</label>
        <br>
        <input type="text"
               name="fullname"
               value="${param.fullname}"
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
        <label>Nhập lại mật khẩu:</label>
        <br>
        <input type="password"
               name="confirmPassword"
               required>
    </div>

    <br>

    <div>
        <label>Số điện thoại:</label>
        <br>
        <input type="text"
               name="phone"
               value="${param.phone}">
    </div>

    <br>

    <button type="submit">
        Đăng ký
    </button>

</form>

</body>

</html>