package com.techwin.tg.testItem.bandwidth.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.bandwidth.service.BandwidthDetailService;

@Service("bandwidthDetailService")
public class BandwidthDetailServiceImpl implements BandwidthDetailService {
	
	@Inject
	@Named("bandwidthDetailDao")
	private BandwidthDetailDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getBandwidthDetailList(parameters);
	}
	
	public List<Map<String, Object>> getBandwidthDetailExcel(Map<String, Object> parameters) throws Exception {
		return dao.getBandwidthDetailExcel(parameters);
	}
}
