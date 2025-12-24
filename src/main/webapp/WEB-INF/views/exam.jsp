<%-- 在页面顶部添加 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <title>${exam.exam_name}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .exam-header {
            background-color: #f5f5f5;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .exam-title {
            font-size: 24px;
            margin-bottom: 15px;
        }
        .exam-info {
            display: flex;
            gap: 30px;
        }
        .info-item {
            display: flex;
            flex-direction: column;
        }
        .info-label {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
        }
        .info-value {
            font-size: 16px;
            font-weight: bold;
        }
        .questions-section {
            max-width: 800px;
        }
        .question-item {
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
        }
        .question-header {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
        }
        .question-number {
            font-weight: bold;
        }
        .question-type {
            color: #666;
        }
        .question-content {
            margin-bottom: 15px;
        }
        .options {
            margin-left: 20px;
        }
        .option {
            margin-bottom: 8px;
        }
    </style>
</head>
<body>
    <!-- 考试头部信息 -->
    <div class="exam-header">
        <h1 class="exam-title">${exam.exam_name}</h1>
        <div class="exam-info">
            <div class="info-item">
                <div class="info-label">总题数</div>
                <div class="info-value">
                    <c:choose>
                        <c:when test="${not empty questions}">${fn:length(questions)}题</c:when>
                        <c:otherwise>0题</c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="info-item">
                <div class="info-label">总分</div>
                <div class="info-value">${exam.total_score}分</div>
            </div>
            <div class="info-item">
                <div class="info-label">考试时长</div>
                <div class="info-value">${exam.total_time}分钟</div>
            </div>
        </div>
    </div>

    <!-- 题目区域 -->
    <div class="questions-section">
        <c:choose>
            <c:when test="${not empty questions}">
                <c:forEach items="${questions}" var="question" varStatus="status">
                    <div class="question-item">
                        <div class="question-header">
                            <span class="question-number">${question.question_number}.</span>
                            <span class="question-type">单选题（${question.score}分）</span>
                        </div>
                        <div class="question-content">
                            <p>${question.content}</p>
                        </div>
                        <div class="options">
                            <%-- 这里需要解析JSON格式的options --%>
                            <%-- 示例假设options是简单的A/B/C/D格式 --%>
                            <div class="option">
                                <label><input type="radio" name="q${question.id}" value="A"> A. 选项A内容</label>
                            </div>
                            <div class="option">
                                <label><input type="radio" name="q${question.id}" value="B"> B. 选项B内容</label>
                            </div>
                            <div class="option">
                                <label><input type="radio" name="q${question.id}" value="C"> C. 选项C内容</label>
                            </div>
                            <div class="option">
                                <label><input type="radio" name="q${question.id}" value="D"> D. 选项D内容</label>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="no-questions">暂无题目</div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
