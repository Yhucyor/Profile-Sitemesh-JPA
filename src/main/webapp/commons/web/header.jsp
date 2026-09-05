<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="headerPath"
       value="${pageContext.request.requestURI}" />

<%-- =========================================
     TOP BAR
     ========================================= --%>

<div class="shop-topbar">
    <div class="container">

        <div class="d-flex justify-content-between align-items-center">

            <div class="shop-topbar-left">

                <span class="me-3">
                    <i class="bi bi-telephone-fill"></i>
                    +84 123 456 789
                </span>

                <span class="d-none d-md-inline">
                    <i class="bi bi-envelope"></i>
                    support@techstore.vn
                </span>

            </div>

            <div class="shop-topbar-right">

                <c:choose>

                    <c:when test="${not empty sessionScope.account}">

                        <a href="${pageContext.request.contextPath}/profile">
                            <i class="bi bi-person-fill"></i>
                            My Account
                        </a>

                        <span class="topbar-separator"></span>

                        <a href="${pageContext.request.contextPath}/profile">
                            Profile
                        </a>

                        <span class="topbar-separator"></span>

                        <a href="${pageContext.request.contextPath}/logout">
                            <i class="bi bi-box-arrow-right"></i>
                            Log Out
                        </a>

                    </c:when>

                    <c:otherwise>

                        <a href="${pageContext.request.contextPath}/login">
                            <i class="bi bi-person-fill"></i>
                            Log In
                        </a>

                        <span class="topbar-separator"></span>

                        <a href="${pageContext.request.contextPath}/register">
                            <i class="bi bi-person-plus"></i>
                            Register
                        </a>

                    </c:otherwise>

                </c:choose>

            </div>

        </div>

    </div>
</div>


<%-- =========================================
     MAIN HEADER
     ========================================= --%>

<header class="shop-header">

    <nav class="navbar navbar-expand-lg navbar-light">

        <div class="container">

            <a class="navbar-brand shop-logo"
               href="${pageContext.request.contextPath}/home">

                <span class="shop-logo-primary">
                    TECH
                </span>

                <span class="shop-logo-secondary">
                    STORE
                </span>

                <small>
                    TECHNOLOGY FOR A BRIGHTER TOMORROW
                </small>

            </a>

            <button
                    class="navbar-toggler"
                    type="button"
                    data-bs-toggle="collapse"
                    data-bs-target="#shopNavbar"
                    aria-controls="shopNavbar"
                    aria-expanded="false"
                    aria-label="Toggle navigation">

                <span class="navbar-toggler-icon"></span>

            </button>

            <div class="collapse navbar-collapse"
                 id="shopNavbar">

                <ul class="navbar-nav mx-auto mb-2 mb-lg-0">

                    <li class="nav-item">

                        <a class="nav-link ${fn:contains(headerPath, '/home') ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/home">

                            HOME

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link ${fn:contains(headerPath, '/product') ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/product">

                            PRODUCTS

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link ${fn:contains(headerPath, '/about') ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/about">

                            ABOUT

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/home#contact">

                            CONTACT

                        </a>

                    </li>

                    <c:if test="${not empty sessionScope.account}">

                        <li class="nav-item d-lg-none">

                            <a class="nav-link"
                               href="${pageContext.request.contextPath}/profile">

                                PROFILE

                            </a>

                        </li>

                    </c:if>

                </ul>

                <div class="shop-header-tools">

                    <form class="shop-search"
                          action="${pageContext.request.contextPath}/product"
                          method="get">

                        <button type="submit"
                                aria-label="Search products">
                            <i class="bi bi-search"></i>
                        </button>

                        <input type="search"
                               name="keyword"
                               placeholder="Search products, brands, categories...">

                    </form>

                    <span class="shop-tool-divider"></span>

                    <div class="shop-header-actions">

                    <c:choose>

                        <c:when test="${not empty sessionScope.account}">

                            <div class="dropdown shop-action-cell">

                                <a
                                        class="shop-account-icon dropdown-toggle"
                                        href="#"
                                        role="button"
                                        data-bs-toggle="dropdown"
                                        title="My account"
                                        aria-expanded="false">

                                    <c:choose>

                                        <c:when test="${not empty sessionScope.account.avatar}">

                                            <c:choose>

                                                <c:when test="${
                                                    fn:startsWith(
                                                        sessionScope.account.avatar,
                                                        'http://'
                                                    )
                                                    or
                                                    fn:startsWith(
                                                        sessionScope.account.avatar,
                                                        'https://'
                                                    )
                                                }">

                                                    <img
                                                            src="${sessionScope.account.avatar}"
                                                            class="shop-avatar"
                                                            alt="Avatar">

                                                </c:when>

                                                <c:otherwise>

                                                    <img
                                                            src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar}"
                                                            class="shop-avatar"
                                                            alt="Avatar"
                                                            onerror="this.style.display='none'">

                                                </c:otherwise>

                                            </c:choose>

                                        </c:when>

                                        <c:otherwise>

                                            <span class="shop-avatar-placeholder">
                                                <i class="bi bi-person-circle"></i>
                                            </span>

                                        </c:otherwise>

                                    </c:choose>

                                </a>

                                <ul class="dropdown-menu dropdown-menu-end shop-account-menu">

                                    <li>

                                        <div class="account-menu-header">

                                            <strong>
                                                ${sessionScope.account.username}
                                            </strong>

                                            <c:if test="${not empty sessionScope.account.email}">

                                                <small>
                                                    ${sessionScope.account.email}
                                                </small>

                                            </c:if>

                                        </div>

                                    </li>

                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>

                                    <li>

                                        <a
                                                class="dropdown-item"
                                                href="${pageContext.request.contextPath}/profile">

                                            <i class="bi bi-person-circle me-2"></i>
                                            Profile

                                        </a>

                                    </li>

                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>

                                    <li>

                                        <a
                                                class="dropdown-item text-danger"
                                                href="${pageContext.request.contextPath}/logout">

                                            <i class="bi bi-box-arrow-right me-2"></i>
                                            Logout

                                        </a>

                                    </li>

                                </ul>

                            </div>

                        </c:when>

                        <c:otherwise>

                            <a class="shop-action-cell"
                               href="${pageContext.request.contextPath}/login"
                               title="Login">
                                <i class="bi bi-person-circle"></i>
                            </a>

                        </c:otherwise>

                    </c:choose>

                    <a class="shop-action-cell"
                       href="#"
                       title="Wishlist">
                        <i class="bi bi-heart"></i>
                        <span class="shop-action-badge">0</span>
                    </a>

                    <a class="shop-action-cell"
                       href="${pageContext.request.contextPath}/cart"
                       title="Cart">
                        <i class="bi bi-cart3"></i>
                        <span class="shop-action-badge">0</span>
                    </a>

                    </div>

                </div>

            </div>

        </div>

    </nav>

</header>
