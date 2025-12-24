<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${post.title} - 学习社区</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
        .header { background: #fff; box-shadow: 0 2px 5px rgba(0,0,0,0.1); position: sticky; top: 0; z-index: 100; }
        .header .container { display: flex; justify-content: space-between; align-items: center; padding: 15px 20px; }
        .logo h1 { color: #4285f4; }
        .nav ul { display: flex; list-style: none; }
        .nav li { margin-left: 30px; }
        .nav a { text-decoration: none; color: #333; font-weight: 500; transition: color 0.3s; }
        .nav a:hover, .nav a.active { color: #4285f4; }
        .user-info a { margin-left: 15px; text-decoration: none; color: #4285f4; }
        .user-info span { margin-right: 15px; }
        .main { min-height: calc(100vh - 140px); padding: 30px 0; }
        .breadcrumb { margin-bottom: 20px; }
        .breadcrumb a { color: #4285f4; text-decoration: none; }
        .breadcrumb span { color: #999; margin: 0 5px; }
        .post-detail { background: #fff; border: 1px solid #eee; border-radius: 8px; padding: 30px; }
        .post-title { font-size: 2em; margin-bottom: 20px; color: #333; }
        .post-meta { color: #666; margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 15px; }
        .post-meta span { margin-right: 20px; }
        .post-content { line-height: 1.8; font-size: 1.1em; }
        .post-content p { margin-bottom: 20px; }
        .actions { margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee; }
        .btn { display: inline-block; padding: 8px 15px; background: #4285f4; color: white; text-decoration: none; border-radius: 4px; font-size: 0.9em; transition: background 0.3s; border: none; cursor: pointer; }
        .btn:hover { background: #3367d6; }
        .btn-secondary { background: #f8f9fa; color: #333; border: 1px solid #ddd; }
        .btn-secondary:hover { background: #e9ecef; }
        .btn-danger { background: #ea4335; }
        .btn-danger:hover { background: #d3342f; }
        .footer { background: #333; color: white; text-align: center; padding: 20px 0; margin-top: 40px; }
    </style>
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
            <div style="text-align: center; padding: 50px;">
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