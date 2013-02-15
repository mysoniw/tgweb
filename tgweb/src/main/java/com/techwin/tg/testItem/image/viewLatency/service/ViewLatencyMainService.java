package com.techwin.tg.testItem.image.viewLatency.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface ViewLatencyMainService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getViewLatencyMainExcel(Map<String, Object> parameters) throws Exception;
}
