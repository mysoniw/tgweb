package com.techwin.tg.testItem.web.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.web.service.WebCycleService;

@Service("webCycleService")
public class WebCycleServiceImpl implements WebCycleService {
	
	@Inject
	@Named("webCycleDao")
	private WebCycleDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getWebCycleList(parameters);
	}
	
	public List<Map<String, Object>> getWebCycleExcel(Map<String, Object> parameters) throws Exception {
		return dao.getWebCycleExcel(parameters);
	}
}
