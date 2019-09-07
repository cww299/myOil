package service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapper.UserMapper;
import pojo.User;
import service.UserService;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	UserMapper userMapper;

	@Override
	public int add(User user) {
		return userMapper.add(user);
	}

	@Override
	public int delete(int id) {
		return userMapper.delete(id);
	}

	@Override
	public int update(User user) {
		return userMapper.update(user);
	}

	@Override
	public int selectAll(User user) {
		return userMapper.selectAll(user);
	}

	@Override
	public List<User> getUsers(User user) {
		return userMapper.getUsers(user);
	}

	@Override
	public User selectByUsername(String username) {
		return userMapper.selectByUsername(username);
	}

	@Override
	public User login(User u) {
		return userMapper.login(u);
	}

	
}
