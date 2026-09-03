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

    <div>
        <label>Vai trò:</label>
        <br>
        <select name="roleid" required>
            <option value="">-- Chọn vai trò --</option>
            <option value="1" ${param.roleid == '1' ? 'selected' : ''}>
                Admin (Quản trị viên)
            </option>
            <option value="2" ${param.roleid == '2' ? 'selected' : ''}>
                Manager (Người quản lý)
            </option>
            <option value="3" ${param.roleid == '3' ? 'selected' : ''}>
                User (Người dùng)
            </option>
            <option value="4" ${param.roleid == '4' ? 'selected' : ''}>
                Guest (Khách)
            </option>
        </select>
    </div>

    <br>

    <button type="submit">
        Đăng ký
    </button>

</form>

<br>

<p>
    Đã có tài khoản?
    <a href="${pageContext.request.contextPath}/login">
        Đăng nhập
    </a>
</p>

</body>

</html>