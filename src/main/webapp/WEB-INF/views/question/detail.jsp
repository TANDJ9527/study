<!-- src/main/webapp/WEB-INF/views/question/detail.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN" class="question-detail-page">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>题目详情 - 考研学习平台</title>
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
