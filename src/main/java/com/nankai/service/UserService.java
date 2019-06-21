package com.nankai.service;


import java.util.List;

import com.nankai.bean.User;

//Service层接口
public interface UserService {
	
	//检验用户登录
	User checkLogin(String username,String password);

	boolean addUser(User user);
	
	boolean modifyUser(User user);

	List<User> findAllUser();

	List<User> Choosefind(String name);

	void deleteuser(int id);

	String checkUserid(String userid);

	User ChoosefindByid(int userid);

}
