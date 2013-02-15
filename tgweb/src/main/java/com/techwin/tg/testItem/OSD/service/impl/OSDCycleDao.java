package com.techwin.tg.testItem.OSD.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("osdCycleDao")
public class OSDCycleDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getOSDCycleList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("OSDCycleDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getOSDCycleExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("OSDCycleDao.exportExcel", parameters);
	}
}
