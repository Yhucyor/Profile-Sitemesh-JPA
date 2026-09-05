<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<title>Giỏ hàng</title>

<section class="cart-page">

    <div class="container">

        <div class="cart-table">

            <div class="cart-row cart-head">
                <div class="cart-check">
                    <input type="checkbox"
                           class="cart-select-all">
                </div>
                <div class="cart-product-title">Sản Phẩm</div>
                <div>Đơn Giá</div>
                <div>Số Lượng</div>
                <div>Số Tiền</div>
                <div>Thao Tác</div>
            </div>

            <c:choose>
                <c:when test="${empty cartProducts}">
                    <div class="cart-empty">
                        <i class="bi bi-cart-x"></i>
                        <h2>Giỏ hàng đang trống</h2>
                        <p>Hãy chọn thêm sản phẩm phù hợp với bạn.</p>
                        <a href="${pageContext.request.contextPath}/product">
                            Tiếp tục mua hàng
                        </a>
                    </div>
                </c:when>

                <c:otherwise>
                    <c:forEach items="${cartProducts}"
                               var="product">

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

                        <div class="cart-shop-row">
                            <div class="cart-check">
                                <input type="checkbox"
                                       class="cart-shop-check">
                            </div>
                            <div class="cart-shop-name">
                                <i class="bi bi-shop"></i>
                                TechStore
                            </div>
                        </div>

                        <div class="cart-row cart-item-row"
                             data-price="${product.price}">
                            <div class="cart-check">
                                <input type="checkbox"
                                       class="cart-item-check">
                            </div>

                            <div class="cart-product">
                                <a href="${pageContext.request.contextPath}/product/detail?id=${product.productId}"
                                   class="cart-product-image">
                                    <c:choose>
                                        <c:when test="${not empty imageUrl}">
                                            <img src="${imageUrl}"
                                                 alt="${product.productName}"
                                                 loading="lazy"
                                                 decoding="async">
                                        </c:when>
                                        <c:otherwise>
                                            <span>Chưa có ảnh</span>
                                        </c:otherwise>
                                    </c:choose>
                                </a>

                                <div>
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${product.productId}"
                                       class="cart-product-name">
                                        ${product.productName}
                                    </a>
                                    <p>
                                        <c:choose>
                                            <c:when test="${not empty product.category}">
                                                Phân loại: ${product.category.categoryname}
                                            </c:when>
                                            <c:otherwise>
                                                Phân loại: Chưa cập nhật
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>

                            <div class="cart-price">
                                ${product.price} VNĐ
                            </div>

                            <div class="cart-quantity">
                                <button type="button"
                                        class="cart-qty-minus">-</button>
                                <input type="text"
                                       class="cart-qty-input"
                                       value="1"
                                       readonly>
                                <button type="button"
                                        class="cart-qty-plus">+</button>
                            </div>

                            <div class="cart-subtotal">
                                ${product.price} VNĐ
                            </div>

                            <div class="cart-actions">
                                <a href="#"
                                   class="cart-remove-item">Xóa</a>
                                <a href="${pageContext.request.contextPath}/product">
                                    Tìm sản phẩm tương tự
                                </a>
                            </div>
                        </div>

                        <div class="cart-service-row">
                            <i class="bi bi-ticket-perforated"></i>
                            Voucher giảm đến 23%
                            <a href="#">Xem thêm voucher</a>
                        </div>

                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </div>

        <c:if test="${not empty cartProducts}">
            <div class="cart-checkout-bar">
                <label>
                    <input type="checkbox"
                           class="cart-select-all">
                    Chọn Tất Cả
                    <span class="cart-total-count">
                        (${fn:length(cartProducts)})
                    </span>
                </label>

                <a href="#"
                   class="cart-remove-selected">Xóa</a>

                <div class="cart-checkout-total">
                    Tổng cộng
                    <span class="cart-selected-count">
                        (${fn:length(cartProducts)} sản phẩm)
                    </span>:
                    <strong class="cart-total-amount">
                        ${cartTotal} VNĐ
                    </strong>
                </div>

                <button type="button"
                        class="cart-checkout-button">
                    Mua Hàng
                </button>
            </div>
        </c:if>

    </div>

</section>
