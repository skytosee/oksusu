package oksusu.common.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.impl.Log4JLogger;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import oksusu.common.model.LoginModel;
import oksusu.common.service.LoginService;
import oksusu.common.service.OrderService;

@Controller
public class OrderController {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name="orderService")
	private OrderService orderService;
	
	@Resource(name="loginService")
	private LoginService loginService;
	 
	 
    @RequestMapping(value="/order/cart.do")
    public ModelAndView openCarts(HttpSession session, HttpServletRequest request) throws Exception{ 
    	ModelAndView mv = new ModelAndView();
    	if (session.getAttribute("userLoginInfo") == null) {
    		mv.setViewName("redirect:/login.do");
    	}
    	else {
    		mv.setViewName("order/cart");
    		LoginModel user = (LoginModel)session.getAttribute("userLoginInfo");
	    	HashMap<String, Object> map = new HashMap<String, Object>();
	  		map.put("ID", user.getUserId());
	  		
			try {   
				List<Map<String,Object>> list = orderService.selectCartList(map);
		        mv.addObject("list", list);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
    	}
    	return mv;
    }
    
    @RequestMapping(value= "/order/cartSave.do", method=RequestMethod.POST)
    public void ajaxCartSave(HttpServletRequest request, 
    		                         HttpSession session,
    		                         HttpServletResponse response) throws Exception  {   
    	ObjectMapper mapper = new ObjectMapper();
    	response.setCharacterEncoding("UTF-8");
    	HashMap<String, Object> mapResponse = new HashMap<String, Object> ();	
    	if (session.getAttribute("userLoginInfo") == null) {
    		mapResponse.put("redirect", "/login.do");
    	}
    	else {
    		LoginModel user = (LoginModel)session.getAttribute("userLoginInfo");
	    	HashMap<String, Object> map = new HashMap<String, Object> ();	
	    	map.put("DML_FG", request.getParameter("dml_fg"));	
	    	map.put("ID", user.getUserId());
	    	
	    	if (map.get("DML_FG").toString().equals("D"))
	    	{
	    		String items = request.getParameter("id").toString();
	    		String[] array = items.split("[|]");
	    		for (int i = 0; i < array.length; i++) { 		
		    		map.put("ITEM_CD", array[i]); 
			        try {
				    	orderService.saveCartList(map); 
				    	mapResponse.put("redirect", "/order/cart.do");    
			        } catch (Exception e) {
			            e.printStackTrace();
			        } 
	    		}
	    	}
	    	else
	    	{
		    	map.put("ITEM_CD", request.getParameter("id")); 
		    	map.put("ITEM_QT", request.getParameter("qt")); 
		        try {
			    	orderService.saveCartList(map); 
			    	mapResponse.put("redirect", "/order/cart.do");    
		        } catch (Exception e) {
		            e.printStackTrace();
		        } 
	    	}
    	}
        response.getWriter().print(mapper.writeValueAsString(mapResponse));     
    }
    
    @RequestMapping(value= "/order/orderSave.do", method=RequestMethod.POST)
    public void ajaxOrderSave(HttpServletRequest request, 
    		                         HttpSession session,
    		                         HttpServletResponse response) throws Exception  {   
    	ObjectMapper mapper = new ObjectMapper();
    	response.setCharacterEncoding("UTF-8");
    	HashMap<String, Object> mapResponse = new HashMap<String, Object> ();	
    	if (session.getAttribute("userLoginInfo") == null) {
    		mapResponse.put("redirect", "/login.do");
    	}
    	else {
    		LoginModel user = (LoginModel)session.getAttribute("userLoginInfo");
	    	HashMap<String, Object> map = new HashMap<String, Object> ();	
	    	map.put("DML_FG", request.getParameter("dml_fg"));	
	    	map.put("ID", user.getUserId());
	    	map.put("ORDER_NB", request.getParameter("ORDER_NB")); 
		    map.put("ITEM_CD", request.getParameter("ITEM_CD")); 
		    map.put("ITEM_NM", request.getParameter("ITEM_NM")); 
		    map.put("ITEM_QT", request.getParameter("ITEM_QT")); 
		    map.put("ITEM_AM", request.getParameter("ITEM_AM")); 
		    map.put("NAME", request.getParameter("NAME"));
		    map.put("ZIP", request.getParameter("ZIP"));
		    map.put("PHONE", request.getParameter("PHONE")); 
		    map.put("ADDR", request.getParameter("ADDR"));
		    map.put("ORDER_FG", request.getParameter("ORDER_FG")); 
		    
	        try {
		    	orderService.saveOrderList(map);    
	        } catch (Exception e) {
	            e.printStackTrace();
	        } 
    	}
        response.getWriter().print(mapper.writeValueAsString(mapResponse));     
    }
    
    @RequestMapping(value= "/order/list.do", method=RequestMethod.POST)
    public ModelAndView orderList(HttpServletRequest request, 
    		                      HttpSession session,
    		                      HttpServletResponse response) throws Exception  {   
    	ModelAndView mv = new ModelAndView("order/list");

    	if (session.getAttribute("userLoginInfo") == null) {
    		mv.setViewName("redirect:/login.do");
    	}
    	else {
    		ObjectMapper mapper = new ObjectMapper();
    		List<Map<String,Object>> list =  mapper.readValue(request.getParameter("list"), new TypeReference<List<Map<String,Object>>>(){});
    		mv.addObject("list", list); 
    		mv.addObject("user", (LoginModel)session.getAttribute("userLoginInfo"));
    	}
    	
    	return mv;
    }
    
    // 체크아웃 처리
    @RequestMapping(value="/order/checkout.do" )
    public ModelAndView openCheckOut(@RequestParam("id") String id, HttpSession session) throws Exception {   
    	if (session.getAttribute("userLoginInfo") == null) {
    		HashMap<String, Object> map = new HashMap<String, Object> ();
    		map.put("LOGIN_ID", id);
    		map.put("LOGIN_PW", "1234");
    		map.put("RESULT", "");
    		
    		Map<String,Object> mapResult = loginService.loginUser(map);	
    		
    		if (mapResult.get("RESULT").toString().equals("OK")) {
    			
    			LoginModel model = new LoginModel();
    			model.setUserId((String) mapResult.get("ID"));
				model.setUserName((String) mapResult.get("NAME"));
				model.setEmail((String) mapResult.get("EMAIL"));	
				model.setPhone((String) mapResult.get("PHONE"));
				model.setZip((String) mapResult.get("ZIP"));
				model.setAddess((String) mapResult.get("ADDR"));
				model.setCartCount((String)mapResult.get("CARTCOUNT"));
		        session.setAttribute("userLoginInfo", model);
		        if ( mapResult.get("ADMIN").toString().equals("1"))
		        	session.setAttribute("admin", "ok");
    		}
    	}
    	ModelAndView mv = new ModelAndView("order/checkout");  
        return mv;
    }
    
    // 체크아웃 처리
    @RequestMapping(value="/order/notify.do" )
    public ModelAndView openNotify(HttpServletRequest request) throws Exception {     	
    	ModelAndView mv = new ModelAndView("order/notify");  
        return mv;
    }
    
    // 체크아웃 처리
    @RequestMapping(value="/order/cancel.do" )
    public ModelAndView openCancel(HttpServletRequest request) throws Exception {     	
    	ModelAndView mv = new ModelAndView("order/cancel");  
        return mv;
    }
    
    // 주문상태
    @RequestMapping(value="/order/order.do" )
    public ModelAndView openOrder(HttpServletRequest request,
    		                      HttpSession session) throws Exception {     	
    	ModelAndView mv = new ModelAndView("order/order");  
    	HashMap<String, Object> map = new HashMap<String, Object> ();
    	
    	if (session.getAttribute("userLoginInfo") == null) {
    		mv.setViewName("redirect:/login.do");
    	}
    	else {
    		LoginModel user = (LoginModel)session.getAttribute("userLoginInfo");
    		map.put("ID", user.getUserId());
    		
    		List<Map<String,Object>> list = orderService.selectOrderList(map); 
    		mv.addObject("list", list); 
    	}

        return mv;
    }
    
    // 주문조회
    @RequestMapping(value= "/order/orderList.do")
    public void OrderList(HttpServletRequest request, 
    		              HttpSession session,
    		              HttpServletResponse response) throws Exception  {  
    	HashMap<String, Object> map = new HashMap<String, Object> ();	
    	if (session != null && session.getAttribute("userLoginInfo") != null)
    	{
    		LoginModel user = (LoginModel)session.getAttribute("userLoginInfo");
    		map.put("ID", user.getUserId());
    	}
    	else
    		map.put("ID", "");
    		
    	map.put("ORDER_NB", "");
        try {
        	List<Map<String,Object>> list = orderService.selectOrderList(map); 
        	Object[] tasks = {};
        	for (Map<String,Object> el : list) {	
        		el.put("tasks", tasks);
        	}
        	ObjectMapper mapper = new ObjectMapper();
	        response.setCharacterEncoding("UTF-8");
        	response.getWriter().print(mapper.writeValueAsString(list));    
        } catch (Exception e) {
            e.printStackTrace();
        }      
    }
    
    // 주문상태수정
    @RequestMapping(value= "/order/fg/{id}.do")
    @ResponseStatus(value = HttpStatus.OK)
    public void OrderFgUpdate(@PathVariable("id") String id,
    		                  @RequestBody String body) throws Exception  {  
    	HashMap<String, Object> map = new HashMap<String, Object> ();	
        
        ObjectMapper mapper = new ObjectMapper();
    	map = mapper.readValue(body, new TypeReference<Map<String, Object>>(){});
    	map.put("ORDER_NB", "SO" + id.toString());
        map.put("ORDER_FG", map.get("status").toString().equals("done") ? "3" :
        	                map.get("status").toString().equals("in-progress") ? "2" :
        	                map.get("status").toString().equals("ok") ? "1" : "0");
        try {
        	orderService.saveOrderFg(map); 
        } catch (Exception e) {
            e.printStackTrace();
        }      
    }
    
    // 주문수정
    @RequestMapping(value= "/order/orders/{id}.do")
    @ResponseStatus(value = HttpStatus.OK)
    public void OrderUpdate(@PathVariable("id") String id,
    		                @RequestBody String body) throws Exception  {  
    	HashMap<String, Object> map = new HashMap<String, Object> ();	
        
        ObjectMapper mapper = new ObjectMapper();
        body.replaceAll("\\[\\]", "");
    	map = mapper.readValue(body, new TypeReference<Map<String, Object>>(){});
    	map.put("DML_FG", "U");
    	map.put("ID", "");
    	map.put("ORDER_NB", "SO" + id.toString());
    	map.put("ITEM_CD", "");
    	map.put("ITEM_NM", map.get("description"));
    	map.put("ITEM_QT", 0);
    	map.put("ITEM_AM", 0);
    	map.put("NAME", "");
    	map.put("PHONE", "");
    	map.put("ZIP", "");
    	map.put("ADDR", "");
        map.put("ORDER_FG", map.get("status").toString().equals("done") ? "3" :
        	                map.get("status").toString().equals("in-progress") ? "2" :
        	                map.get("status").toString().equals("ok") ? "1" : "0");
        try {
        	orderService.saveOrderList(map); 
        } catch (Exception e) {
            e.printStackTrace();
        }      
    }
    
}
