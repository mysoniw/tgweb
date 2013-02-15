package com.techwin.tg.testItem.image.imageConfirm.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface ImageConfirmMainService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getImageConfirmMainExcel(Map<String, Object> parameters) throws Exception;
}
