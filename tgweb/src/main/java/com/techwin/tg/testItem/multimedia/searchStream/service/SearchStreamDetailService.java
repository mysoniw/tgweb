package com.techwin.tg.testItem.multimedia.searchStream.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface SearchStreamDetailService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getSearchStreamDetailExcel(Map<String, Object> parameters) throws Exception;

	public List<Map<String, Object>> getSearchStreamDetailImage(Map<String, Object> parameterMap) throws Exception;
}
