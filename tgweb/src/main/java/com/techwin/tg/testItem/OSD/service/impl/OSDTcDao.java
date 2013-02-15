package com.techwin.tg.testItem.OSD.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("osdTcDao")
public class OSDTcDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getOSDTcList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("OSDTcDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getOSDTcExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("OSDTcDao.exportExcel", parameters);
	}
}
