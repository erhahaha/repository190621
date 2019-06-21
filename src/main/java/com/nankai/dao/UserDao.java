package com.nankai.dao;

import java.util.List;

import com.nankai.bean.User;

public interface UserDao {

	/**
	 * 查找用户名和密码
	 * 
	 * @param username
	 *            登录用户名
	 * @param password
	 *            密码
	 * @return
	 */
	User findByUsername(String username);
	
	User findByUserid(String userid);
	
	User findById(int id);

	/**
	 * 注册用户和密码
	 * 
	 * @param username
	 *            用户名
	 * @param password
	 *            密码
	 * @return
	 */
	int register(User user);
	
	int modify(User user);

	/***
	 * 批量插入用户信息
	 */
	void insertintoUserwithbath(List<User> userList);

	/**
	 * 查找所有用户名的信息
	 */
	List<User> findAll();
	
	/**
	 * 查找指定用户名的信息
	 */
	List<User> Choosefind(String name);
	
	/**
	 * 删除用户
	 */
	void deletebyid(int id);
	
}
