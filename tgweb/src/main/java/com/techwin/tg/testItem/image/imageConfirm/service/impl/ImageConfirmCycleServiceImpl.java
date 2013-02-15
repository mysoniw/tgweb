package com.techwin.tg.testItem.image.imageConfirm.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.image.imageConfirm.service.ImageConfirmCycleService;

@Service("imageConfirmCycleService")
public class ImageConfirmCycleServiceImpl implements ImageConfirmCycleService {

	@Inject
	private ImageConfirmCycleDao imageConfirmCycleDao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return imageConfirmCycleDao.getImageConfirmCycleList(parameters);
	}
	
	public List<Map<String, Object>> getImageConfirmCycleExcel(Map<String, Object> parameters) throws Exception {
		return imageConfirmCycleDao.getImageConfirmCycleExcel(parameters);
	}
}
