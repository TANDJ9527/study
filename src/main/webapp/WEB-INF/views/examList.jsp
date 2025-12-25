<%-- 在页面顶部添加 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html class="exam-list-page">
<head>
    <title>考试列表</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
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