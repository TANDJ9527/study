package com.learning.platform.controller;

import com.learning.platform.entity.Course;
import com.learning.platform.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/home")  // 修改为/home，与JSP链接匹配
public class CourseController {

    @Autowired
    private CourseService courseService;

    /**
     * 课程列表页面
     * 改为@GetMapping("/course") 与JSP链接匹配
     */
    @GetMapping("/course")
    public String courseList(Model model,
                             @RequestParam(value = "page", defaultValue = "1") Integer page) {
        try {
            int pageSize = 10; // 每显示10条记录
            int totalCount = courseService.getCourseCount();
            int totalPages = (int) Math.ceil((double) totalCount / pageSize);

            List<Course> courses = courseService.getCoursesByPage(page, pageSize);

            // 添加调试信息
            System.out.println("=== 查询课程信息 ===");
            System.out.println("数据库记录总数: " + totalCount);
            System.out.println("查询到的课程数: " + (courses != null ? courses.size() : 0));
            if (courses != null && !courses.isEmpty()) {
                for (Course course : courses) {
                    System.out.println("课程ID: " + course.getId() + ", 名称: " + course.getCourse_name());
                }
            }
            System.out.println("=== 查询结束 ===");

            // 确保数据正确传递
            model.addAttribute("courses", courses);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("totalCount", totalCount);

            return "course"; // 对应WEB-inf/views/course.jsp
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "获取课程列表失败：" + e.getMessage());
            return "error";
        }
    }
    /**
     * 开始学习课程
     */
    @GetMapping("/course/study")
    public String studyCourse(@RequestParam("id") Integer id, Model model) {
        try {
            Course course = courseService.getCourseById(id);
            if (course == null) {
                model.addAttribute("error", "课程不存在");
                return "error";
            }
            model.addAttribute("course", course);
            return "course/study"; // 对应WEB-INF/views/course/study.jsp
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "加载课程学习页面失败：" + e.getMessage());
            return "error";
        }
    }


    /**
     * 课程详情页面
     */
    @GetMapping("/course/detail")
    public String courseDetail(@RequestParam("id") Integer id,
                               Model model) {
        try {
            if (id == null) {
                model.addAttribute("error", "课程ID不能为空");
                return "error";
            }

            Course course = courseService.getCourseById(id);
            if (course == null) {
                model.addAttribute("error", "课程不存在");
                return "error";
            }
            model.addAttribute("course", course);
            return "course/detail";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "获取课程详情失败：" + e.getMessage());
            return "error";
        }
    }

    /**
     * 跳转到添加课程页面
     */
    @GetMapping("/course/add")
    public String showAddForm(Model model) {
        model.addAttribute("course", new Course());
        return "course";
    }

    /**
     * 添加课程
     */
    @PostMapping("/course/add")
    public String addCourse(@ModelAttribute Course course,
                            RedirectAttributes redirectAttributes) {
        try {
            boolean result = courseService.addCourse(course);
            if (result) {
                redirectAttributes.addFlashAttribute("success", "课程添加成功");
                return "redirect:/home/course";  // 修改重定向路径
            } else {
                redirectAttributes.addFlashAttribute("error", "课程添加失败");
                return "redirect:/home/course/add";
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "添加课程失败：" + e.getMessage());
            return "redirect:/home/course/add";
        }
    }

    /**
     * 跳转到编辑课程页面
     */
    @GetMapping("/course/edit/{id}")
    public String showEditForm(@PathVariable("id") Integer id, Model model) {
        try {
            Course course = courseService.getCourseById(id);
            if (course == null) {
                model.addAttribute("error", "课程不存在");
                return "error";
            }
            model.addAttribute("course", course);
            return "course";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "加载课程失败：" + e.getMessage());
            return "error";
        }
    }

    /**
     * 更新课程
     */
    @PostMapping("/course/update")
    public String updateCourse(@ModelAttribute Course course,
                               RedirectAttributes redirectAttributes) {
        try {
            boolean result = courseService.updateCourse(course);
            if (result) {
                redirectAttributes.addFlashAttribute("success", "课程更新成功");
                return "redirect:/home/course";  // 修改重定向路径
            } else {
                redirectAttributes.addFlashAttribute("error", "课程更新失败");
                return "redirect:/home/course/edit/" + course.getId();
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "更新课程失败：" + e.getMessage());
            return "redirect:/home/course/edit/" + course.getId();
        }
    }

    /**
     * 删除课程
     */
    @GetMapping("/course/delete/{id}")
    public String deleteCourse(@PathVariable("id") Integer id,
                               RedirectAttributes redirectAttributes) {
        try {
            boolean result = courseService.deleteCourse(id);
            if (result) {
                redirectAttributes.addFlashAttribute("success", "课程删除成功");
            } else {
                redirectAttributes.addFlashAttribute("error", "课程删除失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "删除课程失败：" + e.getMessage());
        }
        return "redirect:/home/course";  // 修改重定向路径
    }

    /**
     * 搜索课程
     */
    @GetMapping("/course/search")
    public String searchCourses(@RequestParam("keyword") String keyword, Model model) {
        try {
            List<Course> courses = courseService.searchCourses(keyword);

            model.addAttribute("courses", courses);
            model.addAttribute("keyword", keyword);
            return "course";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "搜索课程失败：" + e.getMessage());
            return "error";
        }
    }
}