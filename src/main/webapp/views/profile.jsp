<%@ page
        language="java"
        contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Hồ sơ cá nhân</title>

</head>


<body>


<h1>HỒ SƠ CÁ NHÂN</h1>


<%-- Thông báo thành công --%>
<c:if test="${not empty success}">

    <p style="color: green;">
        ${success}
    </p>

</c:if>


<%-- Thông báo lỗi --%>
<c:if test="${not empty error}">

    <p style="color: red;">
        ${error}
    </p>

</c:if>


<%-- Avatar --%>
<div>

    <c:choose>

        <c:when test="${not empty user.avatar}">

            <img
                    src="${pageContext.request.contextPath}/image?fname=${user.avatar}"
                    alt="Avatar"
                    width="150"
                    height="150"
                    style="border-radius: 50%; object-fit: cover;">

        </c:when>

        <c:otherwise>

            <img
                    src="https://via.placeholder.com/150?text=No+Avatar"
                    alt="Avatar"
                    width="150"
                    height="150"
                    style="border-radius: 50%;">

        </c:otherwise>

    </c:choose>

</div>

<br>

<%-- Form cập nhật --%>
<form
        method="post"
        action="${pageContext.request.contextPath}/profile"
        enctype="multipart/form-data">


    <%-- Username (readonly) --%>
    <div>

        <label>
            Username
        </label>
        <br>
        <input
                type="text"
                value="${user.username}"
                disabled
                size="40">

    </div>

    <br>

    <%-- Email (readonly) --%>
    <div>

        <label>
            Email
        </label>
        <br>
        <input
                type="email"
                value="${user.email}"
                disabled
                size="40">

    </div>

    <br>

    <%-- Full name (editable) --%>
    <div>

        <label>
            Full name
        </label>
        <br>
        <input
                type="text"
                name="fullname"
                value="${user.fullname}"
                placeholder="Nhập họ tên đầy đủ"
                size="40">

    </div>

    <br>

    <%-- Phone (editable) --%>
    <div>

        <label>
            Phone
        </label>
        <br>
        <input
                type="text"
                name="phone"
                value="${user.phone}"
                placeholder="Nhập số điện thoại"
                size="40">

    </div>

    <br>

    <%-- Ảnh đại diện (file upload) --%>
    <div>

        <label>
            Ảnh đại diện
        </label>
        <br>
        <input
                type="file"
                name="image"
                accept="image/*">

    </div>

    <br>

    <%-- Submit button --%>
    <button type="submit">
        CẬP NHẬT HỒ SƠ
    </button>


</form>


</body>

</html>
