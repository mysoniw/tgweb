package com.techwin.tg.testItem.image.viewLatency.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface ViewLatencyTcService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getViewLatencyTcExcel(Map<String, Object> parameters) throws Exception;
}
