<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN" class="login-page">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 - 考研学习平台</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>考研学习平台</h1>
            <p>用户登录</p>
        </div>

        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/user/login" method="post" autocomplete="off">
            <!-- 隐藏的输入字段，用于捕获自动填充 -->
            <input type="text" style="display:none;" name="fake_username" autocomplete="username">
            <input type="password" style="display:none;" name="fake_password" autocomplete="password">
            
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" placeholder="请输入用户名" required autocomplete="new-password">
            </div>

            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" placeholder="请输入密码" required autocomplete="new-password">
            </div>

            <button type="submit" class="btn">登录</button>
        </form>

        <div class="form-footer">
            <p>还没有账号？<a href="${pageContext.request.contextPath}/user/register">立即注册</a></p>
            <p><a href="${pageContext.request.contextPath}/home/index">返回首页</a></p>
        </div>
    </div>
</body>
</html>


