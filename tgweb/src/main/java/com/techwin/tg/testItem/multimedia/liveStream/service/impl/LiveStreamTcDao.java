package com.techwin.tg.testItem.multimedia.liveStream.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("liveStreamTcDao")
public class LiveStreamTcDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getLiveStreamTcList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("LiveStreamTcDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getLiveStreamTcExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("LiveStreamTcDao.exportExcel", parameters);
	}
}
