package com.techwin.tg.testItem.DST.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.DST.service.DSTTcService;

@Service("dstTcService")
public class DSTTcServiceImpl implements DSTTcService {
	
	@Inject
	@Named("dstTcDao")
	private DSTTcDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getDSTTcList(parameters);
	}
	
	public List<Map<String, Object>> getDSTTcExcel(Map<String, Object> parameters) throws Exception {
		return dao.getDSTTcExcel(parameters);
	}
}
