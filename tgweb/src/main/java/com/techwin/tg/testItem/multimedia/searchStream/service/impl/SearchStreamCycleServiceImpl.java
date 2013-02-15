package com.techwin.tg.testItem.multimedia.searchStream.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.multimedia.searchStream.service.SearchStreamCycleService;

@Service("searchStreamCycleService")
public class SearchStreamCycleServiceImpl implements SearchStreamCycleService {
	
	@Inject
	@Named("searchStreamCycleDao")
	private SearchStreamCycleDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getSearchStreamCycleList(parameters);
	}
	
	public List<Map<String, Object>> getSearchStreamCycleExcel(Map<String, Object> parameters) throws Exception {
		return dao.getSearchStreamCycleExcel(parameters);
	}
}
