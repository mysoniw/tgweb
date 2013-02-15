package com.techwin.tg.testItem.DST.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("dstCycleDao")
public class DSTCycleDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getDSTCycleList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("DSTCycleDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getDSTCycleExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("DSTCycleDao.exportExcel", parameters);
	}
}
