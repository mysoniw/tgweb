package com.techwin.tg.testItem.OSD.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.OSD.service.OSDTcService;

@Service("osdTcService")
public class OSDTcServiceImpl implements OSDTcService {
	
	@Inject
	@Named("osdTcDao")
	private OSDTcDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getOSDTcList(parameters);
	}
	
	public List<Map<String, Object>> getOSDTcExcel(Map<String, Object> parameters) throws Exception {
		return dao.getOSDTcExcel(parameters);
	}
}
