package com.techwin.tg.testItem.DST.service;

import java.util.List;
import java.util.Map;

public interface DSTDetailService {

	public Map<String, Object> getDSTDetailTab(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getDSTDetailExcel(Map<String, Object> parameters) throws Exception;
}
