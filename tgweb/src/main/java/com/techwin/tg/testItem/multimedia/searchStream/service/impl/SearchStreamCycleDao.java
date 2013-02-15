package com.techwin.tg.testItem.multimedia.searchStream.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("searchStreamCycleDao")
public class SearchStreamCycleDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSearchStreamCycleList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SearchStreamCycleDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSearchStreamCycleExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SearchStreamCycleDao.exportExcel", parameters);
	}
}
