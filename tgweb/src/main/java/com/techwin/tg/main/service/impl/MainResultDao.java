package com.techwin.tg.main.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("mainResultDao")
public class MainResultDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getMainResultList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("MainResultDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getMainResultExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("MainResultDao.exportExcel", parameters);
	}
}
