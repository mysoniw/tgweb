package com.techwin.tg.testItem.DST.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.DST.service.DSTCycleService;

@Service("dstCycleService")
public class DSTCycleServiceImpl implements DSTCycleService {
	
	@Inject
	@Named("dstCycleDao")
	private DSTCycleDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getDSTCycleList(parameters);
	}
	
	public List<Map<String, Object>> getDSTCycleExcel(Map<String, Object> parameters) throws Exception {
		return dao.getDSTCycleExcel(parameters);
	}
}
