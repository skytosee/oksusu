package oksusu.common.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController {
    Logger log = Logger.getLogger(this.getClass());
   
    @RequestMapping(value="/main.do")
    public String openMain() throws Exception{
        return "main";
    }
    
    @RequestMapping(value="/about.do")
    public String openAbout() throws Exception{
        return "about";
    }
    
    @RequestMapping(value="admin/item.do")
    public String openAdminItem() throws Exception{
        return "admin/item";
    }
    
    @RequestMapping(value="admin/order.do")
    public String openAdminOrder() throws Exception{
        return "admin/order";
    }
}
