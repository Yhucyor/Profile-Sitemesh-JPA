<%@ page
        language="java"
        contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>
        <sitemesh:write property="title"/>
    </title>

    <!-- CSS / head riêng của từng trang -->
    <sitemesh:write property="head"/>

</head>

<body>

    <!-- HEADER dùng chung -->
    <%@ include file="/commons/web/header.jsp" %>


    <!-- CONTENT riêng -->
    <main>

        <sitemesh:write property="body"/>

    </main>


    <!-- FOOTER dùng chung -->
    <%@ include file="/commons/web/footer.jsp" %>

</body>

</html>