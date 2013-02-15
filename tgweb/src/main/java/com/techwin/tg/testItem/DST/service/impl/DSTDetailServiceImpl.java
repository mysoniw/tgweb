package com.techwin.tg.testItem.DST.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.DST.service.DSTDetailService;

@Service("dstDetailService")
public class DSTDetailServiceImpl implements DSTDetailService {
	
	@Inject
	@Named("dstDetailDao")
	private DSTDetailDao dao;

	public Map<String, Object> getDSTDetailTab(Map<String, Object> parameters) throws Exception {
		return dao.getDSTDetailList(parameters);
	}
	
	public List<Map<String, Object>> getDSTDetailExcel(Map<String, Object> parameters) throws Exception {
		return dao.getDSTDetailExcel(parameters);
	}
}
