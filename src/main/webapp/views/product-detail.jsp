<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<title>${product.productName}</title>

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
    </c:when>
    <c:otherwise>
        <c:set var="imageUrl"
               value="" />
    </c:otherwise>
</c:choose>

<section class="product-detail-page">

    <div class="container">

        <div class="product-detail-layout">

            <div class="product-detail-gallery">

                <c:choose>
                    <c:when test="${not empty imageUrl}">
                        <img src="${imageUrl}"
                             class="product-detail-image"
                             alt="${product.productName}">
                    </c:when>
                    <c:otherwise>
                        <div class="product-detail-no-image">
                            Chưa có ảnh
                        </div>
                    </c:otherwise>
                </c:choose>

                <div class="product-detail-thumbs">
                    <c:forEach begin="1"
                               end="3">
                        <c:choose>
                            <c:when test="${not empty imageUrl}">
                                <button type="button"
                                        class="product-detail-thumb">
                                    <img src="${imageUrl}"
                                         alt="${product.productName}">
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button type="button"
                                        class="product-detail-thumb product-detail-thumb-empty">
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>

            </div>

            <div class="product-detail-info">

                <h2>
                    ${product.productName}
                </h2>

                <div class="product-detail-price">
                    ${product.price} VNĐ
                </div>

                <div class="product-detail-meta">

                    <div>
                        <span>Category</span>
                        <strong>
                            <c:choose>
                                <c:when test="${not empty product.category}">
                                    ${product.category.categoryname}
                                </c:when>
                                <c:otherwise>
                                    Chưa có danh mục
                                </c:otherwise>
                            </c:choose>
                        </strong>
                    </div>

                    <div>
                        <span>Availability</span>
                        <strong>
                            <c:choose>
                                <c:when test="${product.status == 1 and product.quantity > 0}">
                                    In Stock
                                </c:when>
                                <c:otherwise>
                                    Out of Stock
                                </c:otherwise>
                            </c:choose>
                        </strong>
                    </div>

                    <div>
                        <span>Quantity</span>
                        <strong>
                            ${product.quantity}
                        </strong>
                    </div>

                </div>

                <div class="product-detail-description">
                    <c:choose>
                        <c:when test="${not empty product.description}">
                            ${product.description}
                        </c:when>
                        <c:otherwise>
                            Sản phẩm hiện chưa có mô tả chi tiết.
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="product-detail-buy">

                    <label for="detailQuantity">
                        Quantity:
                    </label>

                    <input type="number"
                           id="detailQuantity"
                           min="1"
                           value="1">

                    <a href="${pageContext.request.contextPath}/cart"
                       class="product-detail-cart-btn">
                        ADD TO CART
                    </a>

                    <button type="button"
                            class="product-detail-icon-btn"
                            aria-label="Compare">
                        <i class="bi bi-gem"></i>
                    </button>

                    <button type="button"
                            class="product-detail-icon-btn"
                            aria-label="Wishlist">
                        <i class="bi bi-heart"></i>
                    </button>

                </div>

            </div>

        </div>

        <div class="product-detail-tabs">

            <div class="product-detail-tab-nav">
                <button type="button">Description</button>
                <button type="button">Specification</button>
                <button type="button">Comments</button>
                <button type="button" class="active">Reviews</button>
            </div>

            <div class="product-detail-review-area">

                <div class="product-review-summary">
                    <h3>Overall</h3>
                    <strong>4.0</strong>
                    <span>(03 Reviews)</span>
                </div>

                <div class="product-review-list">
                    <h3>Based on 3 Reviews</h3>
                    <p>5 Star <span>★★★★★</span> 01</p>
                    <p>4 Star <span>★★★★☆</span> 01</p>
                    <p>3 Star <span>★★★☆☆</span> 01</p>
                    <p>2 Star <span>★★☆☆☆</span> 00</p>
                    <p>1 Star <span>★☆☆☆☆</span> 00</p>
                </div>

                <div class="product-review-form">
                    <h3>Add a Review</h3>
                    <p>
                        Your Rating:
                        <span>★★★★★</span>
                        Outstanding
                    </p>
                    <input type="text" placeholder="Your Full name">
                    <input type="email" placeholder="Email Address">
                    <input type="text" placeholder="Phone Number">
                    <textarea placeholder="Review"></textarea>
                </div>

            </div>

        </div>

    </div>

</section>
