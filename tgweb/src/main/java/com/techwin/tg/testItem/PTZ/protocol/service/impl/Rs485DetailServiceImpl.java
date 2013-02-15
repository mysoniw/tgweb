package com.techwin.tg.testItem.PTZ.protocol.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.PTZ.protocol.service.Rs485DetailService;

@Service("rs485DetailService")
public class Rs485DetailServiceImpl implements Rs485DetailService {
	
	@Inject
	@Named("rs485DetailDao")
	private Rs485DetailDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getRs485DetailList(parameters);
	}
	
	public List<Map<String, Object>> getRs485DetailExcel(Map<String, Object> parameters) throws Exception {
		return dao.getRs485DetailExcel(parameters);
	}
}
