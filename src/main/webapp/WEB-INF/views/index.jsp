<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>考研学习平台</title>
    <style>
        /* 基础样式重置 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            line-height: 1.6;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* 头部样式 */
        .header {
            background: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
        }

        .logo h1 {
            color: #4285f4;
        }

        .nav ul {
            display: flex;
            list-style: none;
        }

        .nav li {
            margin-left: 30px;
        }

        .nav a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            transition: color 0.3s;
        }

        .nav a:hover,
        .nav a.active {
            color: #4285f4;
        }

        .user-info a {
            margin-left: 15px;
            text-decoration: none;
            color: #4285f4;
        }

        .user-info span {
            margin-right: 15px;
        }

        /* 主要内容区域 */
        .main {
            min-height: calc(100vh - 140px);
            padding: 30px 0;
        }

        .banner {
            text-align: center;
            padding: 50px 20px;
            background: linear-gradient(135deg, #4285f4, #34a853);
            color: white;
            border-radius: 10px;
            margin-bottom: 40px;
        }

        .banner h2 {
            font-size: 2.5em;
            margin-bottom: 15px;
        }

        .banner p {
            font-size: 1.2em;
        }

        /* 分类和课程样式 */
        section {
            margin-bottom: 40px;
        }

        section h2 {
            font-size: 1.8em;
            margin-bottom: 20px;
            color: #333;
            border-left: 5px solid #4285f4;
            padding-left: 15px;
        }

        .category-list,
        .course-list,
        .tool-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .category-item,
        .course-item,
        .tool-item {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .category-item:hover,
        .course-item:hover,
        .tool-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .category-item h3,
        .course-item h3,
        .tool-item h3 {
            color: #4285f4;
            margin-bottom: 10px;
        }

        .price {
            display: block;
            color: #ea4335;
            font-weight: bold;
            font-size: 1.2em;
            margin-top: 10px;
        }

        /* 底部样式 */
        .footer {
            background: #333;
            color: white;
            text-align: center;
            padding: 20px 0;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .header .container {
                flex-direction: column;
            }

            .nav ul {
                margin: 20px 0;
            }

            .nav li {
                margin: 0 10px;
            }

            .banner h2 {
                font-size: 2em;
            }

            .user-info {
                margin-top: 10px;
            }
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
                <div class="category-item">
                    <h3>考研数学</h3>
                    <p>高等数学、线性代数、概率统计</p>
                </div>
                <div class="category-item">
                    <h3>考研英语</h3>
                    <p>阅读理解、翻译写作、词汇语法</p>
                </div>
                <div class="category-item">
                    <h3>考研政治</h3>
                    <p>马原、毛概、史纲、思修法基</p>
                </div>
                <div class="category-item">
                    <h3>专业课程</h3>
                    <p>计算机、经济学、教育学等</p>
                </div>
            </div>
        </section>

        <!-- 推荐课程 -->
        <section class="recommended-courses">
            <h2>推荐课程</h2>
            <div class="course-list">
                <div class="course-item">
                    <h3>考研数学基础班</h3>
                    <p>适合零基础学员，系统讲解基础知识</p>
                    <span class="price">¥299</span>
                </div>
                <div class="course-item">
                    <h3>考研英语阅读专项训练</h3>
                    <p>提升阅读理解能力和解题技巧</p>
                    <span class="price">¥199</span>
                </div>
                <div class="course-item">
                    <h3>考研政治冲刺班</h3>
                    <p>考点精讲，快速提分必备</p>
                    <span class="price">¥159</span>
                </div>
            </div>
        </section>

        <!-- 学习工具 -->
        <section class="learning-tools">
            <h2>学习工具</h2>
            <div class="tool-list">
                <div class="tool-item">
                    <h3>每日一练</h3>
                    <p>坚持每天练习，稳步提升</p>
                </div>
                <div class="tool-item">
                    <h3>模拟考试</h3>
                    <p>全真模拟考场环境</p>
                </div>
                <div class="tool-item">
                    <h3>错题本</h3>
                    <p>智能整理错题，针对性复习</p>
                </div>
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