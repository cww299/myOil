package service;

import java.util.List;

import pojo.Category;

public interface CategoryService {
	List<Category> getList();
	
	public int addCategory(String name);
	
	public int deleteCategory(int id);
	
	public int updateCategory(Category category);
}
