package com.nankai.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.nankai.bean.ResultInfoVO;
import com.nankai.bean.User;
import com.nankai.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userServivce;

	/*
	 * //正常访问login页面
	 * 
	 * @RequestMapping("/login") public String login(){ return "login"; }
	 */

	// 注册功能
	@RequestMapping("/signup")
	public String signup(User user, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		if (userServivce.addUser(user)) {
			request.getSession().setAttribute("user", user);
			return "sectionElementshow";
		} else {
			out.print(
					"<script language='JavaScript'>alert('登录失败！');window.location.href='managerManEnterprise.jsp';</script>");
			return "redirect:/login.jsp";
		}
	}

	// 表单提交过来的路径
	@RequestMapping("/checkLogin")
	public String checkLogin(User user, Model model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		// 调用service方法
		user = userServivce.checkLogin(user.getUsername(), user.getPassword());
		// 若有user则添加到model里并且跳转到成功页面
		if (user != null) {
			// model.addAttribute("user",user);
			request.getSession().setAttribute("user", user);
			request.getSession().setAttribute("loginflag", "success");
			request.getSession().setAttribute("userid", user.getId());
			//return "sectionElementshow";
			return "home";
			// request.getRequestDispatcher("/WEB-INF/jsp/sectionElementshow.jsp").forward(request,
			// response);
		} else {
			//out.print("<script language='JavaScript'>alert('用户名或密码错误！');</script>");
			request.getSession().setAttribute("loginflag", "fail");
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return null;
		}

	}

	// 测试超链接跳转到另一个页面是否可以取到session值
	@RequestMapping("/anotherpage")
	public String hrefpage() {
		return "anotherpage";
	}

	// 注销方法
	@RequestMapping("/outLogin")
	public String outLogin(HttpSession session) {
		// 通过session.invalidata()方法来注销当前的session
		session.invalidate();
		return "redirect:/login.jsp";
	}

	// 查询所有用户
	@RequestMapping(value = "/requestall", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO requestAll() {
		ResultInfoVO vo = new ResultInfoVO();
		List<User> allusers = userServivce.findAllUser();
		Map<String, Object> map = new HashMap();
		map.put("allusers", allusers);
		vo.setObject(map);
		return vo;
	}

	// 查询选择用户
	@RequestMapping(value = "/chooserequest", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO requestOne(String name) {
		ResultInfoVO vo = new ResultInfoVO();
		List<User> chooseusers = userServivce.Choosefind(name);
		int result = 0;
		if (chooseusers.size() != 0) {
			result = 1;
		}
		Map<String, Object> map = new HashMap();
		map.put("chooseusers", chooseusers);
		map.put("result", result);
		vo.setObject(map);
		return vo;
	}
	
	@RequestMapping(value = "/chooserequestbyid", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO requestOneById(String userid) {
		int intuserid = Integer.parseInt(userid);
		ResultInfoVO vo = new ResultInfoVO();
		User requestuser = userServivce.ChoosefindByid(intuserid);
		Map<String, Object> map = new HashMap();
		map.put("requestuser", requestuser);
		vo.setObject(map);
		return vo;
	}

	// 查询选择用户
	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO addUser(String userid, String username, String password, String level, String job,
			String jobphone, String linkphone, String email, String address) {
		ResultInfoVO vo = new ResultInfoVO();
		int intlevel = Integer.parseInt(level);
		User user = new User();
		user.setUserid(userid);
		user.setUsername(username);
		user.setPassword(password);
		user.setLevel(intlevel);
		user.setJob(job);
		user.setJobphone(jobphone);
		user.setLinkphone(linkphone);
		user.setEmail(email);
		user.setAddress(address);
		String result;
		if (userServivce.addUser(user)) {
			result = "success";
		} else {
			result = "fail";
		}
		// List<User> chooseusers=userServivce.Choosefind(name);
		Map<String, Object> map = new HashMap();
		map.put("result", result);
		vo.setObject(map);
		return vo;
	}
	

		//修改用户
		@RequestMapping(value = "/modifyuser", method = RequestMethod.POST)
		@ResponseBody
		public ResultInfoVO modifyuser(String userid,String password, String level, String job,String jobphone, String linkphone, String email, String address) {
			ResultInfoVO vo = new ResultInfoVO();
			int intlevel = Integer.parseInt(level);
			User user = new User();
			user.setUserid(userid);
			user.setPassword(password);
			user.setLevel(intlevel);
			user.setJob(job);
			user.setJobphone(jobphone);
			user.setLinkphone(linkphone);
			user.setEmail(email);
			user.setAddress(address);
			String result;
			if (userServivce.modifyUser(user)) {
				result = "success";
			} else {
				result = "fail";
			}
			// List<User> chooseusers=userServivce.Choosefind(name);
			Map<String, Object> map = new HashMap();
			map.put("result", result);
			vo.setObject(map);
			return vo;
		}

	//删除用户
	@RequestMapping(value = "/deleteuser", method = RequestMethod.POST)
	@ResponseBody
	public void deleteuser(String id) {
		int thisid = Integer.parseInt(id);
		userServivce.deleteuser(thisid);
	}
	
	//查看用户是否存在
	@RequestMapping(value = "/checkisuserid", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO checkisuserid(String userid) {
		ResultInfoVO vo = new ResultInfoVO();
		String result=userServivce.checkUserid(userid);
		Map<String, Object> map = new HashMap();
		map.put("result", result);
		vo.setObject(map);
		return vo;
	}
	
	@RequestMapping("/useradd")
	public String useradd() {
		return "UserAdd";
	}
	
	@RequestMapping("/userMana")
	public String userMana() {
		return "ManaUser";
	}
	
	@RequestMapping("/userModify")
	public String userModify() {
		return "modifyUser";
	}
}
