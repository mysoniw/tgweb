package com.techwin.tg.testItem.multimedia.searchStream.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("searchStreamTcDao")
public class SearchStreamTcDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSearchStreamTcList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SearchStreamTcDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSearchStreamTcExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SearchStreamTcDao.exportExcel", parameters);
	}
}
