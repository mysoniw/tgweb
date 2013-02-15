package com.techwin.tg.testItem.multimedia.liveStream.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.multimedia.liveStream.service.LiveStreamTcService;

@Service("liveStreamTcService")
public class LiveStreamTcServiceImpl implements LiveStreamTcService {
	
	@Inject
	@Named("liveStreamTcDao")
	private LiveStreamTcDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getLiveStreamTcList(parameters);
	}
	
	public List<Map<String, Object>> getLiveStreamTcExcel(Map<String, Object> parameters) throws Exception {
		return dao.getLiveStreamTcExcel(parameters);
	}
}
