package com.techwin.tg.testItem.image.viewLatency.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository
public class ViewLatencyCycleDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getViewLatencyCycleList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("ViewLatencyCycleDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getViewLatencyCycleExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("ViewLatencyCycleDao.exportExcel", parameters);
	}
}
