package com.learning.platform.entity;

import java.time.LocalDateTime;

public class Post {
    private Integer id;
    private String title;
    private String content;
    private Integer author_id;  // 数据库字段是下划线
    private String category;
    private LocalDateTime created_at;  // 数据库字段是下划线
    private LocalDateTime updatedAt;
    private String status;

    // 添加 JSP 需要的 getter 方法
    public Integer getAuthorId() {
        return author_id;
    }

    public LocalDateTime getCreatedAt() {
        return created_at;
    }

    // 原有的 getter 和 setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public Integer getAuthor_id() { return author_id; }
    public void setAuthor_id(Integer author_id) { this.author_id = author_id; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public LocalDateTime getCreated_at() { return created_at; }
    public void setCreated_at(LocalDateTime created_at) { this.created_at = created_at; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}