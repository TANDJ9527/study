// QuestionMapper.java
package com.learning.platform.mapper;

import com.learning.platform.entity.Question;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface QuestionMapper {

    // 查询所有题目
    @Select("SELECT * FROM question ORDER BY id")
    List<Question> findAllQuestions();

    // 根据ID查询题目
    @Select("SELECT * FROM question WHERE id = #{id}")
    Question findQuestionById(@Param("id") Integer id);

    // 根据分类查询题目
    @Select("SELECT * FROM question WHERE category = #{category} ORDER BY id LIMIT #{offset}, #{pageSize}")
    List<Question> findQuestionsByCategory(@Param("category") String category,
                                          @Param("offset") Integer offset,
                                          @Param("pageSize")Integer pageSize);

    // 根据类型查询题目
    @Select("SELECT * FROM question WHERE type = #{type} ORDER BY id LIMIT #{offset}, #{pageSize}")
    List<Question> findQuestionsByType(@Param("type") String type,
                                       @Param("offset")Integer offset,
                                       @Param("pageSize")Integer pageSize);

    // 根据分类和类型查询题目
    @Select("SELECT * FROM question WHERE category = #{category} AND type = #{type} ORDER BY id LIMIT #{offset}, #{pageSize}")
    List<Question> findQuestionsByCategoryAndType(@Param("category") String category,
                                                  @Param("type") String type,
                                                  @Param("offset")Integer offset,
                                                  @Param("pageSize")Integer pageSize);

    // 分页查询题目
    @Select("SELECT * FROM question ORDER BY id LIMIT #{offset}, #{pageSize}")
    List<Question> findQuestionsByPage(@Param("offset") Integer offset, @Param("pageSize") Integer pageSize);

    // 统计题目总数
    @Select("SELECT COUNT(*) FROM question")
    int countQuestions();

    // 统计某个分类的题目总数
    @Select("SELECT COUNT(*) FROM question WHERE category = #{category}")
    int countQuestionsByCategory(@Param("category") String category);

    // 统计某个类型的题目总数
    @Select("SELECT COUNT(*) FROM question WHERE type = #{type}")
    int countQuestionsByType(@Param("type") String type);

    // 统计某个分类和类型的题目总数
    @Select("SELECT COUNT(*) from question where category = #{category} and type = #{type}")
    int countQuestionsByCategoryAndType(@Param("category") String category,
                                        @Param("type") String type);

    // 添加新题目
    @Insert("INSERT INTO question(content, type, difficulty, answer, analysis, category) VALUES (#{content}, #{type}, #{difficulty}, #{answer}, #{analysis}, #{category})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insertQuestion(Question question);

    // 更新题目
    @Update("UPDATE question SET content = #{content}, type = #{type}, difficulty = #{difficulty}, answer = #{answer}, analysis = #{analysis}, category = #{category} WHERE id = #{id}")
    int updateQuestion(Question question);

    // 删除题目
    @Delete("DELETE FROM question WHERE id = #{id}")
    int deleteQuestion(@Param("id") Integer id);
}
