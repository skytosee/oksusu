package oksusu.common.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import oksusu.common.dao.LoginDAO;
import oksusu.common.model.LoginModel;

@Service("loginService")
public class LoginServiceImpl implements LoginService{
	Logger log = Logger.getLogger(this.getClass());
    
    @Resource(name="loginDAO")
    private LoginDAO loginDAO;
    
    @Override
	 public void insertUser(LoginModel model) throws Exception {
    	loginDAO.insertUser(model);
    }  	

	@Override
	public Map<String, Object> loginUser(Map<String, Object> map) throws Exception {
		 Map<String, Object> resultMap = loginDAO.loginUser(map);
		 return resultMap;
	}
}
