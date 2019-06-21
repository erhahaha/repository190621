package com.nankai.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nankai.bean.User;
import com.nankai.dao.UserDao;
import com.nankai.service.UserService;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao userDao;
	
	@Override
	public String checkUserid(String userid) {
		User user = userDao.findByUserid(userid);
		if(user != null ){
			return "存在";
		}
		return "不存在";
	}
	
	/* 
	 * 检验用户登录业务
	 * 
	 */
	@Override
	public User checkLogin(String username, String password) {
		
		User user = userDao.findByUsername(username);
		if(user != null && user.getPassword().equals(password)){
		
			return user;
		}
		return null;
	}

	@Override
	public boolean addUser(User user) {
		if(userDao.register(user)==1){
			return true;
		}
		else{
			return false;
		}
		//System.out.println("插入的对象主键为："+user.getId());
	}
	
	@Override
	public boolean modifyUser(User user) {
		if(userDao.modify(user)==1){
			return true;
		}
		else{
			return false;
		}
	}
	
	@Override	
	public List<User> findAllUser(){
		return userDao.findAll();
	}
	
	@Override	
	public List<User> Choosefind(String name){
		return userDao.Choosefind(name);
	}
	
	@Override	
	public User ChoosefindByid(int userid){
		return userDao.findById(userid);
	}
	
	@Override
	public void deleteuser(int id){
		userDao.deletebyid(id);;
	}
}
