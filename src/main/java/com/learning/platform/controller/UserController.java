package com.learning.platform.controller;

import com.learning.platform.entity.User;
import com.learning.platform.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 显示登录页面
     */
    @GetMapping("/user/login")
    public String showLoginPage(@RequestParam(value = "error", required = false) String error,
                                Model model) {
        if (error != null) {
            model.addAttribute("error", "用户名或密码错误，请重新输入！");
        }
        return "user";  // 返回user.jsp页面
    }

    /**
     * 处理登录请求
     */
    @PostMapping("/user/login")
    public String login(@RequestParam("username") String username,
                        @RequestParam("password") String password,
                        HttpSession session,
                        Model model,
                        RedirectAttributes redirectAttributes) {

        try {
            User user = userService.login(username, password);

            if (user != null) {
                // 登录成功
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(1800); // 设置session过期时间30分钟

                // 登录成功后重定向到index页面
                return "redirect:/home/index";

            } else {
                // 登录失败
                model.addAttribute("error", "用户名或密码错误");
                model.addAttribute("username", username); // 保留用户名
                return "user";  // 返回登录页面
            }
        } catch (Exception e) {
            model.addAttribute("error", "登录失败：" + e.getMessage());
            return "user";
        }
    }

    /**
     * 退出登录
     */
    @GetMapping("/user/logout")
    public String logout(HttpSession session) {
        session.invalidate();  // 清除所有session
        return "redirect:/home/index";  // 重定向到首页
    }

    /**
     * 显示注册页面
     */
    @GetMapping("/user/register")
    public String showRegisterPage() {
        return "register";
    }

    /**
     * 处理注册请求
     */
    @PostMapping("/user/register")
    public String register(@RequestParam("username") String username,
                           @RequestParam("password") String password,
                           @RequestParam("email") String email,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {

        try {
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);

            boolean result = userService.register(user);

            if (result) {
                // 注册成功后自动登录
                User registeredUser = userService.login(username, password);
                session.setAttribute("user", registeredUser);
                return "redirect:/home/index";
            } else {
                redirectAttributes.addFlashAttribute("error", "注册失败，用户名已存在！");
                return "redirect:/user/register";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "注册失败：" + e.getMessage());
            return "redirect:/user/register";
        }
    }

    /**
     * 用户个人中心
     */
    @GetMapping("/user/profile")
    public String profile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }

        // 获取最新用户信息
        User currentUser = userService.findUserById(user.getId());
        model.addAttribute("user", currentUser);
        return "user";  // 对应 /WEB-INF/views/user.jsp
    }

    /**
     * 更新用户信息
     */
    @PostMapping("/user/updateProfile")
    public String updateProfile(@ModelAttribute User user, HttpSession session, Model model) {
        try {
            User currentUser = (User) session.getAttribute("user");
            if (currentUser == null) {
                return "redirect:/user/login";
            }

            // 确保只能更新自己的信息
            user.setId(currentUser.getId());

            boolean result = userService.updateUser(user);
            if (result) {
                // 更新成功，刷新session中的用户信息
                User updatedUser = userService.findUserById(user.getId());
                session.setAttribute("user", updatedUser);
                model.addAttribute("message", "个人信息更新成功");
            } else {
                model.addAttribute("error", "个人信息更新失败");
            }
        } catch (Exception e) {
            model.addAttribute("error", "更新失败：" + e.getMessage());
        }
        return "user";
    }

    /**
     * 修改密码页面
     */
    @GetMapping("/user/changePassword")
    public String showChangePasswordPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        return "user"; // 对应 /WEB-INF/views/user.jsp
    }

}
