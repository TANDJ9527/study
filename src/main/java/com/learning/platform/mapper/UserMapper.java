package com.learning.platform.mapper;

import com.learning.platform.entity.User;
import org.apache.ibatis.annotations.*;

@Mapper
public interface UserMapper {

    @Select("select * from user where username = #{username} and password = #{password}")
    User findByUsernameAndPassword(@Param("username") String username,
                                   @Param("password") String password);

    @Select("select * from user where username = #{username}")
    User findByUsername(@Param("username") String username);

    @Select("select * from user where id = #{id}")
    User findUserById(@Param("id") Integer id);

    @Insert("insert into user(username, password, email) values (#{username}, #{password}, #{email})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(User user);

    @Select("select count(*) from user where username = #{username}")
    int countByUsername(@Param("username") String username);

    @Update("update user set email = #{email} where id = #{id}")
    int update(User user);

    @Update("update user set password = #{password} where id = #{id}")
    int updatePassword(@Param("id") Integer id, @Param("password") String password);

    @Update("update user set username = #{username}, email = #{email} where id = #{id}")
    int updateUserInfo(User user);
}