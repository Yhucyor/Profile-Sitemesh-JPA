<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<aside class="admin-sidebar">

    <h3 class="sidebar-title">QUẢN LÝ</h3>

    <ul class="sidebar-menu">

        <li>

            <a href="${pageContext.request.contextPath}/admin/categories">

                Category

            </a>

        </li>


        <li>

            <a href="${pageContext.request.contextPath}/admin/products">

                Product

            </a>

        </li>


        <li>

            <a href="${pageContext.request.contextPath}/home">

                Trang chủ

            </a>

        </li>

    </ul>

    <hr style="border: none; border-top: 1px solid #ddd; margin: 20px 0;">

    <h3 class="sidebar-title">TÀI KHOẢN</h3>

    <ul class="sidebar-menu">

        <li>

            <a href="${pageContext.request.contextPath}/profile">

                <span style="margin-right: 5px;">👤</span> Hồ sơ cá nhân

            </a>

        </li>

        <li>

            <a href="${pageContext.request.contextPath}/logout" style="color: #e74c3c;">

                <span style="margin-right: 5px;">🚪</span> Đăng xuất

            </a>

        </li>

    </ul>

</aside>