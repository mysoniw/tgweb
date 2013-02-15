package com.techwin.tg.testItem.web.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("webTcDao")
public class WebTcDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getWebTcList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("WebTcDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getWebTcExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("WebTcDao.exportExcel", parameters);
	}
}
