package com.techwin.admin.common.service;

import java.util.List;
import java.util.Map;

public interface CommonService {

	public List<Map<String, Object>> getSelect(Map<String, Object> parameters) throws Exception;
}
