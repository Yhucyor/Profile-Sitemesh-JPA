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

<h2>Quên mật khẩu</h2>

<p>
    Nhập email đã đăng ký để nhận mã OTP.
</p>

<c:if test="${not empty alert}">
    <p style="color:red;">
        ${alert}
    </p>
</c:if>

<form action="${pageContext.request.contextPath}/forgot-password"
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

    <button type="submit">
        Gửi OTP
    </button>

</form>

<br>

<a href="${pageContext.request.contextPath}/login">
    Quay lại đăng nhập
</a>

</body>

</html>