<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Quản lý danh mục</title>

    <style>

        .category-page {
            background: #ffffff;
            padding: 25px;
            border-radius: 10px;
        }

        .category-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .category-header h2 {
            margin: 0;
        }

        .btn-add {
            display: inline-block;
            padding: 10px 16px;
            background: #198754;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .btn-add:hover {
            opacity: 0.9;
        }

        .category-table {
            width: 100%;
            border-collapse: collapse;
        }

        .category-table th,
        .category-table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
            vertical-align: middle;
        }

        .category-table th {
            background: #f1f1f1;
        }

        .category-image {
            width: 150px;
            height: 100px;
            object-fit: contain;
            border-radius: 6px;
        }

        .status-active {
            color: green;
            font-weight: bold;
        }

        .status-locked {
            color: red;
            font-weight: bold;
        }

        .action-edit {
            color: #0d6efd;
            text-decoration: none;
        }

        .action-delete {
            color: #dc3545;
            text-decoration: none;
        }

        .action-edit:hover,
        .action-delete:hover {
            text-decoration: underline;
        }

        .no-data {
            text-align: center;
            padding: 25px;
            color: #777;
        }

    </style>

</head>

<body>

<div class="category-page">

    <div class="category-header">

        <h2>
            Quản lý danh mục
        </h2>

        <a class="btn-add"
           href="${pageContext.request.contextPath}/admin/category/add">

            + Add Category

        </a>

    </div>


    <c:if test="${empty listcate}">

        <div class="no-data">
            Hiện chưa có danh mục nào.
        </div>

    </c:if>


    <c:if test="${not empty listcate}">

        <table class="category-table">

            <thead>

            <tr>

                <th>STT</th>
                <th>Images</th>
                <th>Category name</th>
                <th>Status</th>
                <th>Action</th>

            </tr>

            </thead>


            <tbody>

            <c:forEach
                    items="${listcate}"
                    var="cate"
                    varStatus="STT">

                <tr>

                    <td>
                            ${STT.index + 1}
                    </td>


                    <td>

                        <c:choose>

                            <%-- Không có ảnh --%>
                            <c:when test="${empty cate.images}">

                                <span>
                                    Chưa có ảnh
                                </span>

                            </c:when>


                            <%-- Ảnh URL / Cloudinary --%>
                            <c:when test="${fn:startsWith(cate.images, 'http://')
                                    or fn:startsWith(cate.images, 'https://')}">

                                <img
                                        src="${cate.images}"
                                        class="category-image"
                                        alt="${cate.categoryname}">

                            </c:when>


                            <%-- Ảnh local --%>
                            <c:otherwise>

                                <c:url
                                        value="/image"
                                        var="imageUrl">

                                    <c:param
                                            name="fname"
                                            value="${cate.images}"/>

                                </c:url>

                                <img
                                        src="${imageUrl}"
                                        class="category-image"
                                        alt="${cate.categoryname}">

                            </c:otherwise>

                        </c:choose>

                    </td>


                    <td>
                            ${cate.categoryname}
                    </td>


                    <td>

                        <c:choose>

                            <c:when test="${cate.status == 1}">

                                <span class="status-active">
                                    Hoạt động
                                </span>

                            </c:when>

                            <c:otherwise>

                                <span class="status-locked">
                                    Khóa
                                </span>

                            </c:otherwise>

                        </c:choose>

                    </td>


                    <td>

                        <c:url
                                value="/admin/category/edit"
                                var="editUrl">

                            <c:param
                                    name="id"
                                    value="${cate.categoryid}"/>

                        </c:url>

                        <a
                                class="action-edit"
                                href="${editUrl}">

                            Sửa

                        </a>

                        |

                        <c:url
                                value="/admin/category/delete"
                                var="deleteUrl">

                            <c:param
                                    name="id"
                                    value="${cate.categoryid}"/>

                        </c:url>

                        <a
                                class="action-delete"
                                href="${deleteUrl}"
                                onclick="return confirm('Bạn có chắc muốn xóa danh mục này?');">

                            Xóa

                        </a>

                    </td>

                </tr>

            </c:forEach>

            </tbody>

        </table>

    </c:if>

</div>

</body>

</html>