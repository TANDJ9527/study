package com.learning.platform.service;

import com.learning.platform.entity.Course;
import com.learning.platform.mapper.CourseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CourseService {

    @Autowired
    private CourseMapper courseMapper;

    /**
     * 获取所有课程
     */
    public List<Course> getAllCourses() {
        return courseMapper.findAllCourses();
    }

    /**
     * 根据ID获取课程
     */
    public Course getCourseById(Integer id) {
        return courseMapper.findCourseById(id);
    }

    /**
     * 分页获取课程
     */
    public List<Course> getCoursesByPage(Integer pageNum, Integer pageSize) {
        Integer offset = (pageNum - 1) * pageSize;
        return courseMapper.findCoursesByPage(offset, pageSize);
    }

    /**
     * 添加课程
     */
    public boolean addCourse(Course course) {
        int result = courseMapper.insertCourse(course);
        return result > 0;
    }

    /**
     * 更新课程
     */
    public boolean updateCourse(Course course) {
        int result = courseMapper.updateCourse(course);
        return result > 0;
    }

    /**
     * 删除课程
     */
    public boolean deleteCourse(Integer id) {
        int result = courseMapper.deleteCourse(id);
        return result > 0;
    }

    /**
     * 获取课程总数
     */
    public int getCourseCount() {
        return courseMapper.countCourses();
    }
    
    /**
     * 搜索课程
     */
    public List<Course> searchCourses(String keyword) {
        return courseMapper.searchCourses(keyword);
    }
}