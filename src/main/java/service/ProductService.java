package service;

import java.util.List;

import pojo.Product;
import pojo.Taste;

public interface ProductService {
	public List<Product> getList();
	
	
	public List<Taste> getTasteById(int pid);
	
	public List<Product> getProductList(Product product);
	
	public int getResultNums(Product product);
	
	public int addProduct(Product product);
	
	public int deleteProduct(int id);
	
	public int updateProduct(Product product);
	
	public int addOrderItem(Product product);
}
