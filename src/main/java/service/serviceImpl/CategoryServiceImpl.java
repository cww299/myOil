package service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.CategoryMapper;
import pojo.Category;
import service.CategoryService;

@Service										  
public class CategoryServiceImpl implements CategoryService{

	@Autowired
	CategoryMapper categoryMapper;
	
	@Override
	public List<Category> getList() {
		return categoryMapper.getList();
	}

	@Override
	public int addCategory(String name) {
		return categoryMapper.addCategory(name);
	}

	@Override
	public int deleteCategory(int id) {
		return categoryMapper.deleteCategory(id);
	}

	@Override
	public int updateCategory(Category category) {
		return categoryMapper.updateCategory(category);
	}

}
