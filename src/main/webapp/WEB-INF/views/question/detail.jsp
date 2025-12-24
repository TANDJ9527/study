<!-- src/main/webapp/WEB-INF/views/question/detail.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>题目详情 - 考研学习平台</title>
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
        .question-detail { background: #fff; border: 1px solid #eee; border-radius: 8px; padding: 30px; }
        .question-header { display: flex; justify-content: space-between; margin-bottom: 20px; }
        .question-type { background: #4285f4; color: white; padding: 3px 8px; border-radius: 4px; font-size: 0.8em; }
        .question-difficulty { font-size: 0.9em; }
        .difficulty-easy { color: #34a853; }
        .difficulty-medium { color: #fbbc05; }
        .difficulty-hard { color: #ea4335; }
        .question-content { margin-bottom: 20px; }
        .options { margin-left: 20px; }
        .option { margin-bottom: 10px; }
        .answer-area { margin-top: 20px; padding: 20px; background: #f8f9fa; border-radius: 4px; }
        .btn { display: inline-block; padding: 8px 15px; background: #4285f4; color: white; text-decoration: none; border-radius: 4px; font-size: 0.9em; transition: background 0.3s; border: none; cursor: pointer; }
        .btn:hover { background: #3367d6; }
        .btn-secondary { background: #f8f9fa; color: #333; border: 1px solid #ddd; }
        .btn-secondary:hover { background: #e9ecef; }
        .footer { background: #333; color: white; text-align: center; padding: 20px 0; margin-top: 40px; }
        @media (max-width: 768px) {
            .header .container { flex-direction: column; }
            .nav ul { margin: 20px 0; }
            .nav li { margin: 0 10px; }
            .user-info { margin-top: 10px; }
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
                <li><a href="${pageContext.request.contextPath}/home/forum">学习社区</a></li>
            </ul>
        </nav>
        <div class="user-info">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <span>欢迎, ${sessionScope.user.username}</span>
                    <a href="${pageContext.request.contextPath}/user/logout">退出</a>
                </c:when>
            </c:choose>
        </div>
    </div>
</header>

<!-- 主要内容区域 -->
<main class="main">
    <div class="container">
        <!-- 面包屑导航 -->
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/index.jsp">首页</a>
            <span>/</span>
            <span>题库练习</span>
            <span>/</span>
            <span>题目详情</span>
        </div>

        <!-- 题目详情 -->
        <div class="question-detail">
            <div class="question-header">
                <span class="question-type">${question.type}</span>
                <span class="question-difficulty ${question.difficulty == '简单难度' ? 'difficulty-easy' : question.difficulty == '中等难度' ? 'difficulty-medium' : 'difficulty-hard'}">${question.difficulty}</span>
            </div>
            <div class="question-content">
                <p><strong>${question.id}. </strong>${question.content}</p>
            </div>
            <div class="options">
                <div class="option">
                    <label><input type="radio" name="q${question.id}" value="A"> A. 这是选项A</label>
                </div>
                <div class="option">
                    <label><input type="radio" name="q${question.id}" value="B"> B. 这是选项B</label>
                </div>
                <div class="option">
                    <label><input type="radio" name="q${question.id}" value="C"> C. 这是选项C</label>
                </div>
                <div class="option">
                    <label><input type="radio" name="q${question.id}" value="D"> D. 这是选项D</label>
                </div>
            </div>
            <div class="answer-area">
                <button class="btn" onclick="checkAnswer(${question.id})">提交答案</button>
                <button class="btn btn-secondary" onclick="showAnswer(${question.id})">查看解析</button>
                <div id="result-${question.id}" style="margin-top: 10px;"></div>
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
    function checkAnswer(questionId) {
        const resultDiv = document.getElementById(`result-${questionId}`);
        resultDiv.innerHTML = '<p style="color: #34a853;">答案正确！解析：这是正确的答案解析内容...</p>';
    }

    function showAnswer(questionId) {
        const resultDiv = document.getElementById(`result-${questionId}`);
        resultDiv.innerHTML = '<p><strong>解析：</strong>这里是详细的题目解析内容，帮助用户理解解题思路和方法。</p>';
    }
</script>
</body>
</html>
