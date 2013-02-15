package com.techwin.tg.testItem.multimedia.liveStream.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("liveStreamMainDao")
public class LiveStreamMainDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getLiveStreamMainList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("LiveStreamMainDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getLiveStreamMainExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("LiveStreamMainDao.exportExcel", parameters);
	}
}
