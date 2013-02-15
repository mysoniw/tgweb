package com.techwin.tg.testItem.DST.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("dstTcDao")
public class DSTTcDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getDSTTcList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("DSTTcDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getDSTTcExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("DSTTcDao.exportExcel", parameters);
	}
}
