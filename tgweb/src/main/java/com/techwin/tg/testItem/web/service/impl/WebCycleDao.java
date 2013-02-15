package com.techwin.tg.testItem.web.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("webCycleDao")
public class WebCycleDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getWebCycleList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("WebCycleDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getWebCycleExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("WebCycleDao.exportExcel", parameters);
	}
}
