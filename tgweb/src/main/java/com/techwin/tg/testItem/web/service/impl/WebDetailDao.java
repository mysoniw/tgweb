package com.techwin.tg.testItem.web.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("webDetailDao")
public class WebDetailDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getWebDetailList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("WebDetailDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getWebDetailExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("WebDetailDao.exportExcel", parameters);
	}
}
