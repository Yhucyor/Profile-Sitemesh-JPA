<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="requestPath"
       value="${pageContext.request.requestURI}" />

<c:set var="pageTitle"
       value="Home" />

<c:if test="${not empty breadcrumbTitle}">
    <c:set var="pageTitle"
           value="${breadcrumbTitle}" />
</c:if>

<c:choose>
    <c:when test="${not empty breadcrumbTitle}">
    </c:when>

    <c:when test="${fn:contains(requestPath, '/product/detail')}">
        <c:choose>
            <c:when test="${not empty product}">
                <c:set var="pageTitle"
                       value="${product.productName}" />
            </c:when>
            <c:otherwise>
                <c:set var="pageTitle"
                       value="Product Detail" />
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:when test="${fn:endsWith(requestPath, '/product')}">
        <c:set var="pageTitle"
               value="Products" />
    </c:when>

    <c:when test="${fn:contains(requestPath, '/profile')}">
        <c:set var="pageTitle"
               value="Profile" />
    </c:when>

    <c:when test="${fn:contains(requestPath, '/about')}">
        <c:set var="pageTitle"
               value="About" />
    </c:when>

    <c:when test="${fn:contains(requestPath, '/cart')}">
        <c:set var="pageTitle"
               value="Cart" />
    </c:when>

    <c:when test="${fn:contains(requestPath, '/login')}">
        <c:set var="pageTitle"
               value="Login" />
    </c:when>

    <c:when test="${fn:contains(requestPath, '/register')}">
        <c:set var="pageTitle"
               value="Register" />
    </c:when>

    <c:when test="${fn:contains(requestPath, '/forgot-password/verify')}">
        <c:set var="pageTitle"
               value="Verify Reset OTP" />
    </c:when>

    <c:when test="${fn:contains(requestPath, '/forgot-password')}">
        <c:set var="pageTitle"
               value="Forgot Password" />
    </c:when>

    <c:when test="${fn:contains(requestPath, '/verify-otp')}">
        <c:set var="pageTitle"
               value="Verify OTP" />
    </c:when>

    <c:when test="${fn:contains(requestPath, '/reset-password')}">
        <c:set var="pageTitle"
               value="Reset Password" />
    </c:when>
</c:choose>

<section class="shop-breadcrumb">

    <div class="container">

        <nav aria-label="breadcrumb">

            <ol class="breadcrumb mb-0">

                <c:choose>
                    <c:when test="${pageTitle == 'Home' and empty breadcrumbParentLabel}">
                        <li class="breadcrumb-item active"
                            aria-current="page">
                            Home
                        </li>
                    </c:when>

                    <c:otherwise>
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/home">
                                <i class="bi bi-house-door"></i>
                                Home
                            </a>
                        </li>

                        <c:if test="${not empty breadcrumbParentLabel}">
                            <li class="breadcrumb-item">
                                <a href="${breadcrumbParentUrl}">
                                    ${breadcrumbParentLabel}
                                </a>
                            </li>
                        </c:if>

                        <c:if test="${empty breadcrumbParentLabel
                                and fn:contains(requestPath, '/product/detail')}">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/product">
                                    Products
                                </a>
                            </li>
                        </c:if>

                        <li class="breadcrumb-item active"
                            aria-current="page">
                            ${pageTitle}
                        </li>
                    </c:otherwise>
                </c:choose>

            </ol>

        </nav>

        <h1 class="shop-page-title mb-0">
            ${pageTitle}
        </h1>

    </div>

</section>
