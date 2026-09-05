<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<title>About TechStore</title>

<main class="about-page">

    <section class="about-hero">

        <div class="about-hero-content reveal">

            <p class="about-label">
                ABOUT TECHSTORE
            </p>

            <h1 class="about-hero-title">
                Công nghệ tốt hơn
                <span>
                    bắt đầu từ một trải nghiệm tốt hơn.
                </span>
            </h1>

            <p class="about-hero-description">
                TechStore được xây dựng với mục tiêu tạo nên
                một không gian mua sắm công nghệ đơn giản,
                hiện đại và dễ sử dụng.
            </p>

            <a href="#our-story"
               class="about-discover-link">
                <span>Khám phá câu chuyện của chúng tôi</span>
                <i class="bi bi-arrow-down"></i>
            </a>

        </div>

        <div class="about-hero-image reveal">

            <img
                    src="${pageContext.request.contextPath}/assets/frontend/images/slider/slide-1.jpg"
                    alt="TechStore technology"
                    loading="lazy"
                    decoding="async">

            <div class="about-image-caption">
                <span>TECHSTORE</span>
                <p>Technology for a Better Tomorrow</p>
            </div>

        </div>

    </section>

    <section class="about-story-section"
             id="our-story">

        <div class="about-story-heading reveal">

            <p class="about-label">
                OUR STORY
            </p>

            <h2>
                Một website được xây dựng từ sự đơn giản.
            </h2>

        </div>

        <div class="about-story-content reveal">

            <p class="about-story-lead">
                TechStore không chỉ là nơi hiển thị sản phẩm.
            </p>

            <p>
                Đây là một hệ thống quản lý và giới thiệu sản phẩm
                công nghệ được xây dựng nhằm mang lại trải nghiệm
                trực quan cho người dùng và khả năng quản lý thuận tiện
                cho quản trị viên.
            </p>

            <p>
                Từ việc khám phá sản phẩm mới nhất, xem thông tin chi tiết,
                quản lý danh mục đến cập nhật sản phẩm, mọi thành phần
                đều hướng đến một giao diện rõ ràng và nhất quán.
            </p>

        </div>

    </section>

    <section class="about-belief-section">

        <div class="about-belief-header reveal">

            <p class="about-label about-label-light">
                WHAT WE BELIEVE
            </p>

            <h2>
                Những điều tạo nên TechStore.
            </h2>

        </div>

        <div class="about-belief-list">

            <article class="about-belief-item reveal">
                <span class="about-belief-number">01</span>
                <div class="about-belief-content">
                    <h3>Đơn giản</h3>
                    <p>
                        Giao diện được thiết kế để người dùng nhanh chóng
                        tìm thấy thông tin họ cần.
                    </p>
                </div>
            </article>

            <article class="about-belief-item reveal">
                <span class="about-belief-number">02</span>
                <div class="about-belief-content">
                    <h3>Hiện đại</h3>
                    <p>
                        Màu sắc, khoảng trắng, typography và chuyển động
                        được kết hợp để tạo trải nghiệm web hiện đại.
                    </p>
                </div>
            </article>

            <article class="about-belief-item reveal">
                <span class="about-belief-number">03</span>
                <div class="about-belief-content">
                    <h3>Nhất quán</h3>
                    <p>
                        Từ trang chủ, sản phẩm, hồ sơ cá nhân đến khu vực
                        quản trị, hệ thống dùng cùng một ngôn ngữ thiết kế.
                    </p>
                </div>
            </article>

        </div>

    </section>

    <section class="about-vision-section">

        <div class="about-vision-background">
            <img
                    src="${pageContext.request.contextPath}/assets/frontend/images/slider/slide-2.jpg"
                    alt="Technology vision"
                    loading="lazy"
                    decoding="async">
        </div>

        <div class="about-vision-content reveal">

            <p class="about-label about-label-light">
                OUR VISION
            </p>

            <h2>
                Technology for
                <span>a Better Tomorrow.</span>
            </h2>

            <p>
                Một trải nghiệm số tốt không cần phải phức tạp.
                Nó cần rõ ràng, hữu ích và được thiết kế xoay quanh
                người sử dụng.
            </p>

        </div>

    </section>

    <section class="about-technology-section">

        <div class="about-technology-heading reveal">

            <p class="about-label">
                BEHIND TECHSTORE
            </p>

            <h2>
                Công nghệ phía sau hệ thống.
            </h2>

        </div>

        <div class="about-technology-grid">

            <article class="about-technology-item reveal">
                <span>01</span>
                <h3>Servlet & JSP</h3>
                <p>Xử lý request, response và xây dựng giao diện server-side.</p>
            </article>

            <article class="about-technology-item reveal">
                <span>02</span>
                <h3>JPA</h3>
                <p>Quản lý dữ liệu Product, Category và các entity chính.</p>
            </article>

            <article class="about-technology-item reveal">
                <span>03</span>
                <h3>SiteMesh 3</h3>
                <p>Tạo layout thống nhất giữa header, nội dung và footer.</p>
            </article>

            <article class="about-technology-item reveal">
                <span>04</span>
                <h3>Bootstrap 5</h3>
                <p>Hỗ trợ xây dựng giao diện responsive trên nhiều màn hình.</p>
            </article>

        </div>

    </section>

    <section class="about-final-section">

        <div class="about-final-content reveal">

            <p class="about-label">
                TECHSTORE
            </p>

            <h2>
                Đơn giản hơn.
                <br>
                Nhanh hơn.
                <br>
                <span>Tốt hơn.</span>
            </h2>

            <a href="${pageContext.request.contextPath}/product"
               class="about-final-link">
                Khám phá sản phẩm
                <i class="bi bi-arrow-right"></i>
            </a>

        </div>

    </section>

</main>
