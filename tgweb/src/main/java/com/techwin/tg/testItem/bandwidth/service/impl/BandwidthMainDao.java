package com.techwin.tg.testItem.bandwidth.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("bandwidthMainDao")
public class BandwidthMainDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getBandwidthMainList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("BandwidthMainDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getBandwidthMainExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("BandwidthMainDao.exportExcel", parameters);
	}
	
	@Deprecated
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getBandwidthMainExcelReport(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("BandwidthMainDao.exportExcelReport", parameters);
	}
}
