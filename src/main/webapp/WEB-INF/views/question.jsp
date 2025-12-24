<!-- question.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>题库练习 - 考研学习平台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; line-height: 1.6; color: #333; background-color: #f5f5f5; }
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
        .filter-section { background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 30px; }
        .filter-title { font-weight: bold; margin-bottom: 15px; color: #4285f4; }
        .filter-options { display: flex; flex-wrap: wrap; gap: 15px; }
        .filter-option { padding: 8px 15px; background: #fff; border: 1px solid #ddd; border-radius: 20px; cursor: pointer; transition: all 0.3s; }
        .filter-option:hover, .filter-option.active { background: #4285f4; color: white; border-color: #4285f4; }
        .question-list { background: #fff; border: 1px solid #eee; border-radius: 8px; padding: 20px; }
        .question-item { padding: 20px; border-bottom: 1px solid #eee; }
        .question-item:last-child { border-bottom: none; }
        .question-header { display: flex; justify-content: space-between; margin-bottom: 10px; }
        .question-type { background: #4285f4; color: white; padding: 3px 8px; border-radius: 4px; font-size: 0.8em; }
        .question-difficulty { font-size: 0.9em; font-weight: bold; }
        .difficulty-easy { color: #34a853; }
        .difficulty-medium { color: #fbbc05; }
        .difficulty-hard { color: #ea4335; }
        .question-content { margin-bottom: 15px; }
        .options { margin-left: 20px; }
        .option { margin-bottom: 8px; }
        .answer-area { margin-top: 15px; padding: 15px; background: #f8f9fa; border-radius: 4px; }
        .btn { display: inline-block; padding: 8px 15px; background: #4285f4; color: white; text-decoration: none; border-radius: 4px; font-size: 0.9em; transition: background 0.3s; border: none; cursor: pointer; margin-right: 10px; }
        .btn:hover { background: #3367d6; }
        .btn-secondary { background: #f8f9fa; color: #333; border: 1px solid #ddd; }
        .btn-secondary:hover { background: #e9ecef; }
        .pagination { display: flex; justify-content: center; margin-top: 30px; gap: 10px; }
        .page-item { padding: 8px 15px; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #333; }
        .page-item.active { background: #4285f4; color: white; border-color: #4285f4; }
        .page-item:hover:not(.active) { background: #f8f9fa; }
        .footer { background: #333; color: white; text-align: center; padding: 20px 0; margin-top: 40px; }
        .no-data { grid-column: 1 / -1; text-align: center; padding: 50px; color: #666; }

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
                <li><a href="${pageContext.request.contextPath}/home/question" class="active">题库练习</a></li>
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
            <a href="${pageContext.request.contextPath}/index.jsp">首页</a>
            <span>/</span>
            <span>题库练习</span>
        </div>

        <!-- 筛选区域 -->
        <div class="filter-section">
            <div class="filter-title">题目筛选</div>
            <div class="filter-options">
                <c:set var="currentCategory" value="${empty param.category ? '全部题目' : param.category}" />
                <div class="filter-option ${currentCategory == '全部题目' ? 'active' : ''}" data-category="全部题目">全部题目</div>
                <div class="filter-option ${currentCategory == '考研数学' ? 'active' : ''}" data-category="考研数学">考研数学</div>
                <div class="filter-option ${currentCategory == '考研英语' ? 'active' : ''}" data-category="考研英语">考研英语</div>
                <div class="filter-option ${currentCategory == '考研政治' ? 'active' : ''}" data-category="考研政治">考研政治</div>
                <div class="filter-option ${currentCategory == '计算机专业课' ? 'active' : ''}" data-category="计算机专业课">计算机专业课</div>
            </div>
        </div>

        <!-- 题目列表 -->
        <div class="question-list">
            <c:choose>
                <c:when test="${not empty questions}">
                    <c:forEach var="question" items="${questions}" varStatus="status">
                        <div class="question-item">
                            <div class="question-header">
                                <span class="question-type">${question.type}</span>
                                <span class="question-difficulty
                                    ${question.difficulty == '简单难度' ? 'difficulty-easy' :
                                      question.difficulty == '中等难度' ? 'difficulty-medium' :
                                      'difficulty-hard'}">
                                        ${question.difficulty}
                                </span>
                            </div>
                            <div class="question-content">
                                <p><strong>${status.index + 1}. </strong>${question.content}</p>
                            </div>
                            <c:if test="${not empty question.options}">
                                <div class="options">
                                    <c:forEach var="option" items="${question.options}" varStatus="optStatus">
                                        <div class="option">
                                            <label>
                                                <input type="radio" name="q${question.id}" value="${optStatus.index + 1}">
                                                    ${optStatus.index + 1}. ${option}
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                            <div class="answer-area">
                                <button class="btn" onclick="checkAnswer(${question.id})">提交答案</button>
                                <button class="btn btn-secondary" onclick="showAnswer(${question.id})">查看解析</button>
                                <div id="result-${question.id}" style="margin-top: 10px;"></div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <h3>暂无题目</h3>
                        <p>还没有任何题目数据</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 分页 -->
        <c:if test="${not empty questions and totalPages > 1}">
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/home/question?page=${currentPage - 1}<c:if test="${not empty param.category}">&category=${param.category}</c:if>" class="page-item">上一页</a>
                </c:if>

                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                    <c:choose>
                        <c:when test="${pageNum == currentPage}">
                            <span class="page-item active">${pageNum}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/home/question?page=${pageNum}<c:if test="${not empty param.category}">&category=${param.category}</c:if>" class="page-item">${pageNum}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/home/question?page=${currentPage + 1}<c:if test="${not empty param.category}">&category=${param.category}</c:if>" class="page-item">下一页</a>
                </c:if>
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

<script>
    // 筛选按钮点击事件
    document.querySelectorAll('.filter-option').forEach(option => {
        option.addEventListener('click', function() {
            const category = this.getAttribute('data-category');

            // 构建URL参数
            let url = "${pageContext.request.contextPath}/home/question?category=" + encodeURIComponent(category);

            // 如果当前有页码参数，保留它
            const urlParams = new URLSearchParams(window.location.search);
            const page = urlParams.get('page');
            if (page) {
                url += "&page=" + page;
            }

            window.location.href = url;
        });
    });

    // 提交答案函数
    function checkAnswer(questionId) {
        const resultDiv = document.getElementById('result-' + questionId);
        const selectedOption = document.querySelector('input[name="q' + questionId + '"]:checked');

        if (!selectedOption) {
            resultDiv.innerHTML = '<p style="color: #ea4335;">请先选择一个答案！</p>';
            return;
        }

        // 这里应该是Ajax请求到服务器验证答案
        // 暂时用模拟数据
        resultDiv.innerHTML = '<p style="color: #34a853;">答案正确！解析：这是正确的答案解析内容...</p>';
    }

    // 查看解析函数
    function showAnswer(questionId) {
        const resultDiv = document.getElementById('result-' + questionId);
        // 这里应该是Ajax请求到服务器获取解析
        resultDiv.innerHTML = '<p><strong>解析：</strong>这里是详细的题目解析内容，帮助用户理解解题思路和方法。</p>';
    }
</script>
</body>
</html>