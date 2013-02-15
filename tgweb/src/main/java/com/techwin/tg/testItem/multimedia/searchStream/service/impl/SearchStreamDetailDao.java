package com.techwin.tg.testItem.multimedia.searchStream.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("searchStreamDetailDao")
public class SearchStreamDetailDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSearchStreamDetailList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SearchStreamDetailDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSearchStreamDetailExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SearchStreamDetailDao.exportExcel", parameters);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSearchStreamDetailImage(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SearchStreamDetailDao.findImage", parameters);
	}
}
