<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN" class="index-page">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>考研学习平台</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
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
                <li><a href="${pageContext.request.contextPath}/home/index" class="active">首页</a></li>
                <li><a href="${pageContext.request.contextPath}/home/course">课程中心</a></li>
                <li><a href="${pageContext.request.contextPath}/home/question">题库练习</a></li>
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
        <!-- 轮播图/横幅 -->
        <section class="banner">
            <h2>专注考研学习，助力梦想实现</h2>
            <p>提供全面的考研课程、题库练习和模拟考试服务</p>
        </section>

        <!-- 课程分类展示 -->
        <section class="course-categories">
            <h2>热门课程</h2>
            <div class="category-list">
                <a href="${pageContext.request.contextPath}/home/course?category=math" class="category-item-link">
                    <div class="category-item">
                        <h3>考研数学</h3>
                        <p>高等数学、线性代数、概率统计</p>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/home/course?category=english" class="category-item-link">
                    <div class="category-item">
                        <h3>考研英语</h3>
                        <p>阅读理解、翻译写作、词汇语法</p>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/home/course?category=politics" class="category-item-link">
                    <div class="category-item">
                        <h3>考研政治</h3>
                        <p>马原、毛概、史纲、思修法基</p>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/home/course?category=professional" class="category-item-link">
                    <div class="category-item">
                        <h3>专业课程</h3>
                        <p>计算机、经济学、教育学等</p>
                    </div>
                </a>
            </div>
        </section>

        <!-- 推荐课程 -->
        <section class="recommended-courses">
            <h2>推荐课程</h2>
            <div class="course-list">
                <a href="https://www.icourse163.org/search.htm?search=%E8%80%83%E7%A0%94%E6%95%B0%E5%AD%A6#/" class="course-item-link">
                    <div class="course-item">
                        <h3>考研数学基础班</h3>
                        <p>适合零基础学员，系统讲解基础知识</p>
                    </div>
                </a>
                <a href="https://ke.study.163.com/course/detail/100160928?inLoc=MocWebss_ssjg&Pdt=Moc.Web&outVendor=zw_mooc_pcssjg_" class="course-item-link">
                    <div class="course-item">
                        <h3>考研英语阅读专项训练</h3>
                        <p>提升阅读理解能力和解题技巧</p>
                    </div>
                </a>
                <a href="https://search.bilibili.com/all?keyword=%E8%80%83%E7%A0%94%E6%94%BF%E6%B2%BB%E5%86%B2%E5%88%BA" class="course-item-link">
                    <div class="course-item">
                        <h3>考研政治冲刺班</h3>
                        <p>考点精讲，快速提分必备</p>
                    </div>
                </a>
            </div>
        </section>

        <!-- 学习工具 -->
        <section class="learning-tools">
            <h2>学习工具</h2>
            <div class="tool-list">
                <a href="${pageContext.request.contextPath}/home/question?type=daily" class="tool-item-link">
                    <div class="tool-item">
                        <h3>每日一练</h3>
                        <p>坚持每天练习，稳步提升</p>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/home/exam" class="tool-item-link">
                    <div class="tool-item">
                        <h3>模拟考试</h3>
                        <p>全真模拟考场环境</p>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/home/question?type=error" class="tool-item-link">
                    <div class="tool-item">
                        <h3>错题本</h3>
                        <p>智能整理错题，针对性复习</p>
                    </div>
                </a>
            </div>
        </section>
    </div>
</main>

<!-- 页面底部 -->
<footer class="footer">
    <div class="container">
        <p>&copy; 2023 考研学习平台. All rights reserved.</p>
    </div>
</footer>

<script>
    // 添加简单的交互效果
    document.addEventListener('DOMContentLoaded', function() {
        // 为导航链接添加点击效果
        const navLinks = document.querySelectorAll('.nav a');
        navLinks.forEach(link => {
            link.addEventListener('click', function() {
                navLinks.forEach(l => l.classList.remove('active'));
                this.classList.add('active');
            });
        });
    });
</script>
</body>
</html>