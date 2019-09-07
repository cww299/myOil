package controller;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.json.JSONArray;
import pojo.Order;
import pojo.Product;
import pojo.User;
import service.OrderService;
import service.UserService;
import util.Page;

@Controller
@RequestMapping("")
public class OrderController {
	@Autowired
	OrderService orderService;
	@Autowired
	UserService userService;
	
	@RequestMapping("/addOrder")
	public @ResponseBody Object addOrder(HttpServletRequest req) {
		return "fail";
	}
	
	@RequestMapping("/deleteOrder")
	public @ResponseBody Object deleteOrder(HttpServletRequest req) {
		return "fail";
	}
	
	@RequestMapping("/updateOrder")
	public @ResponseBody Object updateOrder(HttpServletRequest req) {
		return "fail";
	}
	
	//获取订单列表
	@RequestMapping("/getOrderList")
	public @ResponseBody List<Order> getOrderList(HttpServletRequest req){
		int userId=Integer.parseInt(req.getParameter("userId"));
		int nowPage=Integer.parseInt(req.getParameter("nowPage"));
		Page page=new Page();
		Order order=new Order();
		page.setNowPage(nowPage);
		page.setGetSelect(10);
		page.toSumStart();
		order.setPage(page);
		order.setOrderType(null);
		order.setUserId(userId);
		return orderService.getOrderList(order);
	}
	
	//获取订单内容
	@RequestMapping("/getOrderContent")
	public @ResponseBody List<Order> getOrderContent(HttpServletRequest req){
		Order order=new Order();
		order.setId(Integer.parseInt(req.getParameter("id")));
		return orderService.getOrderContent(order);
	}
	
	
	//获取订单列表数目，用于分页
	@RequestMapping("/getOrderListResult")
	public @ResponseBody Object getOrderListResult(HttpServletRequest req) {
		int userId=Integer.parseInt(req.getParameter("userId"));
		Order order=new Order();
		order.setOrderType(null);
		order.setUserId(userId);
		return orderService.getOrderListResult(order);
	}
	
	//订单支付
	@SuppressWarnings("unchecked")
	@RequestMapping("/pay")
	public @ResponseBody Object pay(@RequestParam("payModel")String payModel,
									@RequestParam("password")String password,
									@RequestParam("products")String products,
									@RequestParam("sum")Float sum,
									HttpServletRequest req) {
		Order order=new Order();
		User user=(User)req.getSession().getAttribute("user");
		if(payModel.equals("账户余额")) {
			if(!user.getPassword().equals(password))
				return "passwordMiss";
			if(user.getBalance()<sum)
				return "noBalance";
			user.setBalance(user.getBalance()-sum);
			userService.update(user);
		}
		order.setPayModel(payModel);
		order.setUserId(user.getId());
		order.setPayTime(new Timestamp(System.currentTimeMillis()) );
		order.setPayMoney(sum);
		//擦入订单表,并返回擦入数据的id
		orderService.addOrder(order);
		JSONArray json=JSONArray.fromObject(products);
		List<Product> ps=(List<Product>)JSONArray.toCollection(json,Product.class);
		//将订单的内容插入orderItem表,同时删除购物车购买后的商品
		List<Product> list=(List<Product>)req.getSession().getAttribute("cart");
		a:
		for(int i=0;i<ps.size();i++) {
			ps.get(i).setOrderId(order.getId());
			orderService.addOrderItem(ps.get(i));
			for(int j=0;j<list.size();j++) {
				if(ps.get(i).getId()==list.get(j).getId() &&
					ps.get(i).getTasteName().equals(list.get(j).getTasteName())&&
					ps.get(i).getBuyNum()==list.get(j).getBuyNum()) {
					list.remove(j);
					continue a;
				}
			}
		}
		req.getSession().setAttribute("cart",list);
		return "success";
	}

	
}
