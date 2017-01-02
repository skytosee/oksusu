package oksusu.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface OrderService {
    List<Map<String, Object>> selectCartList(Map<String, Object> map) throws Exception;    
    void saveCartList(HashMap<String, Object> map);
    List<Map<String, Object>> selectOrderList(Map<String, Object> map) throws Exception;    
    void saveOrderList(HashMap<String, Object> map);
	void saveOrderFg(HashMap<String, Object> map);
}
