package com.techwin.tg.testItem.PTZ.protocol.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("rs485CycleDao")
public class Rs485CycleDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getRs485CycleList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("Rs485CycleDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getRs485CycleExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("Rs485CycleDao.exportExcel", parameters);
	}
}
