package com.learning.platform.controller;

import com.learning.platform.entity.Exam;
import com.learning.platform.entity.ExamQuestion;
import com.learning.platform.service.ExamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/home")
public class ExamController {

    @Autowired
    private ExamService examService;

    /**
     * 考试列表页面
     */
    @GetMapping("/exam")
    public String examList(Model model) {
        try {
            List<Exam> exams = examService.getAllExams();
            model.addAttribute("exams", exams);
            return "examList";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "获取考试列表失败：" + e.getMessage());
            return "error";
        }
    }

    /**
     * 考试详情页面
     */
    @GetMapping("/exam/{id}")
    public String examDetail(@PathVariable("id") Integer id, Model model) {
        try {
            // 获取实际考试数据
            Exam exam = examService.getExamById(id);
            List<ExamQuestion> questions = examService.getExamQuestions(id);
            
            // 如果数据库中没有设置总题数，则从题目列表计算
            // 注意：这里只是临时解决方案，理想情况下总题数应该在添加题目时自动更新
            
            model.addAttribute("exam", exam);
            model.addAttribute("questions", questions);
            return "exam";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "加载考试失败：" + e.getMessage());
            return "error";
        }
    }

}
