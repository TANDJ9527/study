package com.learning.platform.service;

import com.learning.platform.entity.Exam;
import com.learning.platform.entity.ExamQuestion;
import com.learning.platform.mapper.ExamMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ExamService {

    @Autowired
    private ExamMapper examMapper;

    public Exam getExamById(Integer id) {
        return examMapper.findExamById(id);
    }

    public List<Exam> getAllExams() {
        return examMapper.findAllExams();
    }

    public boolean addExam(Exam exam) {
        try {
            int result = examMapper.insertExam(exam);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("添加考试失败: " + e.getMessage(), e);
        }
    }

    public boolean updateExam(Exam exam) {
        try {
            int result = examMapper.updateExam(exam);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("更新考试失败: " + e.getMessage(), e);
        }
    }

    public boolean deleteExam(Integer id) {
        try {
            // 先删除考试的所有题目
            examMapper.deleteExamQuestions(id);
            // 再删除考试
            int result = examMapper.deleteExam(id);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("删除考试失败: " + e.getMessage(), e);
        }
    }

    public List<ExamQuestion> getExamQuestions(Integer examId) {
        try {
            return examMapper.findQuestionsByExamId(examId);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("获取考试题目失败: " + e.getMessage(), e);
        }
    }

    public boolean addExamQuestion(ExamQuestion examQuestion) {
        try {
            int result = examMapper.insertExamQuestion(examQuestion);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("添加考试题目失败: " + e.getMessage(), e);
        }
    }

    public boolean updateExamQuestion(ExamQuestion examQuestion) {
        try {
            int result = examMapper.updateExamQuestion(examQuestion);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("更新考试题目失败: " + e.getMessage(), e);
        }
    }

    public boolean deleteExamQuestion(Integer id) {
        try {
            int result = examMapper.deleteExamQuestion(id);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("删除考试题目失败: " + e.getMessage(), e);
        }
    }
}

