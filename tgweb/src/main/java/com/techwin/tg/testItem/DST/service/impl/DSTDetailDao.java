package com.techwin.tg.testItem.DST.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("dstDetailDao")
public class DSTDetailDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public Map<String, Object> getDSTDetailList(Map<String, Object> parameters) throws Exception {
		return (Map<String, Object>)super.findByPk("DSTDetailDao.find", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getDSTDetailExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("DSTDetailDao.exportExcel", parameters);
	}
}
