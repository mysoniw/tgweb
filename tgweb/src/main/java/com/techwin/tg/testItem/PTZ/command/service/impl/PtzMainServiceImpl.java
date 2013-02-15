package com.techwin.tg.testItem.PTZ.command.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.PTZ.command.service.PtzMainService;

@Service("ptzMainService")
public class PtzMainServiceImpl implements PtzMainService {
	
	@Inject
	@Named("ptzMainDao")
	private PtzMainDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getPtzMainList(parameters);
	}
	
	public List<Map<String, Object>> getPtzMainExcel(Map<String, Object> parameters) throws Exception {
		return dao.getPtzMainExcel(parameters);
	}
}
