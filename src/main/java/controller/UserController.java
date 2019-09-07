package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pojo.Order;
import pojo.User;
import service.OrderService;
import service.UserService;
import util.Page;

@RequestMapping("")
@Controller
public class UserController {
	@Autowired
	UserService userService;
	
	@Autowired
	OrderService orderService;
	//登陆界面
	@RequestMapping("/tologin")
	public ModelAndView tologin(HttpServletRequest req,HttpServletResponse res) throws IOException, ServletException {
		ModelAndView mav=new ModelAndView("login");
		return mav;
	}
	//个人信息界面
	@RequestMapping("/user")
	public ModelAndView user(HttpServletRequest req,HttpServletResponse res) throws IOException, ServletException {
		ModelAndView mav=new ModelAndView("user");
		return mav;
	}
	//登陆验证
	@RequestMapping("/login")
	public @ResponseBody Object login(HttpServletRequest req) {
		if(userService.selectByUsername(req.getParameter("username"))==null)
			return "noUsername";
		User u=new User();
		u.setUsername(req.getParameter("username"));
		u.setPassword(req.getParameter("password"));
		User user=userService.login(u);
		if(user==null)
			return "passwordError";
		req.getSession().setAttribute("user", user);
		return "success";
	}
	//登出
	@RequestMapping("/logout")
	public @ResponseBody Object logout(HttpServletRequest req){
		req.getSession().removeAttribute("user");
		return "success";
	}
	//获取结果数
	@RequestMapping("/getResultNum")
	public @ResponseBody int getResultNum(HttpServletRequest req){
		User user=new User();
		if(req.getParameter("id")!=null)
			user.setId(Integer.parseInt(req.getParameter("id")));
		if(req.getParameter("username")!=null)
			user.setUsername(req.getParameter("username"));
		if(req.getParameter("name")!=null)
			user.setName(req.getParameter("name"));
		return userService.selectAll(user);
	}
	//注册新用户
	@RequestMapping("/addUser")
	@ResponseBody
	public  String addUser(HttpServletRequest req){
		if(userService.selectByUsername(req.getParameter("username"))!=null) {
			return "fail";
		}
		User user=new User();
		user.setUsername(req.getParameter("username"));
		user.setPassword(req.getParameter("password"));
		user.setName(req.getParameter("name"));
		user.setPhone(req.getParameter("phone"));
		user.setBalance(Integer.parseInt(req.getParameter("balance")));
		user.setPower(Integer.parseInt(req.getParameter("power")));
		if(userService.add(user)>0)
			return "success";
		return "error";
	}
	//查询用户
	@RequestMapping("/getUsers")
	public @ResponseBody List<User> getUsers(HttpServletRequest req) {
		User user=new User();
		Page page=new Page();
		if(req.getParameter("id")!=null)
			user.setId(Integer.parseInt(req.getParameter("id")));
		if(req.getParameter("username")!=null)
			user.setUsername(req.getParameter("username"));
		if(req.getParameter("name")!=null)
			user.setName(req.getParameter("name"));
		if(req.getParameter("phone")!=null)
			user.setPhone(req.getParameter("phone"));
		if(req.getParameter("power")!=null)
			user.setPower(1);
		if(req.getParameter("balance")!=null)
			user.setBalance(1);
		if(req.getParameter("nowPage")!=null) {			
			page.setNowPage(Integer.parseInt(req.getParameter("nowPage")));
		}
		page.setGetSelect(10);
		page.toSumStart();
		user.setPage(page);
		return userService.getUsers(user);
	}
	//删除用户
	@RequestMapping("/deleteUser")
	public @ResponseBody Object deleteUser(HttpServletRequest req) {
		String id=req.getParameter("id");
		if(id==null || id=="")
			return "fail no id";
		else if(userService.delete(Integer.parseInt(id))>0)
				return "success";
		return "fail";
	}
	//修改用户信息
	@RequestMapping("/updateUser")
	public @ResponseBody Object updateUser(@RequestParam("id")int id,
											@RequestParam("username")String username,
											@RequestParam("password")String password,
											@RequestParam("name")String name,
											@RequestParam("phone")String phone,
											@RequestParam("balance")int balance,
											@RequestParam("power")int power) {
		try {
			name=new String(name.getBytes("iso-8859-1"),"utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		User user=new User();
		user.setId(id);
		user.setUsername(username);
		user.setPassword(password);
		user.setName(name);
		user.setPhone(phone);
		user.setBalance(balance);
		user.setPower(power);
		if(userService.update(user)>0)
			return "success";
		return "fail";
	}
	//账户充值
	@RequestMapping("/recharge")
	public @ResponseBody Object recharge(HttpServletRequest req) {
		float recharge=Float.parseFloat(req.getParameter("recharge"));
		Order order=new Order();
		User user=(User)req.getSession().getAttribute("user");
		order.setPayModel(req.getParameter("payModel"));
		order.setUserId(user.getId());
		order.setPayTime(new Timestamp(System.currentTimeMillis()));
		order.setPayMoney(recharge);
		order.setOrderType("充值");
		//插入订单表
		orderService.addOrder(order);
		//修改用户余额
		user.setBalance(user.getBalance()+recharge);
		if(userService.update(user)>0)
			return "success";
		return "fail";
	}
}
