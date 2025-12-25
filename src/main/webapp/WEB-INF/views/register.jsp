<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN" class="register-page">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册 - 考研学习平台</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="register-container">
    <div class="register-header">
        <h1>考研学习平台</h1>
        <p>用户注册</p>
    </div>

    <div class="success-message" id="successMessage" style="display: none;">
        注册成功！请登录您的账户。
    </div>

    <div class="error-message" id="errorMessage" style="display: none;">
        注册失败，请检查输入信息
    </div>

    <form action="${pageContext.request.contextPath}/user/register" method="post">
        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" id="username" name="username" required placeholder="请输入用户名">
        </div>

        <div class="form-group">
            <label for="email">邮箱</label>
            <input type="email" id="email" name="email" required placeholder="请输入邮箱地址">
        </div>

        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" id="password" name="password" required placeholder="请输入密码">
        </div>

        <div class="form-group">
            <label for="confirmPassword">确认密码</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="请再次输入密码">
        </div>

        <button type="submit" class="btn">注册</button>
    </form>

    <div class="form-footer">
        <p>已有账号？<a href="${pageContext.request.contextPath}/user/login">立即登录</a></p>
        <p><a href="${pageContext.request.contextPath}/home/index">返回首页</a></p>
    </div>
</div>

<script>
    // 检查是否有成功或错误参数
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('success') === '1') {
        document.getElementById('successMessage').style.display = 'block';
    } else if (urlParams.get('error') === '1') {
        document.getElementById('errorMessage').style.display = 'block';
    }
    
    // 检查是否有来自服务器的错误信息
    <c:if test="${not empty error}">
        <script>
            document.getElementById('errorMessage').textContent = '${error}';
            document.getElementById('errorMessage').style.display = 'block';
        </script>
    </c:if>

    // 密码确认验证
    document.querySelector('form').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            e.preventDefault();
            alert('两次输入的密码不一致');
        }
    });
</script>
</body>
</html>
