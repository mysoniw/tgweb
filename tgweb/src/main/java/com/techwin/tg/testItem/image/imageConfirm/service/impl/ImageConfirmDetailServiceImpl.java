package com.techwin.tg.testItem.image.imageConfirm.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.techwin.tg.testItem.image.imageConfirm.service.ImageConfirmDetailService;

@Service("imageConfirmDetailService")
public class ImageConfirmDetailServiceImpl implements ImageConfirmDetailService {

	@Inject
	private ImageConfirmDetailDao imageConfirmDetailDao;

	public List<Map<String, Object>> getImageConfirmDetail(Map<String, Object> parameters) throws Exception {
		return imageConfirmDetailDao.getImageConfirmDetailList(parameters);
	}
	
	public List<Map<String, Object>> getImageConfirmDetailExcel(Map<String, Object> parameters) throws Exception {
		return imageConfirmDetailDao.getImageConfirmDetailExcel(parameters);
	}
}
