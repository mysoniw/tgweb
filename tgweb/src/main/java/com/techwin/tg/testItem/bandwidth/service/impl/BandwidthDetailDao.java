package com.techwin.tg.testItem.bandwidth.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("bandwidthDetailDao")
public class BandwidthDetailDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getBandwidthDetailList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("BandwidthDetailDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getBandwidthDetailExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("BandwidthDetailDao.exportExcel", parameters);
	}
}
