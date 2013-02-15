package com.techwin.tg.main.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.main.service.MainResultService;

@Service("mainResultService")
public class MainResultServiceImpl implements MainResultService {
	
	@Inject
	@Named("mainResultDao")
	private MainResultDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getMainResultList(parameters);
	}
	
	public List<Map<String, Object>> getMainResultExcel(Map<String, Object> parameters) throws Exception {
		return dao.getMainResultExcel(parameters);
	}
}
