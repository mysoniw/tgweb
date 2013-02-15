package com.techwin.tg.main.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("mainFwDao")
public class MainFwDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getMainFwList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("MainFwDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getMainFwExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("MainFwDao.exportExcel", parameters);
	}
}
