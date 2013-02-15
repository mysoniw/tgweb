package com.techwin.tg.testItem.web.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.web.service.WebDetailService;

@Service("webDetailService")
public class WebDetailServiceImpl implements WebDetailService {
	
	@Inject
	@Named("webDetailDao")
	private WebDetailDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getWebDetailList(parameters);
	}
	
	public List<Map<String, Object>> getWebDetailExcel(Map<String, Object> parameters) throws Exception {
		return dao.getWebDetailExcel(parameters);
	}
}
