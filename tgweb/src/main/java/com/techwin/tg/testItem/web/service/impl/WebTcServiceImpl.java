package com.techwin.tg.testItem.web.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.web.service.WebTcService;

@Service("webTcService")
public class WebTcServiceImpl implements WebTcService {
	
	@Inject
	@Named("webTcDao")
	private WebTcDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getWebTcList(parameters);
	}
	
	public List<Map<String, Object>> getWebTcExcel(Map<String, Object> parameters) throws Exception {
		return dao.getWebTcExcel(parameters);
	}
}
