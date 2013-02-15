package com.techwin.tg.testItem.multimedia.liveStream.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.multimedia.liveStream.service.LiveStreamCycleService;

@Service("liveStreamCycleService")
public class LiveStreamCycleServiceImpl implements LiveStreamCycleService {
	
	@Inject
	@Named("liveStreamCycleDao")
	private LiveStreamCycleDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getLiveStreamCycleList(parameters);
	}
	
	public List<Map<String, Object>> getLiveStreamCycleExcel(Map<String, Object> parameters) throws Exception {
		return dao.getLiveStreamCycleExcel(parameters);
	}
}
