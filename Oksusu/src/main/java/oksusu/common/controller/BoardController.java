package oksusu.common.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import oksusu.common.common.CommandMap;
import oksusu.common.service.BoardService;

@Controller
public class BoardController {
    Logger log = Logger.getLogger(this.getClass());
    
    @Resource(name="boardService")
    private BoardService boardService;
    
    @RequestMapping(value="/board/openBoardList.do")
    public ModelAndView openSampleBoardList(Map<String,Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("board/boardList");
         
        List<Map<String,Object>> list = boardService.selectBoardList(commandMap);
        mv.addObject("list", list);
         
        return mv;
    }
    
    @RequestMapping(value="/board/openBoardWrite.do")
    public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("board/boardWrite");
         
        return mv;
    }
    
    @RequestMapping(value="/board/insertBoard.do")
    public ModelAndView insertBoard(CommandMap commandMap, HttpServletRequest request) throws Exception{
        ModelAndView mv = new ModelAndView("redirect:/board/openBoardList.do");
       
        boardService.insertBoard(commandMap.getMap(), request);
         
        return mv;
    }
    
    @RequestMapping(value="/board/openBoardDetail.do")
    public ModelAndView openBoardDetail(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("board/boardDetail");
    	
    	Map<String,Object> map = boardService.selectBoardDetail(commandMap.getMap());
    	mv.addObject("map", map.get("map"));
    	mv.addObject("list", map.get("list"));
    
    	return mv;
    }
    
    @RequestMapping(value="/board/openBoardUpdate.do")
    public ModelAndView openBoardUpdate(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("board/boardUpdate");
         
        Map<String,Object> map = boardService.selectBoardDetail(commandMap.getMap());
        mv.addObject("map", map.get("map"));
    	mv.addObject("list", map.get("list"));
         
        return mv;
    }
     
    @RequestMapping(value="/board/updateBoard.do")
    public ModelAndView updateBoard(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("redirect:/board/openBoardDetail.do");
         
        boardService.updateBoard(commandMap.getMap());
         
        mv.addObject("IDX", commandMap.get("IDX"));
        return mv;
    }
    
    @RequestMapping(value="/board/deleteBoard.do")
    public ModelAndView deleteBoard(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("redirect:/board/openBoardList.do");
         
        boardService.deleteBoard(commandMap.getMap());
         
        return mv;
    }
    
    @RequestMapping(value="/board/downloadFile.do")
    public void downloadFile(CommandMap commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception{
        Map<String,Object> map = boardService.selectFileInfo(commandMap.getMap());
        String storedFileName = (String)map.get("STORED_FILE_NAME");
        String originalFileName = (String)map.get("ORIGINAL_FILE_NAME");
         
        String filePath = request.getSession().getServletContext().getRealPath("/files");
        
        byte fileByte[] = FileUtils.readFileToByteArray(new File(filePath + File.separator +storedFileName));
         
        response.setContentType("application/octet-stream");
        response.setContentLength(fileByte.length);
        response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8")+"\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.getOutputStream().write(fileByte);
         
        response.getOutputStream().flush();
        response.getOutputStream().close();
    }
}
