package com.learning.platform.controller;

import com.learning.platform.entity.Post;
import com.learning.platform.entity.User;
import com.learning.platform.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

@Controller
@RequestMapping("/home")
public class ForumController {

    @Autowired
    private PostService postService;

    // 日期时间格式化器
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    private static final DateTimeFormatter DETAIL_DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    /**
     * 学习社区页面
     */
    @GetMapping("/forum")
    public String forumList(Model model, HttpSession session) {
        // 获取session中的用户
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
        }

        // 获取所有帖子
        List<Post> posts = postService.getAllPosts();

        // 创建一个新的列表，包含格式化后的时间字符串
        List<Map<String, Object>> postList = new ArrayList<>();

        if (posts != null && !posts.isEmpty()) {
            for (Post post : posts) {
                Map<String, Object> postMap = new HashMap<>();
                postMap.put("id", post.getId());
                postMap.put("title", post.getTitle());
                postMap.put("content", post.getContent());
                postMap.put("author_id", post.getAuthor_id());
                postMap.put("category", post.getCategory());
                postMap.put("status", post.getStatus());

                // 格式化创建时间
                if (post.getCreated_at() != null) {
                    String formattedTime = post.getCreated_at().format(DATE_FORMATTER);
                    postMap.put("formatted_created_at", formattedTime);
                } else {
                    postMap.put("formatted_created_at", "未知时间");
                }

                // 保留原始时间对象用于其他用途
                postMap.put("created_at", post.getCreated_at());
                postMap.put("updatedAt", post.getUpdatedAt());

                postList.add(postMap);
            }

            // 调试输出
            System.out.println("=== 论坛页面调试信息 ===");
            System.out.println("Session用户: " + (user != null ? user.getUsername() : "null"));
            System.out.println("获取到的帖子数量: " + postList.size());
            for (int i = 0; i < postList.size(); i++) {
                Map<String, Object> postMap = postList.get(i);
                System.out.println("帖子" + (i + 1) + ": ID=" + postMap.get("id") +
                        ", 标题=" + postMap.get("title") +
                        ", 格式化时间=" + postMap.get("formatted_created_at"));
            }
        }

        // 传递格式化后的帖子列表
        model.addAttribute("posts", postList);
        model.addAttribute("title", "学习交流社区");
        return "forum";
    }

    /**
     * 查看帖子详情
     */
    @GetMapping("/forum/detail/{id}")
    public String postDetail(@PathVariable("id") Integer id, Model model, HttpSession session) {
        try {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                model.addAttribute("user", user);
            }

            Post post = postService.getPostById(id);
            if (post == null) {
                model.addAttribute("error", "帖子不存在");
                return "error";
            }

            // 创建帖子详情Map，包含格式化时间
            Map<String, Object> postDetail = new HashMap<>();
            postDetail.put("id", post.getId());
            postDetail.put("title", post.getTitle());
            postDetail.put("content", post.getContent());
            postDetail.put("author_id", post.getAuthor_id());
            postDetail.put("category", post.getCategory());
            postDetail.put("status", post.getStatus());
            postDetail.put("updatedAt", post.getUpdatedAt());

            // 格式化创建时间
            if (post.getCreated_at() != null) {
                String formattedTime = post.getCreated_at().format(DETAIL_DATE_FORMATTER);
                postDetail.put("formatted_created_at", formattedTime);
            } else {
                postDetail.put("formatted_created_at", "未知时间");
            }

            // 保留原始时间
            postDetail.put("created_at", post.getCreated_at());

            System.out.println("获取帖子详情: ID=" + id + ", 标题=" + post.getTitle());
            model.addAttribute("post", postDetail);
            return "forum/detail";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "加载帖子详情失败：" + e.getMessage());
            return "error";
        }
    }

    /**
     * 发表新帖页面
     */
    @GetMapping("/forum/post")
    public String newPostPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        model.addAttribute("user", user);
        model.addAttribute("post", new Post());
        return "forum/post";
    }

    /**
     * 处理发表新帖
     */
    @PostMapping("/forum/post")
    public String createPost(@ModelAttribute Post post, HttpSession session, Model model) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            // 设置作者ID
            post.setAuthor_id(user.getId());
            post.setStatus("active");

            System.out.println("创建新帖: 标题=" + post.getTitle() + ", 作者=" + user.getId());
            boolean result = postService.addPost(post);

            if (result) {
                return "redirect:/home/forum";
            } else {
                model.addAttribute("error", "发表帖子失败");
                return "forum/post";
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "发表帖子失败：" + e.getMessage());
            return "forum/post";
        }
    }

    /**
     * 编辑帖子页面
     */
    @GetMapping("/forum/edit/{id}")
    public String editPostPage(@PathVariable("id") Integer id, HttpSession session, Model model) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            Post post = postService.getPostById(id);
            if (post == null) {
                model.addAttribute("error", "帖子不存在");
                return "error";
            }

            // 检查是否是帖子作者
            if (!post.getAuthor_id().equals(user.getId())) {
                model.addAttribute("error", "没有权限编辑该帖子");
                return "error";
            }

            model.addAttribute("user", user);
            model.addAttribute("post", post);
            return "forum";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "加载编辑页面失败：" + e.getMessage());
            return "error";
        }
    }

    /**
     * 处理编辑帖子
     */
    @PostMapping("/forum/edit/{id}")
    public String updatePost(@PathVariable("id") Integer id, @ModelAttribute Post post, HttpSession session, Model model) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            Post existingPost = postService.getPostById(id);
            if (existingPost == null) {
                model.addAttribute("error", "帖子不存在");
                return "error";
            }

            // 检查是否是帖子作者
            if (!existingPost.getAuthor_id().equals(user.getId())) {
                model.addAttribute("error", "没有权限编辑该帖子");
                return "error";
            }

            // 设置帖子ID
            post.setId(id);
            post.setAuthor_id(user.getId());
            post.setStatus("active");
            post.setCreated_at(existingPost.getCreated_at());

            boolean result = postService.updatePost(post);
            if (result) {
                return "redirect:/home/forum/detail/" + id;
            } else {
                model.addAttribute("error", "编辑帖子失败");
                return "forum";
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "编辑帖子失败：" + e.getMessage());
            return "forum";
        }
    }

    /**
     * 删除帖子
     */
    @GetMapping("/forum/delete/{id}")
    public String deletePost(@PathVariable("id") Integer id, HttpSession session, Model model) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/user/login";
            }

            Post post = postService.getPostById(id);
            if (post == null) {
                model.addAttribute("error", "帖子不存在");
                return "error";
            }

            // 检查是否是帖子作者
            if (!post.getAuthor_id().equals(user.getId())) {
                model.addAttribute("error", "没有权限删除该帖子");
                return "error";
            }

            boolean result = postService.deletePost(id);
            if (result) {
                return "redirect:/home/forum";
            } else {
                model.addAttribute("error", "删除帖子失败");
                return "error";
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "删除帖子失败：" + e.getMessage());
            return "error";
        }
    }
}