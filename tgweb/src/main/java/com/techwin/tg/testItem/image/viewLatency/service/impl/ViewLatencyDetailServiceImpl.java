package com.techwin.tg.testItem.image.viewLatency.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.image.viewLatency.service.ViewLatencyDetailService;

@Service("viewLatencyDetailService")
public class ViewLatencyDetailServiceImpl implements ViewLatencyDetailService {

	@Inject
	private ViewLatencyDetailDao viewLatencyDetailDao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return viewLatencyDetailDao.getViewLatencyDetailList(parameters);
	}
	
	public List<Map<String, Object>> getViewLatencyDetailExcel(Map<String, Object> parameters) throws Exception {
		return viewLatencyDetailDao.getViewLatencyDetailExcel(parameters);
	}
}
