package com.techwin.tg.testItem.multimedia.liveStream.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("liveStreamDetailDao")
public class LiveStreamDetailDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getLiveStreamDetailList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("LiveStreamDetailDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getLiveStreamDetailExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("LiveStreamDetailDao.exportExcel", parameters);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getLiveStreamDetailImage(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("LiveStreamDetailDao.findImage", parameters);
	}
}
