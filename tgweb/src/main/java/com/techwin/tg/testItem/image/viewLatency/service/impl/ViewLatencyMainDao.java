package com.techwin.tg.testItem.image.viewLatency.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository
public class ViewLatencyMainDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getViewLatencyMainList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("ViewLatencyMainDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getViewLatencyMainExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("ViewLatencyMainDao.exportExcel", parameters);
	}
}
