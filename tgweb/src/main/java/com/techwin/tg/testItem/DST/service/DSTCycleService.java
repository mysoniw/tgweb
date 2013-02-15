package com.techwin.tg.testItem.DST.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface DSTCycleService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getDSTCycleExcel(Map<String, Object> parameters) throws Exception;
}
