package com.learning.platform.controller;

import com.learning.platform.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/home")
public class HomeController {

    /**
     * 处理根路径访问，重定向到首页
     */
    @RequestMapping("/")
    public String root() {
        return "redirect:/home/index";
    }

    /**
     * 首页
     */
    @RequestMapping("/index")
    public String index(Model model) {
        model.addAttribute("message", "欢迎使用学习平台");
        return "index";  // 对应 /WEB-INF/views/index.jsp
    }

    /**
     * 课程中心
     */
    @RequestMapping ("/course")
    public String courseList(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
        }
        model.addAttribute("title", "课程中心");
        return "course";
    }

    /**
     * 题库练习
     */
    @RequestMapping("/question")
    public String questionList(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
        }
        model.addAttribute("title", "题库练习");
        return "question";
    }

    /**
     * 模拟考试
     */
    @RequestMapping("/exam")
    public String examList(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
        }
        model.addAttribute("title", "模拟考试");
        return "exam";
    }

    /**
     * 处理登录页面请求，重定向到正确的登录页面
     */
    @RequestMapping("/login")
    public String login() {
        return "redirect:/user/login";
    }

    /**
     * 学习社区
     */
    @RequestMapping("/forum")
    public String forumList(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
        }
        model.addAttribute("title", "学习社区");
        return "forum";
    }
}