package com.techwin.tg.testItem.OSD.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.OSD.service.OSDMainService;

@Service("osdMainService")
public class OSDMainServiceImpl implements OSDMainService {
	
	@Inject
	@Named("osdMainDao")
	private OSDMainDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getOSDMainList(parameters);
	}
	
	public List<Map<String, Object>> getOSDMainExcel(Map<String, Object> parameters) throws Exception {
		return dao.getOSDMainExcel(parameters);
	}
}
