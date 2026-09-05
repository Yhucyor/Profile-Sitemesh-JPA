<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<footer class="shop-footer">

    <div class="container">

        <div class="shop-footer-grid">

            <div class="shop-footer-column">

                <h3>
                    TechStore
                </h3>

                <p>
                    TechStore Product Management helps you browse,
                    manage and organize technology products with a clean,
                    simple shopping experience.
                </p>

            </div>

            <div class="shop-footer-column shop-footer-newsletter">

                <h3>
                    Newsletter
                </h3>

                <p>
                    Stay updated with our newest products and offers.
                </p>

                <form action="#"
                      method="post"
                      class="shop-newsletter-form">

                    <input type="email"
                           name="email"
                           placeholder="Email Address"
                           aria-label="Email Address">

                    <button type="submit"
                            aria-label="Subscribe">
                        <i class="bi bi-arrow-right"></i>
                    </button>

                </form>

            </div>

            <div class="shop-footer-column">

                <h3>
                    Instagram Feed
                </h3>

                <div class="shop-instagram-grid">

                    <a href="#"
                       class="shop-instagram-item feed-1"
                       aria-label="Tech product photo"></a>

                    <a href="#"
                       class="shop-instagram-item feed-2"
                       aria-label="Tech product photo"></a>

                    <a href="#"
                       class="shop-instagram-item feed-3"
                       aria-label="Tech product photo"></a>

                    <a href="#"
                       class="shop-instagram-item feed-4"
                       aria-label="Tech product photo"></a>

                    <a href="#"
                       class="shop-instagram-item feed-5"
                       aria-label="Tech product photo"></a>

                    <a href="#"
                       class="shop-instagram-item feed-6"
                       aria-label="Tech product photo"></a>

                    <a href="#"
                       class="shop-instagram-item feed-7"
                       aria-label="Tech product photo"></a>

                    <a href="#"
                       class="shop-instagram-item feed-8"
                       aria-label="Tech product photo"></a>

                </div>

            </div>

            <div class="shop-footer-column">

                <h3>
                    Follow Us
                </h3>

                <p>
                    Let us be social
                </p>

                <div class="shop-social-links">

                    <a href="#"
                       aria-label="Facebook">
                        <i class="bi bi-facebook"></i>
                    </a>

                    <a href="#"
                       aria-label="Twitter">
                        <i class="bi bi-twitter-x"></i>
                    </a>

                    <a href="#"
                       aria-label="Website">
                        <i class="bi bi-globe"></i>
                    </a>

                    <a href="#"
                       aria-label="LinkedIn">
                        <i class="bi bi-linkedin"></i>
                    </a>

                </div>

            </div>

        </div>

        <div class="shop-footer-bottom">

            <span>
                © 2026 TechStore Product Management
            </span>

            <div class="shop-footer-links">

                <a href="${pageContext.request.contextPath}/home">
                    Home
                </a>

                <a href="${pageContext.request.contextPath}/product">
                    Products
                </a>

                <a href="${pageContext.request.contextPath}/about">
                    About
                </a>

                <a href="${pageContext.request.contextPath}/home#contact">
                    Contact
                </a>

            </div>

        </div>

    </div>

</footer>
