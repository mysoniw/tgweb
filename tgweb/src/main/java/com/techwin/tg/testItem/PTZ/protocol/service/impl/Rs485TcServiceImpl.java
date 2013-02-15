package com.techwin.tg.testItem.PTZ.protocol.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.PTZ.protocol.service.Rs485TcService;

@Service("rs485TcService")
public class Rs485TcServiceImpl implements Rs485TcService {
	
	@Inject
	@Named("rs485TcDao")
	private Rs485TcDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getRs485TcList(parameters);
	}
	
	public List<Map<String, Object>> getRs485TcExcel(Map<String, Object> parameters) throws Exception {
		return dao.getRs485TcExcel(parameters);
	}
}
