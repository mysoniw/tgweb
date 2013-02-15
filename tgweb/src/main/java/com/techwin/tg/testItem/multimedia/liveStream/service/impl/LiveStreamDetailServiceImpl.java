package com.techwin.tg.testItem.multimedia.liveStream.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.multimedia.liveStream.service.LiveStreamDetailService;

@Service("liveStreamDetailService")
public class LiveStreamDetailServiceImpl implements LiveStreamDetailService {
	
	@Inject
	@Named("liveStreamDetailDao")
	private LiveStreamDetailDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getLiveStreamDetailList(parameters);
	}
	
	public List<Map<String, Object>> getLiveStreamDetailExcel(Map<String, Object> parameters) throws Exception {
		return dao.getLiveStreamDetailExcel(parameters);
	}

	@Override
	public List<Map<String, Object>> getLiveStreamDetailImage(Map<String, Object> parameters) throws Exception {
		return dao.getLiveStreamDetailImage(parameters);
	}
}
