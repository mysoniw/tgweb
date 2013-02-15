package com.techwin.tg.testItem.image.imageConfirm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository
public class ImageConfirmCycleDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getImageConfirmCycleList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("ImageConfirmCycleDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getImageConfirmCycleExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("ImageConfirmCycleDao.exportExcel", parameters);
	}
}
