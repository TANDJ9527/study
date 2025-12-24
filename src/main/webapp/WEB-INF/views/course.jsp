<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>课程中心 - 考研学习平台</title>
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
        .page-title { font-size: 24px; margin-bottom: 20px; }

        /* 课程卡片 */
        .course-list { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 20px; }
        .course-card { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .course-header { background: #4285f4; color: white; padding: 15px; }
        .course-body { padding: 15px; }
        .course-title { font-size: 18px; font-weight: bold; margin-bottom: 10px; }
        .course-description { color: #666; font-size: 14px; margin-bottom: 15px; line-height: 1.5; }
        .course-price { color: #ea4335; font-weight: bold; font-size: 16px; }
        .btn { display: inline-block; padding: 8px 15px; background: #4285f4; color: white; text-decoration: none; border-radius: 4px; font-size: 14px; }
        .btn-outline { background: white; color: #4285f4; border: 1px solid #4285f4; }
        .user-info a {
            margin-left: 15px;
            text-decoration: none;
            color: #4285f4;
        }

        .user-info span {
            margin-right: 15px;
        }
        /* 底部 */
        .footer { background: #333; color: white; text-align: center; padding: 20px; margin-top: 30px; }

        /* 数据库信息提示 */
        .db-info {
            background: #e8f4fd;
            padding: 10px 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 13px;
            color: #666;
        }

        @media (max-width: 768px) {
            .course-list { grid-template-columns: 1fr; }
            .header .container { flex-direction: column; }
            .nav ul { margin-top: 15px; }
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
                                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 15px;">
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
                    <div style="grid-column: 1 / -1; text-align: center; padding: 50px; color: #666;">
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