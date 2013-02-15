package com.techwin.admin.common.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("adminCommonDao")
public class CommonDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSelect(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("AdminCommonDao.select", parameters);
	}
}
