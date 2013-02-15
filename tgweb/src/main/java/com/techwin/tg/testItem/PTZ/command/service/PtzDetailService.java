package com.techwin.tg.testItem.PTZ.command.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface PtzDetailService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getPtzDetailExcel(Map<String, Object> parameters) throws Exception;
}
