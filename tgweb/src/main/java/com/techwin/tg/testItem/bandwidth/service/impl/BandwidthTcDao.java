package com.techwin.tg.testItem.bandwidth.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("bandwidthTcDao")
public class BandwidthTcDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getBandwidthTcList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("BandwidthTcDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getBandwidthTcExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("BandwidthTcDao.exportExcel", parameters);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getBandwidthTcReport(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("BandwidthTcDao.exportExcelReport", parameters);
	}
}
