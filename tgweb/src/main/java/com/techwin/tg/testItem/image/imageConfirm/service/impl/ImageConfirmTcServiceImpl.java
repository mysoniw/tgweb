package com.techwin.tg.testItem.image.imageConfirm.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.image.imageConfirm.service.ImageConfirmTcService;

@Service("imageConfirmTcService")
public class ImageConfirmTcServiceImpl implements ImageConfirmTcService {

	@Inject
	private ImageConfirmTcDao imageConfirmTcDao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return imageConfirmTcDao.getImageConfirmTcList(parameters);
	}
	
	public List<Map<String, Object>> getImageConfirmTcExcel(Map<String, Object> parameters) throws Exception {
		return imageConfirmTcDao.getImageConfirmTcExcel(parameters);
	}
}
