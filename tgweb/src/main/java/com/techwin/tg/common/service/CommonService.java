package com.techwin.tg.common.service;

import java.util.List;
import java.util.Map;

public interface CommonService {

	public List<Map<String, Object>> getSelect(Map<String, Object> parameters) throws Exception;
	public List<Map<String, Object>> getTestSuiteSelect(Map<String, Object> parameters) throws Exception;
	public List<Map<String, Object>> getGroupSelect(Map<String, Object> parameters) throws Exception;
}
