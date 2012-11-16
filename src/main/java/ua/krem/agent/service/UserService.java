package ua.krem.agent.service;

import java.util.LinkedList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ua.krem.agent.dao.UserDAO;
import ua.krem.agent.model.User;
@Service
public class UserService {

	private final UserDAO userDao;
	
	@Inject
	public UserService(UserDAO userDao){
		this.userDao = userDao;
	}
	
	public List<String> getSmth(int val){
		List<String> list = new LinkedList<String>();
		for(int i = 0; i < val; ++i){
			list.add("arg #" + i);  
		}
		list.add(userDao.getUser("admin").getPass());
		
		return list;
	}
	
	public User getUser(String name){
		return userDao.getUser(name);
	}
}
