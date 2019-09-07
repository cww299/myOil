package service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.OrderMapper;
import pojo.Order;
import pojo.Product;
import service.OrderService;

@Service
public class OrderServiceImpl implements OrderService{

	@Autowired
	OrderMapper orderMapper;
	
	@Override
	public int addOrder(Order order) {
		return orderMapper.addOrder(order);
	}

	@Override
	public int deleteOrder(int id) {
		return orderMapper.deleteOrder(id);
	}

	@Override
	public int updateOrder(Order order) {
		return orderMapper.updateOrder(order);
	}

	@Override
	public List<Order> getOrderList(Order order) {
		return orderMapper.getOrderList(order);
	}

	@Override
	public int addOrderItem(Product product) {
		return orderMapper.addOrderItem(product);
	}

	@Override
	public int getOrderListResult(Order order) {
		return orderMapper.getOrderListResult(order);
	}

	@Override
	public List<Order> getOrderContent(Order order) {
		return orderMapper.getOrderContent(order);
	}

}
