package com.techwin.tg.testItem.OSD.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface OSDDetailService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getOSDDetailExcel(Map<String, Object> parameters) throws Exception;
}
