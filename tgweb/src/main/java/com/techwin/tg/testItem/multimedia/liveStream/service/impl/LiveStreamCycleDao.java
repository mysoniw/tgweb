package com.techwin.tg.testItem.multimedia.liveStream.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("liveStreamCycleDao")
public class LiveStreamCycleDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getLiveStreamCycleList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("LiveStreamCycleDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getLiveStreamCycleExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("LiveStreamCycleDao.exportExcel", parameters);
	}
}
