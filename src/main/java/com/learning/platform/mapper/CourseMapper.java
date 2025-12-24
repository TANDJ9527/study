package com.learning.platform.mapper;

import com.learning.platform.entity.Course;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CourseMapper {

    // 查询所有课程
    @Select("SELECT id, course_name, description, price FROM course ORDER BY id")
    List<Course> findAllCourses();

    // 根据ID查询课程
    @Select("SELECT id, course_name, description, price FROM course WHERE id = #{id}")
    Course findCourseById(@Param("id") Integer id);

    // 添加新课程
    @Insert("INSERT INTO course (course_name, description, price) VALUES (#{course_name}, #{description}, #{price})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insertCourse(Course course);

    // 更新课程
    @Update("UPDATE course SET course_name = #{course_name}, description = #{description}, price = #{price} WHERE id = #{id}")
    int updateCourse(Course course);

    // 删除课程
    @Delete("DELETE FROM course WHERE id = #{id}")
    int deleteCourse(@Param("id") Integer id);

    // 分页查询
    @Select("SELECT id, course_name, description, price FROM course ORDER BY id LIMIT #{offset}, #{pageSize}")
    List<Course> findCoursesByPage(@Param("offset") Integer offset, @Param("pageSize") Integer pageSize);

    // 统计课程总数
    @Select("SELECT COUNT(*) FROM course")
    int countCourses();
    
    // 搜索课程
    @Select("SELECT id, course_name, description, price FROM course WHERE course_name LIKE CONCAT('%', #{keyword}, '%') OR description LIKE CONCAT('%', #{keyword}, '%')")
    List<Course> searchCourses(@Param("keyword") String keyword);
}