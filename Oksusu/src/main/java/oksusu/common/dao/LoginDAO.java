package oksusu.common.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import oksusu.common.model.LoginModel;

@Repository("loginDAO")
public class LoginDAO extends AbstractDAO{
	public void insertUser(LoginModel model) throws Exception{
	    insert("login.insertUser", model);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> loginUser(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>) selectOne("login.loginUser", map);
	}
}
