package com.techwin.tg.testItem.OSD.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface OSDMainService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getOSDMainExcel(Map<String, Object> parameters) throws Exception;
}
