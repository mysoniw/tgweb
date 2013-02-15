package com.techwin.tg.testItem.multimedia.searchStream.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("searchStreamMainDao")
public class SearchStreamMainDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSearchStreamMainList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SearchStreamMainDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSearchStreamMainExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SearchStreamMainDao.exportExcel", parameters);
	}
}
