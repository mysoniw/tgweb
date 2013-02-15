package com.techwin.tg.testItem.multimedia.liveStream.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.multimedia.liveStream.service.LiveStreamMainService;

@Service("liveStreamMainService")
public class LiveStreamMainServiceImpl implements LiveStreamMainService {
	
	@Inject
	@Named("liveStreamMainDao")
	private LiveStreamMainDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getLiveStreamMainList(parameters);
	}
	
	public List<Map<String, Object>> getLiveStreamMainExcel(Map<String, Object> parameters) throws Exception {
		return dao.getLiveStreamMainExcel(parameters);
	}
}
