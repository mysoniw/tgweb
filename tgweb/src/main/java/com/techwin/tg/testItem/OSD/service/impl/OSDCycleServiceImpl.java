package com.techwin.tg.testItem.OSD.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.OSD.service.OSDCycleService;

@Service("osdCycleService")
public class OSDCycleServiceImpl implements OSDCycleService {
	
	@Inject
	@Named("osdCycleDao")
	private OSDCycleDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getOSDCycleList(parameters);
	}
	
	public List<Map<String, Object>> getOSDCycleExcel(Map<String, Object> parameters) throws Exception {
		return dao.getOSDCycleExcel(parameters);
	}
}
