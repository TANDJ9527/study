<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN" class="course-study-page">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.course_name} - 在线学习 - 考研学习平台</title>
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
            <span>在线学习</span>
        </div>

        <div class="study-content">
            <div class="video-player">
                <div class="video-placeholder">
                    <div class="video-title">${course.course_name}</div>
                    <p>视频播放区域</p>
                    <p>（此处应嵌入实际的视频播放器）</p>
                </div>
            </div>

            <div class="course-info">
                <div class="course-header">
                    <div class="course-name">${course.course_name}</div>
                    <div class="course-price">
                        <c:choose>
                            <c:when test="${course.price > 0}">
                                ¥<fmt:formatNumber value="${course.price}" pattern="0.00"/>
                            </c:when>
                            <c:otherwise>
                                免费课程
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="progress-section">
                    <div class="progress-title">学习进度</div>
                    <div class="progress-bar">
                        <div class="progress-fill"></div>
                    </div>
                    <div class="progress-text">已完成 5/15 个章节 (35%)</div>
                </div>

                <div class="chapter-list">
                    <div class="chapter-title">课程章节</div>
                    <div class="chapter-item active">
                        <div class="chapter-name">第1章 课程介绍</div>
                        <div class="chapter-duration">15分钟</div>
                    </div>
                    <div class="chapter-item">
                        <div class="chapter-name">第2章 基础知识</div>
                        <div class="chapter-duration">30分钟</div>
                    </div>
                    <div class="chapter-item">
                        <div class="chapter-name">第3章 核心概念</div>
                        <div class="chapter-duration">45分钟</div>
                    </div>
                    <div class="chapter-item">
                        <div class="chapter-name">第4章 实例分析</div>
                        <div class="chapter-duration">35分钟</div>
                    </div>
                    <div class="chapter-item">
                        <div class="chapter-name">第5章 总结与练习</div>
                        <div class="chapter-duration">20分钟</div>
                    </div>
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
