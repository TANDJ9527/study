<!-- /WEB-INF/views/error.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN" class="error-page">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>错误页面 - 考研学习平台</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <div class="error-box">
        <h1 class="error-title">错误</h1>
        <div class="error-message">
            <c:if test="${not empty error}">
                ${error}
            </c:if>
            <c:if test="${empty error}">
                系统发生错误，请稍后再试
            </c:if>
        </div>
        <a href="${pageContext.request.contextPath}/home/forum" class="btn">返回学习社区</a>
    </div>
</div>
</body>
</html>