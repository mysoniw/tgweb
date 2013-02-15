package com.techwin.support.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("downloadDao")
public class DownloadDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getDownloadList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("DownloadDao.findAll", parameters);
	}

	public void updateDownload(Map<String, Object> parameters) throws Exception {
		super.update("DownloadDao.update", parameters);
	}
	
	public void deleteDownload(Map<String, Object> parameters) throws Exception {
		super.update("DownloadDao.delete", parameters);
	}
	
	public void createDownload(Map<String, Object> parameters) throws Exception {
		super.create("DownloadDao.create", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getFileFullPath(Map<String, Object> parameters) throws Exception {
		return (Map<String, Object>)super.findByPk("DownloadDao.find", parameters);
	}
}
