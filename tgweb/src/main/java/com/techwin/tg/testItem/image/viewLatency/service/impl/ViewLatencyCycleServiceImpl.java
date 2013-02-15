package com.techwin.tg.testItem.image.viewLatency.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.image.viewLatency.service.ViewLatencyCycleService;

@Service("viewLatencyCycleService")
public class ViewLatencyCycleServiceImpl implements ViewLatencyCycleService {

	@Inject
	private ViewLatencyCycleDao viewLatencyCycledao;
	
	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return viewLatencyCycledao.getViewLatencyCycleList(parameters);
	}
	
	public List<Map<String, Object>> getViewLatencyCycleExcel(Map<String, Object> parameters) throws Exception {
		return viewLatencyCycledao.getViewLatencyCycleExcel(parameters);
	}
}
