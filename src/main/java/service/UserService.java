package service;

import java.util.List;

import pojo.User;

public interface UserService {
	public int add(User user);
	public int delete(int id);
	public int update(User user);
	public int selectAll(User user);
	public List<User> getUsers(User user);
	public User selectByUsername(String username);
	public User login(User u);
}
