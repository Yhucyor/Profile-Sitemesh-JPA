<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Trang chủ</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background: #f5f5f5;
        }

        .container {
            width: 95%;
            margin: 30px auto;
        }

        .title {
            margin-bottom: 20px;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 20px;
        }

        .product-card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
        }

        .product-image {
            width: 100%;
            height: 180px;
            object-fit: contain;
        }

        .no-image {
            width: 100%;
            height: 180px;
            background: #eeeeee;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .product-name {
            font-size: 18px;
            margin: 10px 0;
        }

        .product-price {
            color: red;
            font-size: 20px;
            font-weight: bold;
        }

        .product-category {
            margin-top: 8px;
        }

        .product-quantity {
            margin-top: 8px;
        }

    </style>

</head>

<body>

<div class="container">

    <h2 class="title">
        10 sản phẩm mới nhất
    </h2>

    <c:if test="${empty latestProducts}">

        <p>
            Hiện chưa có sản phẩm nào.
        </p>

    </c:if>

    <div class="product-grid">

        <c:forEach items="${latestProducts}"
                   var="product">

            <div class="product-card">

                <c:choose>

                    <c:when test="${not empty product.image}">

                        <c:choose>

                            <c:when test="${fn:startsWith(product.image, 'http://')
                                    or fn:startsWith(product.image, 'https://')}">
                                <c:set var="imageUrl"
                                       value="${product.image}" />
                            </c:when>

                            <c:otherwise>
                                <c:set var="imageUrl"
                                       value="${pageContext.request.contextPath}/image?fname=${product.image}" />
                            </c:otherwise>

                        </c:choose>

                        <img
                                src="${imageUrl}"
                                class="product-image"
                                alt="${product.productName}">

                    </c:when>

                    <c:otherwise>

                        <div class="no-image">
                            Chưa có ảnh
                        </div>

                    </c:otherwise>

                </c:choose>

                <div class="product-name">
                    ${product.productName}
                </div>

                <div class="product-price">
                    ${product.price} VNĐ
                </div>

                <div class="product-category">
                    Danh mục:
                    ${product.category.categoryname}
                </div>

                <div class="product-quantity">
                    Số lượng:
                    ${product.quantity}
                </div>

            </div>

        </c:forEach>

    </div>

</div>

</body>

</html>
