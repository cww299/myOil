package service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.ProductMapper;
import pojo.Product;
import pojo.Taste;
import service.ProductService;

@Service
public class PorductServiceImpl implements ProductService{
	@Autowired
	ProductMapper productMapper;

	@Override
	public List<Product> getList() {
		return productMapper.getList();
	}

	@Override
	public List<Taste> getTasteById(int pid) {
		return productMapper.getTasteById(pid);
	}

	@Override
	public List<Product> getProductList(Product product) {
		return productMapper.getProductList(product);
	}

	@Override
	public int getResultNums(Product product) {
		return productMapper.getResultNums(product);
	}

	@Override
	public int addProduct(Product product) {
		return productMapper.addProduct(product);
	}

	@Override
	public int deleteProduct(int id) {
		return productMapper.deleteProduct(id);
	}

	@Override
	public int updateProduct(Product product) {
		return productMapper.updateProduct(product);
	}

	@Override
	public int addOrderItem(Product product) {
		return productMapper.addOrderItem(product);
	}
	
	
}
