package com.techwin.tg.testItem.PTZ.command.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("ptzDetailDao")
public class PtzDetailDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPtzDetailList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("PtzDetailDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPtzDetailExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("PtzDetailDao.exportExcel", parameters);
	}
}
