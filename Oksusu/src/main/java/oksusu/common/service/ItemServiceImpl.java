package oksusu.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import oksusu.common.dao.ItemDAO;
import oksusu.common.util.FileUtils;

@Service("itemService")
public class ItemServiceImpl implements ItemService{
	Logger log = Logger.getLogger(this.getClass());
     
	@Resource(name="fileUtils")
    private FileUtils fileUtils;
	
    @Resource(name="itemDAO")
    private ItemDAO itemDAO;

	@Override
	public List<Map<String, Object>> selectItemList(Map<String, Object> map) throws Exception {
		return itemDAO.selectItemList(map);
	}

	@Override
	public void saveItemList(HashMap<String, Object> map) {
		itemDAO.saveItemList(map);	
	}

	
}