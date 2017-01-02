package oksusu.common.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("boardDAO")
public class BoardDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception{
        return (List<Map<String, Object>>)selectList("board.selectBoardList", map);
    }
	
	public void insertBoard(Map<String, Object> map) throws Exception{
	    insert("board.insertBoard", map);
	}
	
	public void updateHitCnt(Map<String, Object> map) throws Exception{
	    update("board.updateHitCnt", map);
	}
	 
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>) selectOne("board.selectBoardDetail", map);
	}
	
	public void updateBoard(Map<String, Object> map) throws Exception{
	    update("board.updateBoard", map);
	}
	
	public void deleteBoard(Map<String, Object> map) throws Exception{
	    update("board.deleteBoard", map);
	}
	
	public void insertFile(Map<String, Object> map) throws Exception{
	    insert("board.insertFile", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFileList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("board.selectFileList", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>)selectOne("board.selectFileInfo", map);
	}
}