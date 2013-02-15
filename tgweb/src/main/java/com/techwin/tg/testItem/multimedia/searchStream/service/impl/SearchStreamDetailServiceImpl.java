package com.techwin.tg.testItem.multimedia.searchStream.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.multimedia.searchStream.service.SearchStreamDetailService;

@Service("searchStreamDetailService")
public class SearchStreamDetailServiceImpl implements SearchStreamDetailService {
	
	@Inject
	@Named("searchStreamDetailDao")
	private SearchStreamDetailDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getSearchStreamDetailList(parameters);
	}
	
	public List<Map<String, Object>> getSearchStreamDetailExcel(Map<String, Object> parameters) throws Exception {
		return dao.getSearchStreamDetailExcel(parameters);
	}

	@Override
	public List<Map<String, Object>> getSearchStreamDetailImage(Map<String, Object> parameters) throws Exception {
		return dao.getSearchStreamDetailImage(parameters);
	}
}
