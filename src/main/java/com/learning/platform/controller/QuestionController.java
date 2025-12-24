// QuestionController.java
package com.learning.platform.controller;

import com.learning.platform.entity.Question;
import com.learning.platform.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/home")
public class QuestionController {

    @Autowired
    private QuestionService questionService;

    /**
     * 题库练习页面
     */
    @GetMapping("/question")
    public String questionList(Model model,
                             @RequestParam(value = "page", defaultValue = "1") Integer page,
                             @RequestParam(value = "category", required = false) String category,
                             @RequestParam(value = "type", required = false) String type) {
        try {
            int pageSize = 10; // 每页显示10条记录

            List<Question> questions;
            int totalCount;

            if (category != null && type != null) {
                questions = questionService.getQuestionsByCategoryAndType(category, type, page, pageSize);
                totalCount = questionService.getQuestionCountByCategoryAndType(category, type);
            } else if (category != null) {
                questions = questionService.getQuestionsByCategory(category, page, pageSize);
                totalCount = questionService.getQuestionCountByCategory(category);
            } else if (type != null) {
                questions = questionService.getQuestionsByType(type, page, pageSize);
                totalCount = questionService.getQuestionCountByType(type);
            } else {
                questions = questionService.getQuestionsByPage(page, pageSize);
                totalCount = questionService.getQuestionCount();
            }

            int totalPages = (int) Math.ceil((double) totalCount / pageSize);

            // 添加调试信息
            System.out.println("=== 查询题目信息 ===");
            System.out.println("数据库记录总数: " + totalCount);
            System.out.println("查询到的题目数: " + (questions != null ? questions.size() : 0));
            if (questions != null && !questions.isEmpty()) {
                for (Question question : questions) {
                    System.out.println("题目ID: " + question.getId() + ", 内容: " + question.getContent());
                }
            }
            System.out.println("=== 查询结束 ===");

            // 确保数据正确传递
            model.addAttribute("questions", questions);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("category", category);
            model.addAttribute("type", type);

            return "question"; // 对应WEB-INF/views/question.jsp
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "获取题目列表失败：" + e.getMessage());
            return "error";
        }
    }

    /**
     * 查看题目详情
     */
    @GetMapping("/question/detail/{id}")
    public String questionDetail(@PathVariable("id") Integer id, Model model) {
        try {
            Question question = questionService.getQuestionById(id);
            if (question == null) {
                model.addAttribute("error", "题目不存在");
                return "error";
            }
            model.addAttribute("question", question);
            return "question/detail";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "加载题目详情失败：" + e.getMessage());
            return "error";
        }
    }
}
