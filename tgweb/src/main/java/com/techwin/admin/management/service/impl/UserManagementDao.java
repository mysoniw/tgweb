package com.techwin.admin.management.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("userManagementDao")
public class UserManagementDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getUserManagementList(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("UserManagementDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> checkDuplication(Map<String, Object> parameterMap) throws Exception {
		Map<String, Object> map = (Map<String, Object>)super.findByPk("UserManagementDao.checkDuplication", parameterMap);
		
		return map;
	}

	public void updateUserManagement(Map<String, Object> parameters) throws Exception {
		super.update("UserManagementDao.update", parameters);
	}
	
	public void deleteUserManagement(Map<String, Object> parameters) throws Exception {
		super.update("UserManagementDao.delete", parameters);
	}
	
	public void createUserManagement(Map<String, Object> parameters) throws Exception {
		super.create("UserManagementDao.create", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getUserManagementExcel(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("UserManagementDao.exportExcel", parameters);
	}
}
