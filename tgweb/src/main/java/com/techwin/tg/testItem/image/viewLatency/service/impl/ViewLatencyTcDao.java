package com.techwin.tg.testItem.image.viewLatency.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository
public class ViewLatencyTcDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getViewLatencyTcList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("ViewLatencyTcDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getViewLatencyTcExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("ViewLatencyTcDao.exportExcel", parameters);
	}
}
