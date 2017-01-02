package oksusu.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ItemService {

	// 품목
	List<Map<String, Object>> selectItemList(Map<String, Object> map) throws Exception;
    
	void saveItemList(HashMap<String, Object> map);
}
