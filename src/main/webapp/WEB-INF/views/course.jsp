<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN" class="course-page">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>课程中心 - 考研学习平台</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<!-- 页面头部 -->
<header class="header">
    <div class="container">
        <div class="logo">
            <h1>考研学习平台</h1>
        </div>
        <nav class="nav">
            <ul>
                <li><a href="${pageContext.request.contextPath}/home/index">首页</a></li>
                <li><a href="${pageContext.request.contextPath}/home/course" class="active">课程中心</a></li>
                <li><a href="${pageContext.request.contextPath}/home/question">题库练习</a></li>
                <li><a href="${pageContext.request.contextPath}/home/exam">模拟考试</a></li>
                <li><a href="${pageContext.request.contextPath}/home/forum">学习社区</a></li>
            </ul>
        </nav>
        <div class="user-info">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <span>欢迎, ${sessionScope.user.username}</span>
                    <a href="${pageContext.request.contextPath}/user/logout">退出</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/login">登录</a>
                    <a href="${pageContext.request.contextPath}/user/register">注册</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<!-- 主要内容区域 -->
<main class="main">
    <div class="container">
        <h1 class="page-title">课程中心</h1>

        <!-- 数据库信息提示 -->
        <div class="db-info">
            <c:choose>
                <c:when test="${not empty courses}">${courses.size()} 条</c:when>
                <c:otherwise>0 条</c:otherwise>
            </c:choose>
        </div>

        <!-- 课程列表 -->
        <div class="course-list">
            <c:choose>
                <c:when test="${not empty courses}">
                    <c:forEach var="course" items="${courses}">
                        <div class="course-card">
                            <div class="course-header">
                                课程ID: ${course.id}
                                课程名称: ${course.course_name}
                            </div>
                            <div class="course-body">
                                <h3 class="course-title">${course.course_name}</h3>
                                <p class="course-description">
                                    <c:choose>
                                        <c:when test="${not empty course.description}">
                                            <c:choose>
                                                <c:when test="${course.description.length() > 100}">
                                                    ${course.description.substring(0, 100)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${course.description}
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            暂无课程描述
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <div class="course-actions">
                                    <span class="course-price">
                                        <c:choose>
                                            <c:when test="${course.price > 0}">
                                                ¥<fmt:formatNumber value="${course.price}" pattern="0.00"/>
                                            </c:when>
                                            <c:otherwise>
                                                免费
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <div>
                                        <a href="${pageContext.request.contextPath}/home/course/study?id=${course.id}" class="btn">学习</a>
                                        <a href="${pageContext.request.contextPath}/home/course/detail?id=${course.id}" class="btn btn-outline">详情</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <h3>暂无课程</h3>
                        <p>还没有任何课程数据</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>

<!-- 页面底部 -->
<footer class="footer">
    <div class="container">
        <p>&copy; 2023 考研学习平台. 数据库: blog_db</p>
    </div>
</footer>

<script>
    // 简单的交互效果
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.course-card');
        cards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
                this.style.transition = 'transform 0.3s';
            });
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
    });
</script>
</body>
</html>