<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="vi_VN" />

<title>Danh sách sản phẩm</title>

<section class="catalog-page">

    <div class="container">

        <div class="catalog-layout">

            <aside class="catalog-sidebar">

                <div class="catalog-widget">

                    <h3>BROWSE CATEGORIES</h3>

                    <ul class="catalog-category-list">
                        <li><a href="${pageContext.request.contextPath}/product">Laptop</a></li>
                        <li><a href="${pageContext.request.contextPath}/product">Smartphone</a></li>
                        <li><a href="${pageContext.request.contextPath}/product">Smartwatch</a></li>
                        <li><a href="${pageContext.request.contextPath}/product">Headphone</a></li>
                        <li><a href="${pageContext.request.contextPath}/product">Accessories</a></li>
                    </ul>

                </div>

                <div class="catalog-widget">

                    <h3>PRODUCT FILTERS</h3>

                    <div class="catalog-filter-group">

                        <h4>Brand</h4>

                        <label><input type="radio" name="brand"> Apple</label>
                        <label><input type="radio" name="brand"> Asus</label>
                        <label><input type="radio" name="brand" checked> Samsung</label>
                        <label><input type="radio" name="brand"> Dell</label>
                        <label><input type="radio" name="brand"> Lenovo</label>

                    </div>

                    <div class="catalog-filter-group">

                        <h4>Color</h4>

                        <label><input type="radio" name="color"> Black</label>
                        <label><input type="radio" name="color"> White</label>
                        <label><input type="radio" name="color" checked> Sky blue</label>
                        <label><input type="radio" name="color"> Silver</label>
                        <label><input type="radio" name="color"> Gold</label>

                    </div>

                    <div class="catalog-filter-group">

                        <h4>Price</h4>

                        <input type="range"
                               min="10"
                               max="500"
                               value="180"
                               class="catalog-price-range">

                        <p class="catalog-price-label">
                            Price: $10 - $500
                        </p>

                    </div>

                </div>

            </aside>

            <div class="catalog-main">

                <div class="catalog-toolbar">

                    <div class="catalog-toolbar-left">

                        <select aria-label="Default sorting">
                            <option>Default sorting</option>
                            <option>Price low to high</option>
                            <option>Price high to low</option>
                        </select>

                        <select aria-label="Show products">
                            <option>Show 6</option>
                        </select>

                    </div>

                    <c:if test="${totalPages > 1}">
                        <div class="catalog-pagination catalog-pagination-top">
                            <c:choose>
                                <c:when test="${currentPage > 1}">
                                    <a href="${pageContext.request.contextPath}/product?page=${currentPage - 1}">
                                        <i class="bi bi-arrow-left"></i>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <span class="disabled"><i class="bi bi-arrow-left"></i></span>
                                </c:otherwise>
                            </c:choose>

                            <c:forEach begin="1"
                                       end="${totalPages}"
                                       var="pageNumber">
                                <c:choose>
                                    <c:when test="${pageNumber == currentPage}">
                                        <span class="active">${pageNumber}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/product?page=${pageNumber}">
                                            ${pageNumber}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:choose>
                                <c:when test="${currentPage < totalPages}">
                                    <a href="${pageContext.request.contextPath}/product?page=${currentPage + 1}">
                                        <i class="bi bi-arrow-right"></i>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <span class="disabled"><i class="bi bi-arrow-right"></i></span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>

                </div>

                <c:if test="${empty products}">
                    <p class="catalog-empty">
                        Hiện chưa có sản phẩm nào.
                    </p>
                </c:if>

                <div class="catalog-grid">

                    <c:forEach items="${products}"
                               var="product">

                        <div class="catalog-card">

                            <div class="catalog-card-media">
                                <a href="${pageContext.request.contextPath}/product/detail?id=${product.productId}"
                                   class="catalog-card-link"
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

                                        <img src="${imageUrl}"
                                             class="catalog-card-image"
                                             alt="${product.productName}"
                                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/frontend/images/product-default.svg';">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/frontend/images/product-default.svg"
                                             class="catalog-card-image"
                                             alt="Chưa có ảnh">
                                    </c:otherwise>
                                </c:choose>

                                </a>

                                <div class="catalog-card-actions">
                                    <a href="#"
                                       aria-label="Yêu thích">
                                        <i class="bi bi-heart"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/cart"
                                       aria-label="Giỏ hàng">
                                        <i class="bi bi-cart3"></i>
                                    </a>
                                </div>

                            </div>

                            <h3 class="catalog-card-name">
                                <a href="${pageContext.request.contextPath}/product/detail?id=${product.productId}">
                                    ${product.productName}
                                </a>
                            </h3>

                            <div class="catalog-card-price">
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

                <c:if test="${totalPages > 1}">
                    <div class="catalog-pagination catalog-pagination-bottom">
                        <c:choose>
                            <c:when test="${currentPage > 1}">
                                <a href="${pageContext.request.contextPath}/product?page=${currentPage - 1}">
                                    <i class="bi bi-chevron-left"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="disabled"><i class="bi bi-chevron-left"></i></span>
                            </c:otherwise>
                        </c:choose>

                        <c:forEach begin="1"
                                   end="${totalPages}"
                                   var="pageNumber">
                            <c:choose>
                                <c:when test="${pageNumber == currentPage}">
                                    <span class="active">${pageNumber}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/product?page=${pageNumber}">
                                        ${pageNumber}
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <c:choose>
                            <c:when test="${currentPage < totalPages}">
                                <a href="${pageContext.request.contextPath}/product?page=${currentPage + 1}">
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="disabled"><i class="bi bi-chevron-right"></i></span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

            </div>

        </div>

    </div>

</section>
