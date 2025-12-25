<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} - 考研学习平台</title>
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
            <span>学习社区</span>
        </div>
        <!-- 社区头部 -->
        <div class="forum-header">
            <h1 class="forum-title">学习交流社区</h1>
            <a href="${pageContext.request.contextPath}/home/forum/post" class="new-post-btn">发表新帖</a>
        </div>

        <!-- 社区内容 -->
        <div class="forum-content">
            <!-- 帖子列表 -->
            <div class="posts-section">
                <c:choose>
                    <c:when test="${not empty posts and fn:length(posts) > 0}">
                        <c:forEach var="post" items="${posts}" varStatus="status">
                            <div class="post-item">
                                <div class="post-header">
                                    <h3 class="post-title">
                                        <a href="${pageContext.request.contextPath}/home/forum/detail/${post.id}">${post.title}</a>
                                    </h3>
                                    <div class="post-meta">
                                        <span>作者: 用户${post.author_id}</span>
                                        <span>·</span>
                                            <span>发布时间: ${post.formatted_created_at}</span>
                                        <c:if test="${not empty post.category}">
                                            <span>·</span>
                                            <span>分类: ${post.category}</span>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="post-content">
                                    <p>
                                        <c:choose>
                                            <c:when test="${not empty post.content and fn:length(post.content) > 150}">
                                                ${fn:substring(post.content, 0, 150)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${post.content}
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                                <div class="post-actions">
                                    <a href="${pageContext.request.contextPath}/home/forum/detail/${post.id}" class="btn">查看详情</a>
                                    <button class="btn btn-secondary" onclick="likePost(${post.id})">点赞</button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-posts">
                            <h3>暂无帖子</h3>
                            <p>还没有任何帖子，赶快<a href="${pageContext.request.contextPath}/home/forum/post" style="color: #4285f4;">发表新帖</a>吧！</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</main>

<!-- 页面底部 -->
<footer class="footer">
    <div class="container">
        <p>&copy; 2023 考研学习平台. All rights reserved.</p>
    </div>
</footer>

<script>
    // 发表新帖按钮点击事件
    document.querySelector('.new-post-btn').addEventListener('click', function(e) {
        e.preventDefault();

        // 检查用户是否登录
        <c:choose>
        <c:when test="${empty sessionScope.user}">
        if(confirm('请先登录才能发表帖子，是否前往登录页面？')) {
            window.location.href = '${pageContext.request.contextPath}/user/login';
        }
        </c:when>
        <c:otherwise>
        window.location.href = '${pageContext.request.contextPath}/home/forum/post';
        </c:otherwise>
        </c:choose>
    });

    // 点赞功能
    function likePost(postId) {
        <c:choose>
        <c:when test="${empty sessionScope.user}">
        alert('请先登录才能点赞！');
        window.location.href = '${pageContext.request.contextPath}/user/login';
        </c:when>
        <c:otherwise>
        fetch('${pageContext.request.contextPath}/api/forum/like', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ postId: postId })
        })
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    alert('点赞成功！');
                } else {
                    alert(data.message || '点赞失败');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('网络错误，请重试');
            });
        </c:otherwise>
        </c:choose>
    }
</script>
</body>
</html>