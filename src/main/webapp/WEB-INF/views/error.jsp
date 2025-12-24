<!-- /WEB-INF/views/error.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>错误页面 - 考研学习平台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; line-height: 1.6; color: #333; background: #f5f5f5; }
        .container { max-width: 800px; margin: 50px auto; padding: 20px; }
        .error-box { background: #fff; border-radius: 8px; padding: 40px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        .error-title { color: #ea4335; font-size: 2em; margin-bottom: 20px; }
        .error-message { color: #666; margin-bottom: 30px; font-size: 1.1em; }
        .btn { display: inline-block; padding: 10px 20px; background: #4285f4; color: white; text-decoration: none; border-radius: 4px; font-size: 1em; }
        .btn:hover { background: #3367d6; }
    </style>
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