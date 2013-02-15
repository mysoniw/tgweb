package com.techwin.tg.testItem.DST.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.DST.service.DSTMainService;

@Service("dstMainService")
public class DSTMainServiceImpl implements DSTMainService {
	
	@Inject
	@Named("dstMainDao")
	private DSTMainDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getDSTMainList(parameters);
	}
	
	public List<Map<String, Object>> getDSTMainExcel(Map<String, Object> parameters) throws Exception {
		return dao.getDSTMainExcel(parameters);
	}
}
