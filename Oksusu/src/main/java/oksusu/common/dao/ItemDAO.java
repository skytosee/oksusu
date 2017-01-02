package oksusu.common.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("itemDAO")
public class ItemDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectItemList(Map<String, Object> map) throws Exception{
        return (List<Map<String, Object>>)selectList("item.selectItemList", map);
    }

	public void saveItemList(HashMap<String, Object> map) {
		insert("item.saveItemList", map);
	}
}
