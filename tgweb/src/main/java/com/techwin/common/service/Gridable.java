package com.techwin.common.service;

import java.util.List;
import java.util.Map;

public interface Gridable {
	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
}
