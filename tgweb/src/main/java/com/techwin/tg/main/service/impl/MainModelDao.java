package com.techwin.tg.main.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("mainModelDao")
public class MainModelDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getMainModelList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("MainModelDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getMainModelExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("MainModelDao.exportExcel", parameters);
	}
}
