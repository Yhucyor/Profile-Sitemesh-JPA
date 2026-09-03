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

<h2>Xác nhận OTP</h2>

<p>
    Mã OTP đã được gửi đến email của bạn.
</p>

<c:if test="${not empty alert}">
    <p style="color:red;">
        ${alert}
    </p>
</c:if>

<form action="${pageContext.request.contextPath}/forgot-password/verify"
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
        Xác nhận OTP
    </button>

</form>

<br>

<a href="${pageContext.request.contextPath}/forgot-password">
    Quay lại
</a>

</body>

</html>