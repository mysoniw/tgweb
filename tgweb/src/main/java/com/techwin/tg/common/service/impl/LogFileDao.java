package com.techwin.tg.common.service.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("logFileDao")
public class LogFileDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public Map<String, Object> getLogFileFullPath(Map<String, Object> parameters) throws Exception {
		return (Map<String, Object>)super.findByPk("LogFileDao.find", parameters);
	}
}
