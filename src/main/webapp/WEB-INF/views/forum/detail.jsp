<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${post.title} - 学习社区</title>
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
                <li><a href="${pageContext.request.contextPath}/home/course">课程中心</a></li>
                <li><a href="${pageContext.request.contextPath}/home/question">题库练习</a></li>
                <li><a href="${pageContext.request.contextPath}/home/exam">模拟考试</a></li>
                <li><a href="${pageContext.request.contextPath}/home/forum" class="active">学习社区</a></li>
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
        <!-- 面包屑导航 -->
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/home/index">首页</a>
            <span>/</span>
            <a href="${pageContext.request.contextPath}/home/forum">学习社区</a>
            <span>/</span>
            <span>帖子详情</span>
        </div>

        <!-- 帖子详情 -->
        <c:if test="${not empty post}">
            <div class="post-detail">
                <h1 class="post-title">${post.title}</h1>
                <div class="post-meta">
                    <span>作者: 用户${post.author_id}</span>
                    <span>发布时间: ${post.formatted_created_at}</span>
                    <c:if test="${not empty post.category}">
                        <span>分类: ${post.category}</span>
                    </c:if>
                </div>
                <div class="post-content">
                    <p>${post.content}</p>
                </div>
                <div class="actions">
                    <a href="${pageContext.request.contextPath}/home/forum" class="btn btn-secondary">返回列表</a>
                    <c:if test="${not empty sessionScope.user and sessionScope.user.id == post.author_id}">
                        <a href="#" class="btn">编辑</a>
                        <a href="#" class="btn btn-danger">删除</a>
                    </c:if>
                </div>
            </div>
        </c:if>

        <c:if test="${empty post}">
            <div class="no-data-detail">
                <h3>帖子不存在或已被删除</h3>
                <p><a href="${pageContext.request.contextPath}/home/forum" class="btn">返回帖子列表</a></p>
            </div>
        </c:if>
    </div>
</main>

<!-- 页面底部 -->
<footer class="footer">
    <div class="container">
        <p>&copy; 2023 考研学习平台. All rights reserved.</p>
    </div>
</footer>
</body>
</html>