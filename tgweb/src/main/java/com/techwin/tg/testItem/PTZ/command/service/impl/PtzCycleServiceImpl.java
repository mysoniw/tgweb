package com.techwin.tg.testItem.PTZ.command.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.PTZ.command.service.PtzCycleService;

@Service("ptzCycleService")
public class PtzCycleServiceImpl implements PtzCycleService {
	
	@Inject
	@Named("ptzCycleDao")
	private PtzCycleDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getPtzCycleList(parameters);
	}
	
	public List<Map<String, Object>> getPtzCycleExcel(Map<String, Object> parameters) throws Exception {
		return dao.getPtzCycleExcel(parameters);
	}
}
