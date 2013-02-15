package com.techwin.tg.testItem.PTZ.protocol.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.PTZ.protocol.service.Rs485MainService;

@Service("rs485MainService")
public class Rs485MainServiceImpl implements Rs485MainService {
	
	@Inject
	@Named("rs485MainDao")
	private Rs485MainDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getRs485MainList(parameters);
	}
	
	public List<Map<String, Object>> getRs485MainExcel(Map<String, Object> parameters) throws Exception {
		return dao.getRs485MainExcel(parameters);
	}
}
