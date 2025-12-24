package com.learning.platform.service;

import com.learning.platform.mapper.UserMapper;
import com.learning.platform.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@Service
@Transactional
public class UserService {

    @Autowired
    private UserMapper userMapper;  // 使用UserMapper而不是UserDao

    /**
     * 密码加密
     */
    private String encryptPassword(String password) {
        if (StringUtils.isEmpty(password)) {
            return null;
        }
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            byte[] bytes = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return password; // 如果加密失败，返回原密码
        }
    }

    /**
     * 用户登录（加密密码）
     */
    public User login(String username, String password) {
        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
            return null;
        }

        // 加密密码后查询
        String encryptedPassword = encryptPassword(password);
        User user = userMapper.findByUsernameAndPassword(username, encryptedPassword);

        if (user != null) {
            // 登录成功后清除密码
            user.setPassword(null);
        }

        return user;
    }

    /**
     * 用户注册（加密密码）
     */
    public boolean register(User user) {
        if (user == null || StringUtils.isEmpty(user.getUsername())
                || StringUtils.isEmpty(user.getPassword())) {
            return false;
        }

        // 检查用户名是否已存在
        if (userMapper.countByUsername(user.getUsername()) > 0) {
            return false;
        }

        // 加密密码后保存
        String encryptedPassword = encryptPassword(user.getPassword());
        user.setPassword(encryptedPassword);
        return userMapper.insert(user) > 0;
    }

    /**
     * 根据用户名查询用户
     */
    public User findByUsername(String username) {
        User user = userMapper.findByUsername(username);
        if (user != null) {
            user.setPassword(null);
        }
        return user;
    }

    /**
     * 更新用户信息
     */
    public boolean updateUser(User user) {
        if (user == null || user.getId() == null) {
            return false;
        }
        return userMapper.updateUserInfo(user) > 0;
    }

    /**
     * 修改密码
     */
    public boolean changePassword(Integer userId, String oldPassword, String newPassword) {
        if (userId == null || StringUtils.isEmpty(oldPassword) || StringUtils.isEmpty(newPassword)) {
            return false;
        }

        // 检查旧密码是否正确
        User user = userMapper.findUserById(userId);
        if (user == null) {
            return false;
        }

        String encryptedOldPassword = encryptPassword(oldPassword);
        if (!user.getPassword().equals(encryptedOldPassword)) {
            return false;
        }

        // 加密新密码并更新
        String encryptedNewPassword = encryptPassword(newPassword);
        return userMapper.updatePassword(userId, encryptedNewPassword) > 0;
    }

    /**
     * 根据ID查询用户
     */
    public User findUserById(Integer id) {
        if (id == null) {
            return null;
        }
        User user = userMapper.findUserById(id);
        if (user != null) {
            user.setPassword(null);
        }
        return user;
    }
}