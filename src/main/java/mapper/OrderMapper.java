package mapper;

import java.util.List;

import pojo.Order;
import pojo.Product;

public interface OrderMapper {
	public int addOrder(Order order);
	
	public int deleteOrder(int id);
	
	public int updateOrder(Order order);
	
	public List<Order> getOrderList(Order order);

	public int addOrderItem(Product product);

	public int getOrderListResult(Order order);
	
	public List<Order> getOrderContent(Order order);
}
