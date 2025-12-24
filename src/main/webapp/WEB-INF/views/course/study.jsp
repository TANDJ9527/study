<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.course_name} - 在线学习 - 考研学习平台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }

        /* 头部样式 */
        .header { background: white; box-shadow: 0 2px 5px rgba(0,0,0,0.1); padding: 15px 0; }
        .header .container { display: flex; justify-content: space-between; align-items: center; }
        .logo h1 { color: #4285f4; }
        .nav ul { display: flex; list-style: none; }
        .nav li { margin-left: 20px; }
        .nav a { text-decoration: none; color: #333; }
        .nav a.active { color: #4285f4; }

        /* 主要内容 */
        .main { padding: 30px 0; }
        .breadcrumb { margin-bottom: 20px; }
        .breadcrumb a { color: #4285f4; text-decoration: none; }
        .breadcrumb span { color: #999; margin: 0 5px; }

        .study-content { display: grid; grid-template-columns: 1fr 300px; gap: 20px; }

        .video-player {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            height: 500px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #000;
            color: white;
        }

        .video-placeholder {
            text-align: center;
        }

        .video-placeholder i {
            font-size: 64px;
            margin-bottom: 20px;
            color: #4285f4;
        }

        .video-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .course-info {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 20px;
        }

        .course-header {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .course-name {
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }

        .course-price {
            color: #ea4335;
            font-weight: bold;
        }

        .progress-section {
            margin-bottom: 25px;
        }

        .progress-title {
            font-weight: bold;
            margin-bottom: 10px;
            color: #4285f4;
        }

        .progress-bar {
            height: 10px;
            background: #e0e0e0;
            border-radius: 5px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: #4285f4;
            width: 35%; /* 示例进度 */
        }

        .progress-text {
            font-size: 14px;
            color: #666;
            margin-top: 5px;
        }

        .chapter-list {
            margin-top: 20px;
        }

        .chapter-title {
            font-weight: bold;
            margin-bottom: 15px;
            color: #4285f4;
        }

        .chapter-item {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
        }

        .chapter-item:last-child {
            border-bottom: none;
        }

        .chapter-item:hover {
            background: #f5f9ff;
        }

        .chapter-item.active {
            background: #e8f0fe;
            border-left: 3px solid #4285f4;
        }

        .chapter-name {
            font-weight: 500;
            margin-bottom: 5px;
        }

        .chapter-duration {
            font-size: 13px;
            color: #666;
        }

        .actions {
            margin-top: 25px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .btn {
            display: block;
            padding: 12px;
            background: #4285f4;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            text-align: center;
        }

        .btn-outline {
            background: white;
            color: #4285f4;
            border: 1px solid #4285f4;
        }

        .btn-success {
            background: #34a853;
        }

        /* 底部 */
        .footer {
            background: #333;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 30px;
        }

        @media (max-width: 768px) {
            .header .container { flex-direction: column; }
            .nav ul { margin-top: 15px; }
            .study-content { grid-template-columns: 1fr; }
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
