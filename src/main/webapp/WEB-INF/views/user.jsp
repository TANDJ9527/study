<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 - 考研学习平台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #4285f4, #34a853);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
            padding: 40px;
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-header h1 {
            color: #4285f4;
            margin-bottom: 10px;
        }
        .login-header p {
            color: #666;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        .form-group input:focus {
            outline: none;
            border-color: #4285f4;
            box-shadow: 0 0 0 2px rgba(66, 133, 244, 0.2);
        }
        .btn {
            width: 100%;
            padding: 12px;
            background: #4285f4;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn:hover {
            background: #3367d6;
        }
        .form-footer {
            text-align: center;
            margin-top: 20px;
        }
        .form-footer a {
            color: #4285f4;
            text-decoration: none;
        }
        .form-footer a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: #ea4335;
            background: #fce8e6;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            display: none;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>考研学习平台</h1>
            <p>用户登录</p>
        </div>

        <div class="error-message" id="errorMessage">
            用户名或密码错误
        </div>

        <form action="${pageContext.request.contextPath}/user/login" method="post">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" placeholder="请输入用户名" required>
            </div>

            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" placeholder="请输入密码" required>
            </div>

            <button type="submit" class="btn">登录</button>
        </form>

        <div class="form-footer">
            <p>还没有账号？<a href="${pageContext.request.contextPath}/user/register">立即注册</a></p>
            <p><a href="${pageContext.request.contextPath}/home/index">返回首页</a></p>
        </div>
    </div>

    <script>
        // 检查是否有错误参数，如果有则显示错误消息
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('error') === '1') {
            document.getElementById('errorMessage').style.display = 'block';
        }
    </script>
</body>
</html>


