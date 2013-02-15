package com.techwin.tg.testItem.image.imageConfirm.service;

import java.util.List;
import java.util.Map;

public interface ImageConfirmDetailService {

	public List<Map<String, Object>> getImageConfirmDetail(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getImageConfirmDetailExcel(Map<String, Object> parameters) throws Exception;
}
