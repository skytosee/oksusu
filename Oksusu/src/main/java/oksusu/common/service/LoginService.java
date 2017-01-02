package oksusu.common.service;

import java.util.Map;

import oksusu.common.model.LoginModel;

public interface LoginService {
	
	// 로그
	void insertUser(LoginModel model) throws Exception;
	
	// 로그인 처리
    Map<String, Object> loginUser(Map<String, Object> map) throws Exception;
}
