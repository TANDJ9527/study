<%-- 在页面顶部添加 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>考试列表</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .exam-list {
            max-width: 800px;
            margin: 0 auto;
        }
        .exam-item {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 10px;
            background-color: #f9f9f9;
        }
        .exam-item:hover {
            background-color: #f0f0f0;
        }
        .exam-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .exam-info {
            display: flex;
            gap: 20px;
            margin-bottom: 10px;
        }
        .info-item {
            display: flex;
            flex-direction: column;
        }
        .info-label {
            font-size: 12px;
            color: #666;
        }
        .info-value {
            font-size: 14px;
            font-weight: bold;
        }
        .start-exam-btn {
            background-color: #4CAF50;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 3px;
            display: inline-block;
            margin-top: 10px;
        }
        .start-exam-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="exam-list">
        <h1>考试列表</h1>
        
        <c:if test="${empty exams}">
            <div class="no-exams">暂无考试</div>
        </c:if>
        
        <c:forEach items="${exams}" var="exam">
            <div class="exam-item">
                <div class="exam-title">${exam.exam_name}</div>
                <div class="exam-info">
                    <div class="info-item">
                        <div class="info-label">描述</div>
                        <div class="info-value">${exam.description}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">总分</div>
                        <div class="info-value">${exam.total_score}分</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">时长</div>
                        <div class="info-value">${exam.total_time}分钟</div>
                    </div>
                </div>
                <a href="/home/exam/${exam.id}" class="start-exam-btn">进入考试</a>
            </div>
        </c:forEach>
    </div>
</body>
</html>