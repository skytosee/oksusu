package oksusu.common.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("orderDAO")
public class OrderDAO extends AbstractDAO{
	@SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectCartList(Map<String, Object> map) throws Exception{
        return (List<Map<String, Object>>)selectList("order.selectCartList", map);
    }
	
	public void saveCartList(HashMap<String, Object> map) {
		insert("order.saveCartList", map);
	}
	
	@SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectOrderList(Map<String, Object> map) throws Exception{
        return (List<Map<String, Object>>)selectList("order.selectOrderList", map);
    }
	
	public void saveOrderList(HashMap<String, Object> map) {
		insert("order.saveOrderList", map);
	}

	public void saveOrderFg(HashMap<String, Object> map) {
		update("order.saveOrderFg", map);	
	}

}
