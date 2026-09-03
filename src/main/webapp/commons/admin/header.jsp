<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="admin-header">

    <div class="admin-brand">

        <strong>
            ADMIN MANAGEMENT
        </strong>

    </div>


    <div class="admin-user">

        <c:choose>

            <%-- Admin đã đăng nhập --%>
            <c:when test="${not empty sessionScope.account}">

                <%-- Hiển thị avatar nếu có --%>
                <c:if test="${not empty sessionScope.account.avatar}">
                    <img 
                        src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar}"
                        alt="Avatar"
                        style="width: 35px; height: 35px; border-radius: 50%; object-fit: cover; vertical-align: middle; margin-right: 8px; border: 2px solid #3498db;"
                        onerror="this.style.display='none'">
                </c:if>

                <span>
                    Xin chào,
                    <strong>
                        ${sessionScope.account.username}
                    </strong>
                </span>

                <span style="margin: 0 8px; color: #ccc;">|</span>

                <a href="${pageContext.request.contextPath}/profile"
                   style="text-decoration: none; color: #3498db; margin-right: 15px;">

                    Profile

                </a>

                <a href="${pageContext.request.contextPath}/logout"
                   class="logout-link">

                    Logout

                </a>

            </c:when>


            <%-- Chưa đăng nhập --%>
            <c:otherwise>

                <a href="${pageContext.request.contextPath}/login">

                    Login

                </a>

            </c:otherwise>

        </c:choose>

    </div>

</header>