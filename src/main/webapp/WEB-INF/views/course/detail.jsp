<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.course_name} - 课程详情 - 考研学习平台</title>
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

        .course-detail-card { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .course-header { background: #4285f4; color: white; padding: 20px; }
        .course-title { font-size: 24px; font-weight: bold; margin-bottom: 10px; }
        .course-meta { display: flex; justify-content: space-between; align-items: center; }
        .course-id { font-size: 14px; opacity: 0.9; }
        .course-price { font-size: 20px; font-weight: bold; }

        .course-body { padding: 25px; }
        .section { margin-bottom: 25px; }
        .section-title { font-size: 18px; font-weight: bold; color: #4285f4; margin-bottom: 15px; border-left: 4px solid #4285f4; padding-left: 10px; }
        .section-content { line-height: 1.8; color: #555; }

        .actions { display: flex; gap: 15px; margin-top: 20px; }
        .btn { display: inline-block; padding: 12px 25px; background: #4285f4; color: white; text-decoration: none; border-radius: 4px; font-size: 16px; font-weight: bold; }
        .btn-outline { background: white; color: #4285f4; border: 1px solid #4285f4; }
        .btn-success { background: #34a853; }

        /* 底部 */
        .footer { background: #333; color: white; text-align: center; padding: 20px; margin-top: 30px; }

        @media (max-width: 768px) {
            .header .container { flex-direction: column; }
            .nav ul { margin-top: 15px; }
            .course-meta { flex-direction: column; gap: 10px; align-items: flex-start; }
            .actions { flex-direction: column; }
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
