package com.learning.platform.service;

import com.learning.platform.entity.Post;
import com.learning.platform.mapper.PostMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class PostService {

    @Autowired
    private PostMapper postMapper;

    /**
     * 获取所有有效帖子
     */
    public List<Post> getAllPosts() {
        try {
            List<Post> posts = postMapper.findAllPosts();
            System.out.println("Service层获取到 " + (posts != null ? posts.size() : 0) + " 条帖子");
            if (posts != null && !posts.isEmpty()) {
                for (Post post : posts) {
                    System.out.println("Service层帖子: " + post.getTitle());
                }
            }
            return posts;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("获取帖子列表失败: " + e.getMessage(), e);
        }
    }

    /**
     * 根据ID获取帖子
     */
    public Post getPostById(Integer id) {
        try {
            return postMapper.findPostById(id);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("获取帖子详情失败: " + e.getMessage(), e);
        }
    }

    /**
     * 添加帖子
     */
    public boolean addPost(Post post) {
        try {
            int result = postMapper.insertPost(post);
            System.out.println("插入结果: " + (result > 0 ? "成功" : "失败") + ", 帖子ID: " + post.getId());
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("添加帖子失败: " + e.getMessage(), e);
        }
    }

    /**
     * 更新帖子
     */
    public boolean updatePost(Post post) {
        try {
            int result = postMapper.updatePost(post);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("更新帖子失败: " + e.getMessage(), e);
        }
    }

    /**
     * 删除帖子
     */
    public boolean deletePost(Integer id) {
        try {
            int result = postMapper.deletePost(id);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("删除帖子失败: " + e.getMessage(), e);
        }
    }
}