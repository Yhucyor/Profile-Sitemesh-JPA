<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>
        <sitemesh:write property="title"/>
    </title>

    <%-- RẤT QUAN TRỌNG:
         đưa CSS trong category-list.jsp vào đây --%>
    <sitemesh:write property="head"/>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f6fa;
        }

        /* HEADER */
        .admin-header {
            height: 65px;
            background: white;
            border-bottom: 1px solid #ddd;

            display: flex;
            justify-content: space-between;
            align-items: center;

            padding: 0 30px;
        }

        .admin-brand {
            font-size: 20px;
            font-weight: bold;
        }

        .admin-user {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logout-link {
            color: red;
            text-decoration: none;
        }


        /* HEADER + SIDEBAR CONTENT */
        .admin-wrapper {
            display: flex;

            min-height: calc(100vh - 125px);
        }


        /* SIDEBAR */
        .admin-sidebar {
            width: 230px;
            flex-shrink: 0;

            background: white;
            border-right: 1px solid #ddd;

            padding: 25px 20px;
        }

        .sidebar-title {
            font-weight: bold;
            margin-bottom: 20px;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar-menu li {
            margin-bottom: 10px;
        }

        .sidebar-menu a {
            display: block;

            padding: 12px;

            color: #333;
            text-decoration: none;

            border-radius: 6px;
        }

        .sidebar-menu a:hover {
            background: #eee;
        }


        /* CONTENT */
        .admin-content {
            flex: 1;
            min-width: 0;

            padding: 30px;

            overflow-x: auto;
        }


        /* FOOTER */
        .admin-footer {
            height: 60px;

            background: white;

            border-top: 1px solid #ddd;

            display: flex;
            justify-content: center;
            align-items: center;
        }

    </style>

</head>


<body>


<%@ include file="/commons/admin/header.jsp" %>


<div class="admin-wrapper">

    <%@ include file="/commons/admin/sidebar.jsp" %>


    <main class="admin-content">

        <sitemesh:write property="body"/>

    </main>

</div>


<%@ include file="/commons/admin/footer.jsp" %>


</body>

</html>