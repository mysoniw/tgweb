package com.techwin.tg.main.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface MainResultService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getMainResultExcel(Map<String, Object> parameters) throws Exception;
}
