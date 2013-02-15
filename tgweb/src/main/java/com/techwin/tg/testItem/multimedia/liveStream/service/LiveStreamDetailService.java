package com.techwin.tg.testItem.multimedia.liveStream.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface LiveStreamDetailService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getLiveStreamDetailExcel(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getLiveStreamDetailImage(Map<String, Object> parameterMap) throws Exception;
}
