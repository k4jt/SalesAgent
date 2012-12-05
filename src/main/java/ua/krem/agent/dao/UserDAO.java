package ua.krem.agent.dao;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import ua.krem.agent.model.User;

@Repository
public class UserDAO {
	private final JdbcTemplate jdbcTemplate;
	
	@Inject
	public UserDAO(JdbcTemplate jdbcTemplate){
		this.jdbcTemplate = jdbcTemplate;
	}

	public User getUser(String name){
		String sql = "select * from sa_user where login = ?";
		User user = new User();
		try{
			Map<String, Object> map = jdbcTemplate.queryForMap(sql, name);
			if(map != null){
				user.setId((Integer)map.get("id"));
				user.setLogin((String)map.get("login"));
				user.setPass((String)map.get("pass"));
			}
		}catch(EmptyResultDataAccessException e){
			e.printStackTrace();
		}
		
		
		return user;
	}
	
}
