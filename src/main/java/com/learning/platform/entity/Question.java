// Question.java
package com.learning.platform.entity;

import java.util.List;

public class Question {
    private Integer id;
    private String content;
    private String type;
    private String difficulty;
    private String answer;
    private String analysis;
    private String category;

    // 新增：选项列表
    private List<String> options;

    // getter和setter方法
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getDifficulty() { return difficulty; }
    public void setDifficulty(String difficulty) { this.difficulty = difficulty; }

    public String getAnswer() { return answer; }
    public void setAnswer(String answer) { this.answer = answer; }

    public String getAnalysis() { return analysis; }
    public void setAnalysis(String analysis) { this.analysis = analysis; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public List<String> getOptions() { return options; }
    public void setOptions(List<String> options) { this.options = options; }
}
