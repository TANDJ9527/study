package com.learning.platform.entity;

// Exam.java
public class Exam {
    private int id;
    private String exam_name;
    private String description;
    private int total_score;
    private int total_time;
    private String created_at;

    // 构造函数
    public Exam() {}

    // getter和setter方法
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getExam_name() { return exam_name; }
    public void setExam_name(String exam_name) { this.exam_name = exam_name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getTotal_score() { return total_score; }
    public void setTotal_score(int total_score) { this.total_score = total_score; }

    public int getTotal_time() { return total_time; }
    public void setTotal_time(int total_time) { this.total_time = total_time; }

    public String getCreated_at() { return created_at; }
    public void setCreated_at(String created_at) { this.created_at = created_at; }
}
