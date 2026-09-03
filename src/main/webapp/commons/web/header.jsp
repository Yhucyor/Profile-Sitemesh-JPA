<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header>

    <nav>

        <a href="${pageContext.request.contextPath}/home">
            Home
        </a>

        |

        <a href="${pageContext.request.contextPath}/product">
            Product
        </a>

        |

        <c:choose>

            <%-- Đã đăng nhập --%>
            <c:when test="${sessionScope.account != null}">

                <%-- Hiển thị avatar nếu có --%>
                <c:if test="${not empty sessionScope.account.avatar}">
                    <img 
                        src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar}"
                        alt="Avatar"
                        style="width: 30px; height: 30px; border-radius: 50%; object-fit: cover; vertical-align: middle; margin-right: 5px;"
                        onerror="this.style.display='none'">
                </c:if>

                <span>
                    Xin chào,
                    ${sessionScope.account.username}
                </span>

                |

                <a href="${pageContext.request.contextPath}/profile">
                    Profile
                </a>

                |

                <a href="${pageContext.request.contextPath}/logout">
                    Logout
                </a>

            </c:when>


            <%-- Chưa đăng nhập --%>
            <c:otherwise>

                <a href="${pageContext.request.contextPath}/login">
                    Login
                </a>

                |

                <a href="${pageContext.request.contextPath}/register">
                    Register
                </a>

            </c:otherwise>

        </c:choose>

    </nav>

    <hr>

</header>