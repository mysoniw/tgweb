package com.techwin.tg.testItem.PTZ.command.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.PTZ.command.service.PtzTcService;

@Service("ptzTcService")
public class PtzTcServiceImpl implements PtzTcService {
	
	@Inject
	@Named("ptzTcDao")
	private PtzTcDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getPtzTcList(parameters);
	}
	
	public List<Map<String, Object>> getPtzTcExcel(Map<String, Object> parameters) throws Exception {
		return dao.getPtzTcExcel(parameters);
	}
}
