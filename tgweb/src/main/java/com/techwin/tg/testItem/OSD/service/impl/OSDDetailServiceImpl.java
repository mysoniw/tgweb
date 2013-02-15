package com.techwin.tg.testItem.OSD.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.OSD.service.OSDDetailService;

@Service("osdDetailService")
public class OSDDetailServiceImpl implements OSDDetailService {
	
	@Inject
	@Named("osdDetailDao")
	private OSDDetailDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getOSDDetailList(parameters);
	}
	
	public List<Map<String, Object>> getOSDDetailExcel(Map<String, Object> parameters) throws Exception {
		return dao.getOSDDetailExcel(parameters);
	}
}
