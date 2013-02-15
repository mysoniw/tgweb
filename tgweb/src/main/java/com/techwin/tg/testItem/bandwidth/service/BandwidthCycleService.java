package com.techwin.tg.testItem.bandwidth.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface BandwidthCycleService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getBandwidthCycleExcel(Map<String, Object> parameters) throws Exception;
}
