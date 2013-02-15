package com.techwin.tg.testItem.bandwidth.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("bandwidthCycleDao")
public class BandwidthCycleDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getBandwidthCycleList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("BandwidthCycleDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getBandwidthCycleExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("BandwidthCycleDao.exportExcel", parameters);
	}
}
