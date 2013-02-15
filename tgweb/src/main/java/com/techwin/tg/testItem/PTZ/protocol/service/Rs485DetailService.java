package com.techwin.tg.testItem.PTZ.protocol.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface Rs485DetailService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getRs485DetailExcel(Map<String, Object> parameters) throws Exception;
}
