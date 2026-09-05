<%@ page
        language="java"
        contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        <sitemesh:write property="title"/>
    </title>


    <%-- =========================
         BOOTSTRAP 5
         ========================= --%>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">


    <%-- Bootstrap Icons --%>

    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <%-- =========================
         CSS RIÊNG CỦA PROJECT
         ========================= --%>

    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/assets/frontend/css/style.css?v=20260905-about-font">


    <%-- CSS/head riêng của từng trang nếu có --%>

    <sitemesh:write property="head"/>

</head>


<body class="d-flex flex-column min-vh-100">


    <%-- =========================
         HEADER CHUNG
         ========================= --%>

    <%@ include file="/commons/web/header.jsp" %>


    <%-- =========================
         BREADCRUMB
         ========================= --%>

    <%@ include file="/commons/web/breadcrumb.jsp" %>


    <%-- =========================
         CONTENT RIÊNG
         ========================= --%>

    <main class="flex-grow-1">

        <sitemesh:write property="body"/>

    </main>


    <%-- =========================
         FOOTER CHUNG
         ========================= --%>

    <%@ include file="/commons/web/footer.jsp" %>


    <%-- =========================
         BOOTSTRAP JAVASCRIPT
         ========================= --%>

    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
    </script>


    <%-- JavaScript riêng của project --%>

    <script
            src="${pageContext.request.contextPath}/assets/frontend/js/main.js?v=20260905-about">
    </script>


</body>

</html>
