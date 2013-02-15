package com.techwin.tg.testItem.PTZ.command.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("ptzMainDao")
public class PtzMainDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPtzMainList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("PtzMainDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPtzMainExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("PtzMainDao.exportExcel", parameters);
	}
}
