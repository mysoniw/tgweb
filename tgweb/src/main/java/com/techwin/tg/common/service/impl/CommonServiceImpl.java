package com.techwin.tg.common.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.common.service.CommonService;

@Service("commonService")
public class CommonServiceImpl implements CommonService {
	
	@Inject
	@Named("commonDao")
	private CommonDao dao;
	
	public List<Map<String, Object>> getSelect(Map<String, Object> parameters) throws Exception {
		return dao.getSelect(parameters);
	}

	public List<Map<String, Object>> getTestSuiteSelect(Map<String, Object> parameters) throws Exception {
		return dao.getTestSuiteSelect(parameters);
	}
	
	public List<Map<String, Object>> getGroupSelect(Map<String, Object> parameters) throws Exception {
		return dao.getGroupSelect(parameters);
	}
}
