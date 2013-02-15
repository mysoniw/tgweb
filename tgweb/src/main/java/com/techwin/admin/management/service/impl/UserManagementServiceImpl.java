package com.techwin.admin.management.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.admin.management.service.UserManagementService;

@Service("userManagementService")
public class UserManagementServiceImpl implements UserManagementService {
	
	@Inject
	@Named("userManagementDao")
	private UserManagementDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getUserManagementList(parameters);
	}
	
	public Map<String, Object> checkDuplication(Map<String, Object> parameterMap) throws Exception {
		return dao.checkDuplication(parameterMap);
	}

	public void updateUserManagement(Map<String, Object> parameters) throws Exception {
		dao.updateUserManagement(parameters);
	}
	
	public void deleteUserManagement(Map<String, Object> parameters) throws Exception {
		dao.deleteUserManagement(parameters);
	}
	
	public void createUserManagement(Map<String, Object> parameters) throws Exception {
		dao.createUserManagement(parameters);
	}
	
	public List<Map<String, Object>> getUserManagementExcel(Map<String, Object> parameters) throws Exception {
		return dao.getUserManagementExcel(parameters);
	}
}
