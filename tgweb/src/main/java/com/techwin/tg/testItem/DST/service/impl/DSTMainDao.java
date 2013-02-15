package com.techwin.tg.testItem.DST.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("dstMainDao")
public class DSTMainDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getDSTMainList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("DSTMainDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getDSTMainExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("DSTMainDao.exportExcel", parameters);
	}
}
