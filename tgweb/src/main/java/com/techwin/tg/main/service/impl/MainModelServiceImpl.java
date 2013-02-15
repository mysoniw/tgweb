package com.techwin.tg.main.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.main.service.MainModelService;

@Service("mainModelService")
public class MainModelServiceImpl implements MainModelService {
	
	@Inject
	@Named("mainModelDao")
	private MainModelDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getMainModelList(parameters);
	}
	
	public List<Map<String, Object>> getMainModelExcel(Map<String, Object> parameters) throws Exception {
		return dao.getMainModelExcel(parameters);
	}
}
