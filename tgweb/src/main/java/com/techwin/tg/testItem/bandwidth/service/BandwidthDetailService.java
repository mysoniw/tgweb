package com.techwin.tg.testItem.bandwidth.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface BandwidthDetailService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getBandwidthDetailExcel(Map<String, Object> parameters) throws Exception;
}
