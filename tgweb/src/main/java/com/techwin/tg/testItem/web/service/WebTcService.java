package com.techwin.tg.testItem.web.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface WebTcService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getWebTcExcel(Map<String, Object> parameters) throws Exception;
}
