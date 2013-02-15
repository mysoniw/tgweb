package com.techwin.tg.testItem.web.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.web.service.WebMainService;

@Service("webMainService")
public class WebMainServiceImpl implements WebMainService {
	
	@Inject
	@Named("webMainDao")
	private WebMainDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getWebMainList(parameters);
	}
	
	public List<Map<String, Object>> getWebMainExcel(Map<String, Object> parameters) throws Exception {
		return dao.getWebMainExcel(parameters);
	}
}
