package com.techwin.tg.testItem.PTZ.command.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("ptzTcDao")
public class PtzTcDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPtzTcList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("PtzTcDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPtzTcExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("PtzTcDao.exportExcel", parameters);
	}
}
