package com.techwin.tg.testItem.PTZ.protocol.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("rs485MainDao")
public class Rs485MainDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getRs485MainList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("Rs485MainDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getRs485MainExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("Rs485MainDao.exportExcel", parameters);
	}
}
