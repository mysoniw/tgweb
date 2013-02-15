package com.techwin.tg.main.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface MainFwService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getMainFwExcel(Map<String, Object> parameters) throws Exception;
	
	public Map<String, List<Map<String, Object>>> getMainFwExcelReport(Map<String, Object> parameters) throws Exception;
}
