<%@ page
        language="java"
        contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Hồ sơ cá nhân</title>

</head>


<body>

<section class="profile-page">

    <div class="container">

        <div class="profile-layout">

            <aside class="profile-summary">

                <div class="profile-avatar-wrap">

                    <c:choose>

                        <c:when test="${not empty user.avatar}">

                            <c:choose>
                                <c:when test="${fn:startsWith(user.avatar, 'http://')
                                        or fn:startsWith(user.avatar, 'https://')}">
                                    <img src="${user.avatar}"
                                         alt="Avatar"
                                         class="profile-avatar">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/image?fname=${user.avatar}"
                                         alt="Avatar"
                                         class="profile-avatar">
                                </c:otherwise>
                            </c:choose>

                        </c:when>

                        <c:otherwise>

                            <img src="${pageContext.request.contextPath}/assets/frontend/images/avatar/default-avatar.png"
                                 alt="Default Avatar"
                                 class="profile-avatar">

                        </c:otherwise>

                    </c:choose>

                </div>

                <h2>
                    <c:choose>
                        <c:when test="${not empty user.fullname}">
                            ${user.fullname}
                        </c:when>
                        <c:otherwise>
                            ${user.username}
                        </c:otherwise>
                    </c:choose>
                </h2>

                <p>
                    ${user.email}
                </p>

                <div class="profile-meta-list">

                    <div>
                        <span>Username</span>
                        <strong>${user.username}</strong>
                    </div>

                    <div>
                        <span>Phone</span>
                        <strong>
                            <c:choose>
                                <c:when test="${not empty user.phone}">
                                    ${user.phone}
                                </c:when>
                                <c:otherwise>
                                    Chưa cập nhật
                                </c:otherwise>
                            </c:choose>
                        </strong>
                    </div>

                </div>

            </aside>

            <div class="profile-form-card">

                <div class="profile-form-heading">

                    <span>MY ACCOUNT</span>

                    <h1>
                        Hồ sơ cá nhân
                    </h1>

                    <p>
                        Cập nhật thông tin cá nhân và ảnh đại diện của bạn.
                    </p>

                </div>

                <c:if test="${not empty success}">
                    <div class="profile-alert profile-alert-success">
                        ${success}
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="profile-alert profile-alert-error">
                        ${error}
                    </div>
                </c:if>

                <form
                        method="post"
                        action="${pageContext.request.contextPath}/profile"
                        enctype="multipart/form-data"
                        class="profile-form">

                    <div class="profile-field-grid">

                        <div class="profile-field">
                            <label>Username</label>
                            <input
                                    type="text"
                                    value="${user.username}"
                                    disabled>
                        </div>

                        <div class="profile-field">
                            <label>Email</label>
                            <input
                                    type="email"
                                    value="${user.email}"
                                    disabled>
                        </div>

                        <div class="profile-field">
                            <label>Full name</label>
                            <input
                                    type="text"
                                    name="fullname"
                                    value="${user.fullname}"
                                    placeholder="Nhập họ tên đầy đủ">
                        </div>

                        <div class="profile-field">
                            <label>Phone</label>
                            <input
                                    type="text"
                                    name="phone"
                                    value="${user.phone}"
                                    placeholder="Nhập số điện thoại">
                        </div>

                    </div>

                    <div class="profile-upload-field">
                        <label>Ảnh đại diện</label>
                        <input
                                type="file"
                                name="image"
                                accept="image/*">
                    </div>

                    <button type="submit"
                            class="profile-submit-btn">
                        CẬP NHẬT HỒ SƠ
                    </button>

                </form>

            </div>

        </div>

    </div>

</section>

</body>

</html>
