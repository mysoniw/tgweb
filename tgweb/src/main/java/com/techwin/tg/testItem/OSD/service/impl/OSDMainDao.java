package com.techwin.tg.testItem.OSD.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("osdMainDao")
public class OSDMainDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getOSDMainList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("OSDMainDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getOSDMainExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("OSDMainDao.exportExcel", parameters);
	}
}
