package com.learning.platform.mapper;

import com.learning.platform.entity.Exam;
import com.learning.platform.entity.ExamQuestion;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ExamMapper {

    // 根据ID查询考试
    @Select("SELECT * FROM exams WHERE id = #{id}")
    Exam findExamById(@Param("id") Integer id);

    // 根据考试ID查询题目
    @Select("SELECT * FROM exam_questions WHERE exam_id = #{examId} ORDER BY question_number")
    List<ExamQuestion> findQuestionsByExamId(@Param("examId") Integer examId);

    // 获取所有考试列表
    @Select("SELECT * FROM exams ORDER BY id")
    List<Exam> findAllExams();

    // 添加考试
    @Insert("INSERT INTO exams (exam_name, description, total_time, total_score, created_at) VALUES (#{exam_name}, #{description}, #{total_time}, #{total_score}, NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    int insertExam(Exam exam);

    // 更新考试
    @Update("UPDATE exams SET exam_name = #{exam_name}, description = #{description}, total_time = #{total_time}, total_score = #{total_score} WHERE id = #{id}")
    int updateExam(Exam exam);

    // 删除考试
    @Delete("DELETE FROM exams WHERE id = #{id}")
    int deleteExam(@Param("id") Integer id);

    // 删除考试的所有题目
    @Delete("DELETE FROM exam_questions WHERE exam_id = #{examId}")
    int deleteExamQuestions(@Param("examId") Integer examId);

    // 添加考试题目
    @Insert("INSERT INTO exam_questions (exam_id, question_id, question_number, score) VALUES (#{exam_id}, #{question_id}, #{question_number}, #{score})")
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    int insertExamQuestion(ExamQuestion examQuestion);

    // 更新考试题目
    @Update("UPDATE exam_questions SET question_id = #{question_id}, question_number = #{question_number}, score = #{score} WHERE id = #{id}")
    int updateExamQuestion(ExamQuestion examQuestion);

    // 删除考试题目
    @Delete("DELETE FROM exam_questions WHERE id = #{id}")
    int deleteExamQuestion(@Param("id") Integer id);
}
