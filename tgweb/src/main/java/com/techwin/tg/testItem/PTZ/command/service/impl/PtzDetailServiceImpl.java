package com.techwin.tg.testItem.PTZ.command.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.PTZ.command.service.PtzDetailService;

@Service("ptzDetailService")
public class PtzDetailServiceImpl implements PtzDetailService {
	
	@Inject
	@Named("ptzDetailDao")
	private PtzDetailDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getPtzDetailList(parameters);
	}
	
	public List<Map<String, Object>> getPtzDetailExcel(Map<String, Object> parameters) throws Exception {
		return dao.getPtzDetailExcel(parameters);
	}
}
