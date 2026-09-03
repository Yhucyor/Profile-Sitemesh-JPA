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

<h2>Xác nhận tài khoản</h2>

<p>
    Mã OTP đã được gửi tới email của bạn.
</p>

<c:if test="${not empty alert}">
    <p style="color: red;">
        ${alert}
    </p>
</c:if>

<form action="${pageContext.request.contextPath}/verify-otp"
      method="post">

    <div>
        <label>Mã OTP:</label>

        <br>

        <input type="text"
               name="otp"
               maxlength="6"
               placeholder="Nhập mã OTP"
               required>
    </div>

    <br>

    <button type="submit">
        Xác nhận
    </button>

</form>

<br>

<a href="${pageContext.request.contextPath}/register">
    Quay lại đăng ký
</a>

</body>

</html>