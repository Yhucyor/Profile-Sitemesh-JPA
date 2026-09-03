<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu</title>
</head>

<body>

<h2>Đặt lại mật khẩu</h2>

<c:if test="${not empty alert}">
    <p style="color:red;">
        ${alert}
    </p>
</c:if>

<form action="${pageContext.request.contextPath}/reset-password"
      method="post">

    <div>
        <label>Mật khẩu mới:</label>
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

    <button type="submit">
        Đổi mật khẩu
    </button>

</form>

</body>

</html>