<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN" class="course-detail-page">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.course_name} - 课程详情 - 考研学习平台</title>
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
            </ul>
        </nav>
    </div>
</header>

<!-- 主要内容区域 -->
<main class="main">
    <div class="container">
        <!-- 面包屑导航 -->
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/home/index">首页</a>
            <span>/</span>
            <a href="${pageContext.request.contextPath}/home/course">课程中心</a>
            <span>/</span>
            <span>课程详情</span>
        </div>

        <div class="course-detail-card">
            <div class="course-header">
                <h1 class="course-title">${course.course_name}</h1>
                <div class="course-meta">
                    <div class="course-id">课程ID: ${course.id}</div>
                    <div class="course-name">课程名称: ${course.course_name}</div>
                    <div class="course-price">
                        <c:choose>
                            <c:when test="${course.price > 0}">
                                ¥<fmt:formatNumber value="${course.price}" pattern="0.00"/>
                            </c:when>
                            <c:otherwise>
                                免费
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="course-body">
                <div class="section">
                    <h2 class="section-title">课程介绍</h2>
                    <div class="section-content">
                        <c:choose>
                            <c:when test="${not empty course.description}">
                                ${course.description}
                            </c:when>
                            <c:otherwise>
                                <p>暂无课程详细介绍</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="actions">
                    <a href="${pageContext.request.contextPath}/home/course/study?id=${course.id}" class="btn btn-success">开始学习</a>
                    <a href="${pageContext.request.contextPath}/home/course" class="btn btn-outline">返回课程中心</a>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- 页面底部 -->
<footer class="footer">
    <div class="container">
        <p>&copy; 2027 考研学习平台. </p>
    </div>
</footer>
</body>
</html>
