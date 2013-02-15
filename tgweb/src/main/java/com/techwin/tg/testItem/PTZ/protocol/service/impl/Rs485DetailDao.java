package com.techwin.tg.testItem.PTZ.protocol.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("rs485DetailDao")
public class Rs485DetailDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getRs485DetailList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("Rs485DetailDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getRs485DetailExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("Rs485DetailDao.exportExcel", parameters);
	}
}
