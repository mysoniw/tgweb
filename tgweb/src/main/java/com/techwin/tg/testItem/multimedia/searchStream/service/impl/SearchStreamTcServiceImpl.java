package com.techwin.tg.testItem.multimedia.searchStream.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.multimedia.searchStream.service.SearchStreamTcService;

@Service("searchStreamTcService")
public class SearchStreamTcServiceImpl implements SearchStreamTcService {
	
	@Inject
	@Named("searchStreamTcDao")
	private SearchStreamTcDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getSearchStreamTcList(parameters);
	}
	
	public List<Map<String, Object>> getSearchStreamTcExcel(Map<String, Object> parameters) throws Exception {
		return dao.getSearchStreamTcExcel(parameters);
	}
}
