package com.techwin.tg.testItem.PTZ.protocol.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.PTZ.protocol.service.Rs485CycleService;

@Service("rs485CycleService")
public class Rs485CycleServiceImpl implements Rs485CycleService {
	
	@Inject
	@Named("rs485CycleDao")
	private Rs485CycleDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getRs485CycleList(parameters);
	}
	
	public List<Map<String, Object>> getRs485CycleExcel(Map<String, Object> parameters) throws Exception {
		return dao.getRs485CycleExcel(parameters);
	}
}
