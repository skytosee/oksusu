package oksusu.common.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import oksusu.common.common.CommandMap;
import oksusu.common.model.LoginModel;
import oksusu.common.service.LoginService;

@Controller
public class LoginController {
	
	@Resource(name="loginService")
	private LoginService loginService;
	 
	// 로그인 페이지
    @RequestMapping(value="/login.do")
    public String openLogin(CommandMap commandMap) throws Exception{
        return "login";
    }
	  
	// 로그인 처리
    @RequestMapping(value="loginProcess.do", method = RequestMethod.POST)
    public ModelAndView loginProcess(LoginModel model, HttpSession session, HttpServletRequest request) throws Exception {     
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("login");
    	
    	session.setAttribute("userLoginInfo", null);
    	session.setAttribute("admin", null);
		
		HashMap<String, Object> map = new HashMap<String, Object> ();
		map.put("LOGIN_ID", model.getUserId());
		map.put("LOGIN_PW", model.getPassword());
		map.put("RESULT", "");
		
		Map<String,Object> mapResult = loginService.loginUser(map);	
			
		if (mapResult != null && mapResult.size() > 0 ) {	
			
			if (mapResult.get("RESULT").toString().equals("WRONG_ID") ||
		        mapResult.get("RESULT").toString().equals("WRONG_PW"))
			{
				mv.addObject("MSG", mapResult.get("RESULT").toString().equals("WRONG_ID") ? "&middot; 일치하는 아이디가 존재하지 않습니다." : "&middot; 비밀번호를 확인해 주십시오."); 		
			}
			else if (mapResult.get("RESULT").toString().equals("OK")) {
				model.setUserName((String) mapResult.get("NAME"));
				model.setEmail((String) mapResult.get("EMAIL"));	
				model.setPhone((String) mapResult.get("PHONE"));
				model.setZip((String) mapResult.get("ZIP"));
				model.setAddess((String) mapResult.get("ADDR"));
				model.setCartCount((String)mapResult.get("CARTCOUNT"));
		        session.setAttribute("userLoginInfo", model);
		        if ( mapResult.get("ADMIN").toString().equals("1"))
		        	session.setAttribute("admin", "ok");
		        
		        mv.setViewName("redirect:main.do");
			}
		}
		
        return mv;
    }
    
    // 로그아웃
    @RequestMapping("logout.do")
    public String logout(HttpSession session) {
        session.setAttribute("userLoginInfo", null);
        return "redirect:login.do";
    }
    
    // 회원가입 페이지
    @RequestMapping(value="account.do")
    public String openAccount(CommandMap commandMap) throws Exception{
        return "account";
    }
    
    // 회원가입 처리
    @RequestMapping(value="accountProcess.do", method = RequestMethod.POST)
    public ModelAndView accountProcess(LoginModel model, HttpSession session, HttpServletRequest request) throws Exception {     	
    	System.out.println("ID:"+ model.getUserId());
    	System.out.println("PASS:"+ model.getPassword());
    	ModelAndView mv = new ModelAndView("redirect:/login.do");
        
    	loginService.insertUser(model);
         
        return mv;
    }

}
