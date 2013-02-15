package com.techwin.tg.testItem.image.viewLatency.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.image.viewLatency.service.ViewLatencyMainService;

@Service("viewLatencyMainService")
public class ViewLatencyMainServiceImpl implements ViewLatencyMainService {

	@Inject
	private ViewLatencyMainDao viewLatencyMainDao;
	
	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return viewLatencyMainDao.getViewLatencyMainList(parameters);
	}
	
	public List<Map<String, Object>> getViewLatencyMainExcel(Map<String, Object> parameters) throws Exception {
		return viewLatencyMainDao.getViewLatencyMainExcel(parameters);
	}
}
