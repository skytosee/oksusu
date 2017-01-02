package oksusu.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import oksusu.common.dao.OrderDAO;

@Service("orderService")
public class OrderServiceImpl implements OrderService{
	Logger log = Logger.getLogger(this.getClass());
    
    @Resource(name="orderDAO")
    private OrderDAO orderDAO;

	@Override
	public List<Map<String, Object>> selectCartList(Map<String, Object> map) throws Exception {
		return orderDAO.selectCartList(map);
	}

	@Override
	public void saveCartList(HashMap<String, Object> map) {
		orderDAO.saveCartList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectOrderList(Map<String, Object> map) throws Exception {
		return orderDAO.selectOrderList(map);
	}
	
	@Override
	public void saveOrderList(HashMap<String, Object> map) {
		orderDAO.saveOrderList(map);
	}

	@Override
	public void saveOrderFg(HashMap<String, Object> map) {
		orderDAO.saveOrderFg(map);
	}
	
}
