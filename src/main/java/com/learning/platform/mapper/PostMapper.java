package com.learning.platform.mapper;

import com.learning.platform.entity.Post;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface PostMapper {

    // 查询所有帖子，按创建时间倒序排列
    @Select("SELECT * FROM post WHERE status = 'active' ORDER BY created_at DESC")
    @Results({
            @Result(property = "id", column = "id"),
            @Result(property = "title", column = "title"),
            @Result(property = "content", column = "content"),
            @Result(property = "author_id", column = "author_id"),
            @Result(property = "category", column = "category"),
            @Result(property = "created_at", column = "created_at"),
            @Result(property = "updatedAt", column = "updated_at"),
            @Result(property = "status", column = "status")
    })
    List<Post> findAllPosts();

    // 根据ID查询帖子
    @Select("SELECT * FROM post WHERE id = #{id}")
    @Results({
            @Result(property = "id", column = "id"),
            @Result(property = "title", column = "title"),
            @Result(property = "content", column = "content"),
            @Result(property = "author_id", column = "author_id"),
            @Result(property = "category", column = "category"),
            @Result(property = "created_at", column = "created_at"),
            @Result(property = "updatedAt", column = "updated_at"),
            @Result(property = "status", column = "status")
    })
    Post findPostById(@Param("id") Integer id);

    // 添加新帖子
    @Insert("INSERT INTO post (title, content, author_id, category, created_at, status) " +
            "VALUES (#{title}, #{content}, #{author_id}, #{category}, NOW(), #{status})")
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    int insertPost(Post post);

    // 更新帖子
    @Update("UPDATE post SET title = #{title}, content = #{content}, " +
            "category = #{category}, updated_at = NOW() WHERE id = #{id}")
    int updatePost(Post post);

    // 删除帖子（标记为删除）
    @Update("UPDATE post SET status = 'deleted' WHERE id = #{id}")
    int deletePost(@Param("id") Integer id);
}