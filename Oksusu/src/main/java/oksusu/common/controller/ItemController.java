package oksusu.common.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import oksusu.common.service.ItemService;
import oksusu.common.util.FileUtils;

@Controller
public class ItemController {
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	 
	@Resource(name="itemService")
	private ItemService itemService;
	 
	// 품목 정보
    @RequestMapping(value="/items/{id}.do")
    public ModelAndView openItems(@PathVariable("id") String id, HttpServletRequest request) throws Exception{ 
    	ModelAndView mv = new ModelAndView("items/items");
    	HashMap<String, Object> map = new HashMap<String, Object>();
  		map.put("TYPE", id.toUpperCase());
  		map.put("VIEW_YN", "t");
  		
		try {   
			List<Map<String,Object>> list = itemService.selectItemList(map);
	        mv.addObject("list", list);
        } catch (IOException e) {
            e.printStackTrace();
        }
		 
        return mv;
    }
    
    @RequestMapping(value= "/items/itemSelect.do", method=RequestMethod.GET)
    public void ajaxItemSelect(@RequestParam("type") String type,
    		                   @RequestParam("view_yn") String view_yn, 
    		                   @RequestParam("item_cd") String item_cd,
    		                   HttpServletResponse response) throws Exception  {   	
    	HashMap<String, Object> map = new HashMap<String, Object> ();
    	
    	
		map.put("TYPE", type);
		map.put("VIEW_YN", view_yn);
		map.put("ITEM_CD", item_cd);
	
        try {
	    	List<Map<String,Object>> list = itemService.selectItemList(map);
	        ObjectMapper mapper = new ObjectMapper();
	        response.setCharacterEncoding("UTF-8");
            response.getWriter().print(mapper.writeValueAsString(list));     
        } catch (IOException e) {
            e.printStackTrace();
        }  
    }
    
    @RequestMapping(value= "/items/itemSave.do", method=RequestMethod.POST)
    public void ajaxItemSave(HttpServletRequest request, 
    		                 HttpServletResponse response) throws Exception  {   
    	
    	String jsonString = request.getParameter("row"); 
    	ObjectMapper mapper = new ObjectMapper();
    	HashMap<String, Object> map = new HashMap<String, Object> ();	
    	map = mapper.readValue(jsonString, new TypeReference<Map<String, String>>(){});
    	map.put("DML_FG", request.getParameter("dml_fg"));	
        try {
	    	itemService.saveItemList(map);
		    response.setCharacterEncoding("UTF-8");
	        response.getWriter().print(mapper.writeValueAsString(""));     
        } catch (Exception e) {
            e.printStackTrace();
        }  
    }
}
