<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="vi_VN" />

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Trang chủ</title>

</head>

<body>

<%-- =========================================
     HERO SLIDER
     ========================================= --%>

<section class="shop-slider">

    <div id="homeSlider"
         class="carousel slide"
         data-bs-ride="carousel">

        <%-- Indicators --%>

        <div class="carousel-indicators">

            <button
                    type="button"
                    data-bs-target="#homeSlider"
                    data-bs-slide-to="0"
                    class="active"
                    aria-current="true"
                    aria-label="Slide 1">
            </button>

            <button
                    type="button"
                    data-bs-target="#homeSlider"
                    data-bs-slide-to="1"
                    aria-label="Slide 2">
            </button>

            <button
                    type="button"
                    data-bs-target="#homeSlider"
                    data-bs-slide-to="2"
                    aria-label="Slide 3">
            </button>

        </div>

        <div class="carousel-inner">

            <%-- =====================================
                 SLIDE 1
                 ===================================== --%>

            <div class="carousel-item active"
                 data-bs-interval="3000">

                <img
                        src="${pageContext.request.contextPath}/assets/frontend/images/slider/slide-1.jpg"
                        class="d-block w-100 shop-slider-image"
                        alt="New products"
                        fetchpriority="high"
                        decoding="async">

                <div class="shop-slider-overlay"></div>

                <div class="carousel-caption shop-slider-caption">

                    <span class="shop-slider-subtitle">
                        WELCOME TO TECHSTORE
                    </span>

                    <h1>
                        Discover Our
                        <strong>New Products</strong>
                    </h1>

                    <p>
                        Khám phá những sản phẩm mới nhất
                        với trải nghiệm mua sắm hiện đại.
                    </p>

                    <a
                            href="${pageContext.request.contextPath}/product"
                            class="btn shop-slider-btn">

                        SHOP NOW

                        <i class="bi bi-arrow-right ms-2"></i>

                    </a>

                </div>

            </div>

            <%-- =====================================
                 SLIDE 2
                 ===================================== --%>

            <div class="carousel-item"
                 data-bs-interval="3000">

                <img
                        src="${pageContext.request.contextPath}/assets/frontend/images/slider/slide-2.jpg"
                        class="d-block w-100 shop-slider-image"
                        alt="Quality products"
                        loading="lazy"
                        decoding="async">

                <div class="shop-slider-overlay"></div>

                <div class="carousel-caption shop-slider-caption">

                    <span class="shop-slider-subtitle">
                        QUALITY PRODUCTS
                    </span>

                    <h1>
                        Choose The
                        <strong>Best Products</strong>
                    </h1>

                    <p>
                        Sản phẩm chất lượng,
                        giao diện hiện đại và dễ dàng quản lý.
                    </p>

                    <a
                            href="${pageContext.request.contextPath}/product"
                            class="btn shop-slider-btn">

                        VIEW PRODUCTS

                        <i class="bi bi-grid ms-2"></i>

                    </a>

                </div>

            </div>

            <%-- =====================================
                 SLIDE 3
                 ===================================== --%>

            <div class="carousel-item"
                 data-bs-interval="3000">

                <img
                        src="${pageContext.request.contextPath}/assets/frontend/images/slider/slide-3.jpg"
                        class="d-block w-100 shop-slider-image"
                        alt="TechStore"
                        loading="lazy"
                        decoding="async">

                <div class="shop-slider-overlay"></div>

                <div class="carousel-caption shop-slider-caption">

                    <span class="shop-slider-subtitle">
                        MODERN E-COMMERCE
                    </span>

                    <h1>
                        Built With
                        <strong>Modern Technologies</strong>
                    </h1>

                    <p>
                        Servlet · JSP · JPA · SiteMesh 3
                        · Bootstrap 5
                    </p>

                    <a
                            href="${pageContext.request.contextPath}/about"
                            class="btn shop-slider-btn">

                        LEARN MORE

                        <i class="bi bi-arrow-down ms-2"></i>

                    </a>

                </div>

            </div>

        </div>

        <%-- =========================================
             PREVIOUS
             ========================================= --%>

        <button
                class="carousel-control-prev"
                type="button"
                data-bs-target="#homeSlider"
                data-bs-slide="prev">

            <span class="carousel-control-prev-icon"
                  aria-hidden="true">
            </span>

            <span class="visually-hidden">
                Previous
            </span>

        </button>

        <%-- =========================================
             NEXT
             ========================================= --%>

        <button
                class="carousel-control-next"
                type="button"
                data-bs-target="#homeSlider"
                data-bs-slide="next">

            <span class="carousel-control-next-icon"
                  aria-hidden="true">
            </span>

            <span class="visually-hidden">
                Next
            </span>

        </button>

    </div>

</section>

<section class="featured-products">

    <div class="container">

        <h2 class="featured-title">
            Featured Products
        </h2>

        <p class="featured-subtitle">
            Những sản phẩm nổi bật và mới nhất tại TechStore.
        </p>

        <c:if test="${empty latestProducts}">

            <p class="text-center text-secondary">
                Hiện chưa có sản phẩm nào.
            </p>

        </c:if>

        <div class="product-grid">

            <c:forEach items="${latestProducts}"
                       var="product">

                <div class="product-card">

                    <div class="product-media">

                        <a href="${pageContext.request.contextPath}/product/detail?id=${product.productId}"
                           class="product-link"
                           aria-label="${product.productName}">

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
                                        alt="${product.productName}"
                                        onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/frontend/images/product-default.svg';">

                            </c:when>

                            <c:otherwise>

                                <img
                                        src="${pageContext.request.contextPath}/assets/frontend/images/product-default.svg"
                                        class="product-image"
                                        alt="Chưa có ảnh">

                            </c:otherwise>

                        </c:choose>

                        </a>

                        <div class="product-actions">

                            <a href="#"
                               class="product-action-btn"
                               aria-label="Yêu thích">
                                <i class="bi bi-heart"></i>
                            </a>

                            <a href="${pageContext.request.contextPath}/cart"
                               class="product-action-btn"
                               aria-label="Giỏ hàng">
                                <i class="bi bi-cart3"></i>
                            </a>

                        </div>

                    </div>

                    <div class="product-name">
                        <a href="${pageContext.request.contextPath}/product/detail?id=${product.productId}">
                            ${product.productName}
                        </a>
                    </div>

                    <div class="product-price">
                        <fmt:formatNumber
                                value="${product.price}"
                                type="number"
                                groupingUsed="true"
                                maxFractionDigits="0" />
                        ₫
                    </div>

                </div>

            </c:forEach>

        </div>

    </div>

</section>

<section id="contact" class="contact-section">

    <div class="container">

        <div class="contact-heading">

            <span class="contact-eyebrow">
                CONTACT
            </span>

            <h2>
                Liên hệ với chúng tôi
            </h2>

            <p>
                Nếu bạn có câu hỏi về sản phẩm hoặc tài khoản,
                hãy liên hệ với chúng tôi.
            </p>

        </div>

        <div class="contact-grid">

            <article class="contact-card">

                <div class="contact-icon">
                    <i class="bi bi-telephone"></i>
                </div>

                <h3>
                    Phone
                </h3>

                <p>
                    +84 123 456 789
                </p>

            </article>

            <article class="contact-card">

                <div class="contact-icon">
                    <i class="bi bi-envelope"></i>
                </div>

                <h3>
                    Email
                </h3>

                <p>
                    support@techstore.vn
                </p>

            </article>

            <article class="contact-card">

                <div class="contact-icon">
                    <i class="bi bi-geo-alt"></i>
                </div>

                <h3>
                    Address
                </h3>

                <p>
                    TP. Hồ Chí Minh, Việt Nam
                </p>

            </article>

        </div>

    </div>

</section>

</body>

</html>
