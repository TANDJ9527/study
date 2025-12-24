package com.learning.platform.entity;

public class Course {
    private Integer id;
    private String course_name;
    private String description;
    private Double price;

    // 构造函数
    public Course() {}

    public Course(String course_name, String description, Double price) {
        this.course_name = course_name;
        this.description = description;
        this.price = price;
    }

    // Getter和Setter方法
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCourse_name() {
        return course_name;
    }

    public void setCourse_name(String course_name) {
        this.course_name = course_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}
