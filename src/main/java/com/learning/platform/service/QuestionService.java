// QuestionService.java
package com.learning.platform.service;

import com.learning.platform.entity.Question;
import com.learning.platform.mapper.QuestionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class QuestionService {

    @Autowired
    private QuestionMapper questionMapper;

    /**
     * 获取所有题目
     */
    public List<Question> getAllQuestions() {
        return questionMapper.findAllQuestions();
    }

    /**
     * 根据ID获取题目
     */
    public Question getQuestionById(Integer id) {
        return questionMapper.findQuestionById(id);
    }

    /**
     * 分页获取题目
     */
    public List<Question> getQuestionsByPage(Integer pageNum, Integer pageSize) {
        Integer offset = (pageNum - 1) * pageSize;
        return questionMapper.findQuestionsByPage(offset, pageSize);
    }

    /**
     * 获取题目总数
     */
    public int getQuestionCount() {
        return questionMapper.countQuestions();
    }

    /**
     * 根据分类获取题目（分页）
     */
    public List<Question> getQuestionsByCategory(String category, Integer pageNum, Integer pageSize) {
        Integer offset = (pageNum - 1) * pageSize;
        return questionMapper.findQuestionsByCategory(category, offset, pageSize);
    }

    /**
     * 获取某个分类的题目总数
     */
    public int getQuestionCountByCategory(String category) {
        return questionMapper.countQuestionsByCategory(category);
    }

    /**
     * 根据类型获取题目（分页）
     */
    public List<Question> getQuestionsByType(String type, Integer pageNum, Integer pageSize) {
        Integer offset = (pageNum - 1) * pageSize;
        return questionMapper.findQuestionsByType(type, offset, pageSize);
    }

    /**
     * 获取某个类型的题目总数
     */
    public int getQuestionCountByType(String type) {
        return questionMapper.countQuestionsByType(type);
    }

    /**
     * 根据分类和类型获取题目（分页）
     */
    public List<Question> getQuestionsByCategoryAndType(String category, String type, Integer pageNum, Integer pageSize) {
        Integer offset = (pageNum - 1) * pageSize;
        return questionMapper.findQuestionsByCategoryAndType(category, type, offset, pageSize);
    }

    /**
     * 获取某个分类和类型的题目总数
     */
    public int getQuestionCountByCategoryAndType(String category, String type) {
        return questionMapper.countQuestionsByCategoryAndType(category, type);
    }

    /**
     * 添加题目
     */
    public boolean addQuestion(Question question) {
        int result = questionMapper.insertQuestion(question);
        return result > 0;
    }

    /**
     * 更新题目
     */
    public boolean updateQuestion(Question question) {
        int result = questionMapper.updateQuestion(question);
        return result > 0;
    }

    /**
     * 删除题目
     */
    public boolean deleteQuestion(Integer id) {
        int result = questionMapper.deleteQuestion(id);
        return result > 0;
    }
}
