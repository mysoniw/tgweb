package com.techwin.tg.testItem.bandwidth.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.bandwidth.service.BandwidthCycleService;

@Service("bandwidthCycleService")
public class BandwidthCycleServiceImpl implements BandwidthCycleService {
	
	@Inject
	@Named("bandwidthCycleDao")
	private BandwidthCycleDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getBandwidthCycleList(parameters);
	}
	
	public List<Map<String, Object>> getBandwidthCycleExcel(Map<String, Object> parameters) throws Exception {
		return dao.getBandwidthCycleExcel(parameters);
	}
}
