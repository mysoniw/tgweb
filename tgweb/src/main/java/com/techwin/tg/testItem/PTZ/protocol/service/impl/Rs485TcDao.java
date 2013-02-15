package com.techwin.tg.testItem.PTZ.protocol.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("rs485TcDao")
public class Rs485TcDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getRs485TcList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("Rs485TcDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getRs485TcExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("Rs485TcDao.exportExcel", parameters);
	}
}
