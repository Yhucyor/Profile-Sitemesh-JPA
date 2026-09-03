<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm</title>
</head>

<body>

<h2>Danh sách sản phẩm</h2>

<a href="${pageContext.request.contextPath}/admin/product/add">
    Thêm sản phẩm
</a>

<hr>

<table border="1"
       width="100%"
       cellpadding="8">

    <tr>
        <th>STT</th>
        <th>Ảnh</th>
        <th>Tên sản phẩm</th>
        <th>Giá</th>
        <th>Số lượng</th>
        <th>Mô tả</th>
        <th>Category</th>
        <th>Trạng thái</th>
        <th>Ngày tạo</th>
        <th>Action</th>
    </tr>

    <c:forEach items="${listProduct}"
               var="product"
               varStatus="stt">

        <tr>

            <td>${stt.index + 1}</td>

            <td>
                <c:if test="${not empty product.image}">
                    <img
                            src="${pageContext.request.contextPath}/image?fname=${product.image}"
                            width="120"
                            height="100"
                            alt="${product.productName}">
                </c:if>
            </td>

            <td>${product.productName}</td>

            <td>${product.price}</td>

            <td>${product.quantity}</td>

            <td>${product.description}</td>

            <td>${product.category.categoryname}</td>

            <td>
                <c:choose>

                    <c:when test="${product.status == 1}">
                        Hoạt động
                    </c:when>

                    <c:otherwise>
                        Khóa
                    </c:otherwise>

                </c:choose>
            </td>

            <td>${product.createdDate}</td>

            <td>

                <a href="${pageContext.request.contextPath}/admin/product/edit?id=${product.productId}">
                    Sửa
                </a>

                |

                <a href="${pageContext.request.contextPath}/admin/product/delete?id=${product.productId}"
                   onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                    Xóa
                </a>

            </td>

        </tr>

    </c:forEach>

</table>

</body>
</html>
