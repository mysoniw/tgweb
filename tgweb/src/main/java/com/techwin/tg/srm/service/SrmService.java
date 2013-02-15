package com.techwin.tg.srm.service;

import java.util.List;
import java.util.Map;

import com.techwin.tg.srm.dto.SrmDto;

public interface SrmService {

	public List<SrmDto> getTestData();

	public Map<String, Object> getSrmExistResult(Map<String, Object> parameters) throws Exception;

	public List<Map<String, Object>> getSrmCPUData(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getSrmProcessData(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getSrmMemoryData(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getSrmNetworkData(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getSrmDiskUsageData(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getSrmDiskIOData(Map<String, Object> parameters) throws Exception;

	public List<Map<String, Object>> getSrmContextSwitchingData(Map<String, Object> parameters) throws Exception;
}
