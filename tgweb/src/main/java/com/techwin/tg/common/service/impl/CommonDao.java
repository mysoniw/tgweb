package com.techwin.tg.common.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("commonDao")
public class CommonDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSelect(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("CommonDao.select", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getTestSuiteSelect(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("CommonDao.testSuiteSelect", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getGroupSelect(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("CommonDao.groupSelect", parameters);
	}
}
