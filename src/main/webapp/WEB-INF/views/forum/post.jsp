<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发表新帖 - 考研学习平台</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Microsoft YaHei', Arial, sans-serif; line-height: 1.6; color: #333; background: #f5f5f5; }
        .container { max-width: 800px; margin: 0 auto; padding: 20px; }

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

        .post-form-container { background: #fff; border-radius: 8px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-header { margin-bottom: 25px; border-bottom: 2px solid #4285f4; padding-bottom: 10px; }
        .form-header h2 { color: #4285f4; font-size: 1.8em; }
        .form-header p { color: #666; margin-top: 5px; }

        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; color: #333; }
        .form-control { width: 100%; padding: 10px 12px; border: 1px solid #ddd; border-radius: 4px; font-size: 16px; font-family: 'Microsoft YaHei', Arial, sans-serif; transition: border 0.3s; }
        .form-control:focus { outline: none; border-color: #4285f4; box-shadow: 0 0 0 2px rgba(66, 133, 244, 0.2); }
        textarea.form-control { resize: vertical; min-height: 150px; }

        .alert { padding: 12px 15px; border-radius: 4px; margin-bottom: 20px; }
        .alert-error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }

        .form-actions { display: flex; gap: 10px; margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee; }
        .btn { padding: 10px 20px; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; text-decoration: none; display: inline-block; transition: background 0.3s; }
        .btn-primary { background: #4285f4; color: white; }
        .btn-primary:hover { background: #3367d6; }
        .btn-secondary { background: #f8f9fa; color: #333; border: 1px solid #ddd; }
        .btn-secondary:hover { background: #e9ecef; }

        .footer { background: #333; color: white; text-align: center; padding: 20px 0; margin-top: 40px; }

        .login-prompt { text-align: center; padding: 50px; background: #fff; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .login-prompt h3 { color: #4285f4; margin-bottom: 15px; }

        @media (max-width: 768px) {
            .header .container { flex-direction: column; }
            .nav ul { margin: 20px 0; }
            .nav li { margin: 0 10px; }
            .user-info { margin-top: 10px; }
            .form-actions { flex-direction: column; }
            .btn { width: 100%; text-align: center; }
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
                <li><a href="${pageContext.request.contextPath}/home/question">题库练习</a></li>
                <li><a href="${pageContext.request.contextPath}/home/exam">模拟考试</a></li>
                <li><a href="${pageContext.request.contextPath}/home/forum" class="active">学习社区</a></li>
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
            <a href="${pageContext.request.contextPath}/home/index">首页</a>
            <span>/</span>
            <a href="${pageContext.request.contextPath}/home/forum">学习社区</a>
            <span>/</span>
            <span>发表新帖</span>
        </div>

        <!-- 检查用户是否登录 -->
        <c:choose>
            <c:when test="${empty sessionScope.user}">
                <div class="login-prompt">
                    <h3>请先登录</h3>
                    <p>发表帖子需要先登录您的账户</p>
                    <div style="margin-top: 20px;">
                        <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary">立即登录</a>
                        <a href="${pageContext.request.contextPath}/user/register" class="btn btn-secondary" style="margin-left: 10px;">注册账号</a>
                        <a href="${pageContext.request.contextPath}/home/forum" class="btn btn-secondary" style="margin-left: 10px;">返回社区</a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 发表帖子表单 -->
                <div class="post-form-container">
                    <div class="form-header">
                        <h2>发表新帖</h2>
                        <p>分享您的学习经验、提出问题或参与讨论</p>
                    </div>

                    <!-- 错误消息 -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-error">${error}</div>
                    </c:if>

                    <!-- 成功消息 -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/home/forum/post" method="post" id="postForm">
                        <!-- 帖子标题 -->
                        <div class="form-group">
                            <label for="title">标题 *</label>
                            <input type="text" id="title" name="title" class="form-control"
                                   placeholder="请输入帖子标题（5-100个字符）"
                                   required minlength="5" maxlength="100"
                                   value="${post.title}">
                            <small style="color: #666; font-size: 0.9em;">简洁明了地概括您的帖子内容</small>
                        </div>

                        <!-- 帖子分类 -->
                        <div class="form-group">
                            <label for="category">分类 *</label>
                            <select id="category" name="category" class="form-control" required>
                                <option value="">请选择帖子分类</option>
                                <option value="经验分享" <c:if test="${post.category == '经验分享'}">selected</c:if>>经验分享</option>
                                <option value="学习技巧" <c:if test="${post.category == '学习技巧'}">selected</c:if>>学习技巧</option>
                                <option value="资料分享" <c:if test="${post.category == '资料分享'}">selected</c:if>>资料分享</option>
                                <option value="问题求助" <c:if test="${post.category == '问题求助'}">selected</c:if>>问题求助</option>
                                <option value="政治" <c:if test="${post.category == '政治'}">selected</c:if>>政治</option>
                                <option value="英语" <c:if test="${post.category == '英语'}">selected</c:if>>英语</option>
                                <option value="数学" <c:if test="${post.category == '数学'}">selected</c:if>>数学</option>
                                <option value="专业课" <c:if test="${post.category == '专业课'}">selected</c:if>>专业课</option>
                                <option value="其他" <c:if test="${post.category == '其他'}">selected</c:if>>其他</option>
                            </select>
                        </div>

                        <!-- 帖子内容 -->
                        <div class="form-group">
                            <label for="content">内容 *</label>
                            <textarea id="content" name="content" class="form-control"
                                      placeholder="请输入帖子详细内容（至少20个字符）"
                                      required minlength="20"><c:if test="${not empty post.content}">${post.content}</c:if></textarea>
                            <small style="color: #666; font-size: 0.9em;">详细描述您的问题、经验或分享</small>
                        </div>

                        <!-- 表单操作 -->
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary" id="submitBtn">发布帖子</button>
                            <a href="${pageContext.request.contextPath}/home/forum" class="btn btn-secondary">取消返回</a>
                        </div>

                        <!-- 隐藏字段 -->
                        <input type="hidden" name="author_id" value="${sessionScope.user.id}">
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<!-- 页面底部 -->
<footer class="footer">
    <div class="container">
        <p>&copy; 2023 考研学习平台. All rights reserved.</p>
    </div>
</footer>

<script>
    // 表单提交验证
    document.getElementById('postForm').addEventListener('submit', function(e) {
        const title = document.getElementById('title').value.trim();
        const category = document.getElementById('category').value;
        const content = document.getElementById('content').value.trim();

        if (title.length < 5 || title.length > 100) {
            e.preventDefault();
            alert('标题长度必须在5-100个字符之间');
            document.getElementById('title').focus();
            return false;
        }

        if (!category) {
            e.preventDefault();
            alert('请选择帖子分类');
            document.getElementById('category').focus();
            return false;
        }

        if (content.length < 20) {
            e.preventDefault();
            alert('内容长度至少需要20个字符');
            document.getElementById('content').focus();
            return false;
        }

        // 显示提交中状态
        const submitBtn = document.getElementById('submitBtn');
        submitBtn.disabled = true;
        submitBtn.innerHTML = '发布中...';

        return true;
    });

    // 字数统计
    const titleInput = document.getElementById('title');
    const contentTextarea = document.getElementById('content');

    if (titleInput) {
        titleInput.addEventListener('input', function() {
            const count = this.value.length;
            const min = parseInt(this.getAttribute('minlength')) || 0;
            const max = parseInt(this.getAttribute('maxlength')) || 0;

            if (count < min) {
                this.style.borderColor = '#ea4335';
            } else if (count > max) {
                this.style.borderColor = '#ea4335';
            } else {
                this.style.borderColor = '#ddd';
            }
        });
    }

    if (contentTextarea) {
        contentTextarea.addEventListener('input', function() {
            const count = this.value.length;
            const min = parseInt(this.getAttribute('minlength')) || 0;

            if (count < min) {
                this.style.borderColor = '#ea4335';
            } else {
                this.style.borderColor = '#ddd';
            }
        });
    }
</script>
</body>
</html>