<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>

    <c:when test="${not empty sessionScope.account}">

        <h3>
            Xin chào,
            ${sessionScope.account.username}
        </h3>

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </c:when>

    <c:otherwise>

        <p style="color:red;">
            Hiện tại chưa có tài khoản đăng nhập trong Session.
        </p>

        <a href="${pageContext.request.contextPath}/login">
            Login
        </a>

    </c:otherwise>

</c:choose>

<br><br>

<a href="${pageContext.request.contextPath}/admin/category/add">
    Add Category
</a>

<hr>

<table border="1" width="100%">

    <tr>
        <th>STT</th>
        <th>Images</th>
        <th>Category name</th>
        <th>Status</th>
        <th>Action</th>
    </tr>

    <c:forEach items="${listcate}" var="cate" varStatus="STT">

        <tr>

            <td>${STT.index + 1}</td>

            <c:if test="${cate.images.substring(0,5) == 'https'}">
                <c:url value="${cate.images}" var="imgUrl"/>
            </c:if>

            <c:if test="${cate.images.substring(0,5) != 'https'}">
                <c:url value="/image?fname=${cate.images}" var="imgUrl"/>
            </c:if>

            <td>
                <img height="150"
                     width="200"
                     src="${imgUrl}"/>
            </td>

            <td>${cate.categoryname}</td>

            <td>

                <c:if test="${cate.status == 1}">
                    Hoạt động
                </c:if>

                <c:if test="${cate.status != 1}">
                    Khóa
                </c:if>

            </td>

            <td>

                <a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>">
                    Sửa
                </a>

                |

                <a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>">
                    Xóa
                </a>

            </td>

        </tr>

    </c:forEach>

</table>