package com.techwin.tg.testItem.web.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("webMainDao")
public class WebMainDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getWebMainList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("WebMainDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getWebMainExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("WebMainDao.exportExcel", parameters);
	}
}
