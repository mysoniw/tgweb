package com.techwin.tg.testItem.image.imageConfirm.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.image.imageConfirm.service.ImageConfirmMainService;

@Service("imageConfirmMainService")
public class ImageConfirmMainServiceImpl implements ImageConfirmMainService {

	@Inject
	private ImageConfirmMainDao imageConfirmMainDao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return imageConfirmMainDao.getImageConfirmMainList(parameters);
	}
	
	public List<Map<String, Object>> getImageConfirmMainExcel(Map<String, Object> parameters) throws Exception {
		return imageConfirmMainDao.getImageConfirmMainExcel(parameters);
	}
}
