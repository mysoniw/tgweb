package com.techwin.tg.testItem.image.imageConfirm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository
public class ImageConfirmTcDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getImageConfirmTcList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("ImageConfirmTcDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getImageConfirmTcExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("ImageConfirmTcDao.exportExcel", parameters);
	}
}
