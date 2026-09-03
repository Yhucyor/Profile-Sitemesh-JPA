<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">

    <title>Danh sách sản phẩm</title>

<style>

    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        font-family: Arial, sans-serif;
        background: #f5f5f5;
        color: #222;
    }

    .container {
        width: 96%;
        max-width: 1100px;
        margin: 20px auto;
    }

    .page-title {
        margin-bottom: 8px;
        font-size: 26px;
    }

    .product-count {
        color: #666;
        margin-bottom: 18px;
    }

    /* =========================
       GRID
       ========================= */

    .product-grid {
        display: grid;

        grid-template-columns: repeat(3, minmax(0, 1fr));

        gap: 16px;
    }

    /* =========================
       CARD
       ========================= */

    .product-card {
        background: white;

        border: 1px solid #ddd;

        border-radius: 10px;

        overflow: hidden;

        transition: 0.2s;

        min-width: 0;
    }

    .product-card:hover {
        transform: translateY(-3px);

        box-shadow: 0 6px 14px rgba(0, 0, 0, 0.10);
    }

    /* =========================
       IMAGE
       ========================= */

    .image-box {
        width: 100%;

        height: 180px;

        display: flex;
        justify-content: center;
        align-items: center;

        background: #fafafa;

        overflow: hidden;
    }

    .product-image {
        width: 100%;
        height: 100%;

        object-fit: contain;

        padding: 8px;
    }

    .no-image {
        color: #999;
        font-size: 14px;
    }

    /* =========================
       CONTENT
       ========================= */

    .product-content {
        padding: 12px;
    }

    .product-name {
        font-size: 17px;
        font-weight: bold;

        margin-bottom: 8px;

        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .product-price {
        color: #ee4d2d;

        font-size: 19px;
        font-weight: bold;

        margin-bottom: 8px;
    }

    .product-info {
        margin-bottom: 5px;

        color: #555;

        font-size: 14px;
    }

    /* =========================
       PAGINATION
       ========================= */

    .pagination {
        display: flex;

        justify-content: center;
        align-items: center;

        margin-top: 28px;

        gap: 6px;
    }

    .pagination a,
    .pagination span {
        min-width: 36px;
        height: 36px;

        display: flex;
        justify-content: center;
        align-items: center;

        border-radius: 5px;

        text-decoration: none;

        color: #555;

        background: white;

        border: 1px solid #ddd;
    }

    .pagination .active {
        background: #ee4d2d;
        color: white;
        border-color: #ee4d2d;
    }

    .pagination .disabled {
        color: #bbb;
        background: #eee;
    }

    /* =========================
       RESPONSIVE
       ========================= */

    @media (max-width: 900px) {

        .product-grid {
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }

    }

    @media (max-width: 600px) {

        .container {
            width: 95%;
        }

        .product-grid {
            grid-template-columns: 1fr;
        }

    }

</style>

</head>

<body>

<div class="container">

    <!-- =========================
         TITLE
         ========================= -->

    <h1 class="page-title">
        Tất cả sản phẩm
    </h1>

    <div class="product-count">

        Tổng số sản phẩm:
        ${totalProducts}

    </div>


    <!-- =========================
         KHÔNG CÓ PRODUCT
         ========================= -->

    <c:if test="${empty products}">

        <p>
            Hiện chưa có sản phẩm nào.
        </p>

    </c:if>


    <!-- =========================
         PRODUCT GRID
         ========================= -->

    <div class="product-grid">

        <c:forEach items="${products}"
                   var="product">

            <div class="product-card">

                <!-- IMAGE -->

                <div class="image-box">

                    <c:choose>

                        <c:when test="${not empty product.image}">

                            <img
                                src="${product.image}"
                                class="product-image"
                                alt="${product.productName}"
                                onerror="this.onerror=null;
                                         this.src='https://placehold.co/400x300?text=No+Image';"
                            >

                        </c:when>

                        <c:otherwise>

                            <div class="no-image">
                                Chưa có ảnh
                            </div>

                        </c:otherwise>

                    </c:choose>

                </div>


                <!-- CONTENT -->

                <div class="product-content">

                    <div class="product-name">

                        ${product.productName}

                    </div>


                    <div class="product-price">

                        ${product.price} VNĐ

                    </div>


                    <div class="product-info">

                        Danh mục:

                        <strong>
                            ${product.category.categoryname}
                        </strong>

                    </div>


                    <div class="product-info">

                        Số lượng:

                        ${product.quantity}

                    </div>


                    <div class="product-info">

                        Trạng thái:

                        <c:choose>

                            <c:when test="${product.status == 1}">

                                <span class="status-active">
                                    Còn bán
                                </span>

                            </c:when>

                            <c:otherwise>

                                <span class="status-inactive">
                                    Ngừng bán
                                </span>

                            </c:otherwise>

                        </c:choose>

                    </div>

                </div>

            </div>

        </c:forEach>

    </div>


    <!-- =========================
         PAGINATION
         ========================= -->

    <c:if test="${totalPages > 1}">

        <div class="pagination">


            <!-- VỀ TRANG ĐẦU -->

            <c:choose>

                <c:when test="${currentPage > 1}">

                    <a href="${pageContext.request.contextPath}/product?page=1">
                        &laquo;
                    </a>

                </c:when>

                <c:otherwise>

                    <span class="disabled">
                        &laquo;
                    </span>

                </c:otherwise>

            </c:choose>


            <!-- SỐ TRANG -->

            <c:forEach begin="1"
                       end="${totalPages}"
                       var="pageNumber">

                <c:choose>

                    <c:when test="${pageNumber == currentPage}">

                        <span class="active">

                            ${pageNumber}

                        </span>

                    </c:when>

                    <c:otherwise>

                        <a href="${pageContext.request.contextPath}/product?page=${pageNumber}">

                            ${pageNumber}

                        </a>

                    </c:otherwise>

                </c:choose>

            </c:forEach>


            <!-- VỀ TRANG CUỐI -->

            <c:choose>

                <c:when test="${currentPage < totalPages}">

                    <a href="${pageContext.request.contextPath}/product?page=${totalPages}">
                        &raquo;
                    </a>

                </c:when>

                <c:otherwise>

                    <span class="disabled">
                        &raquo;
                    </span>

                </c:otherwise>

            </c:choose>

        </div>

    </c:if>

</div>

</body>

</html>
