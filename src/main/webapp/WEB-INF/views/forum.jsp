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
        .forum-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .forum-title { font-size: 1.8em; color: #333; }
        .new-post-btn { background: #4285f4; color: white; padding: 8px 15px; border-radius: 4px; text-decoration: none; font-size: 0.9em; cursor: pointer; }
        .new-post-btn:hover { background: #3367d6; }
        .forum-content { background: #fff; border: 1px solid #eee; border-radius: 8px; padding: 20px; }
        .post-item { padding: 20px; border-bottom: 1px solid #eee; }
        .post-item:last-child { border-bottom: none; }
        .post-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }
        .post-title { font-size: 1.2em; color: #333; }
        .post-title a { text-decoration: none; color: #333; }
        .post-title a:hover { color: #4285f4; }
        .post-meta { font-size: 0.9em; color: #999; }
        .post-meta span { margin: 0 5px; }
        .post-content { margin-bottom: 15px; }
        .post-actions { display: flex; gap: 10px; }
        .btn { display: inline-block; padding: 8px 15px; background: #4285f4; color: white; text-decoration: none; border-radius: 4px; font-size: 0.9em; transition: background 0.3s; border: none; cursor: pointer; }
        .btn:hover { background: #3367d6; }
        .btn-secondary { background: #f8f9fa; color: #333; border: 1px solid #ddd; }
        .btn-secondary:hover { background: #e9ecef; }
        .footer { background: #333; color: white; text-align: center; padding: 20px 0; margin-top: 40px; }
        .no-posts { text-align: center; padding: 50px; color: #666; }
        .debug-info { background: #f8f9fa; padding: 15px; margin: 10px 0; border-radius: 5px; border-left: 4px solid #4285f4; }
        .debug-info h4 { margin-bottom: 10px; color: #4285f4; }
        .debug-info p { margin: 5px 0; font-size: 0.9em; }

        @media (max-width: 768px) {
            .header .container { flex-direction: column; }
            .nav ul { margin: 20px 0; }
            .nav li { margin: 0 10px; }
            .user-info { margin-top: 10px; }
            .forum-header { flex-direction: column; align-items: flex-start; gap: 10px; }
        }
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