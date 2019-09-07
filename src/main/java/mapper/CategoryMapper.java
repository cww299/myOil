package mapper;

import java.util.List;

import pojo.Category;

public interface CategoryMapper {
	public List<Category> getList();
	
	public int addCategory(String name);
	
	public int deleteCategory(int id);
	
	public int updateCategory(Category category);
}
