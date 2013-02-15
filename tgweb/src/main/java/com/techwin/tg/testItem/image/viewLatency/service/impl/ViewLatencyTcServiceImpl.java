package com.techwin.tg.testItem.image.viewLatency.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.image.viewLatency.service.ViewLatencyTcService;

@Service("viewLatencyTcService")
public class ViewLatencyTcServiceImpl implements ViewLatencyTcService {

	@Inject
	private ViewLatencyTcDao viewLatencyTcDao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return viewLatencyTcDao.getViewLatencyTcList(parameters);
	}
	
	public List<Map<String, Object>> getViewLatencyTcExcel(Map<String, Object> parameters) throws Exception {
		return viewLatencyTcDao.getViewLatencyTcExcel(parameters);
	}
}
