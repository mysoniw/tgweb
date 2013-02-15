package com.techwin.tg.testItem.multimedia.searchStream.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.multimedia.searchStream.service.SearchStreamMainService;

@Service("searchStreamMainService")
public class SearchStreamMainServiceImpl implements SearchStreamMainService {
	
	@Inject
	@Named("searchStreamMainDao")
	private SearchStreamMainDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getSearchStreamMainList(parameters);
	}
	
	public List<Map<String, Object>> getSearchStreamMainExcel(Map<String, Object> parameters) throws Exception {
		return dao.getSearchStreamMainExcel(parameters);
	}
}
