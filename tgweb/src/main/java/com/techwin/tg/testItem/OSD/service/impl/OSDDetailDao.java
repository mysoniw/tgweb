package com.techwin.tg.testItem.OSD.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("osdDetailDao")
public class OSDDetailDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getOSDDetailList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("OSDDetailDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getOSDDetailExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("OSDDetailDao.exportExcel", parameters);
	}
}
