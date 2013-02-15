package com.techwin.admin.management.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;

public interface UserManagementService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;

	public Map<String, Object> checkDuplication(Map<String, Object> parameterMap) throws Exception;

	public void updateUserManagement(Map<String, Object> parameters) throws Exception;

	public void deleteUserManagement(Map<String, Object> parameters) throws Exception;

	public void createUserManagement(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getUserManagementExcel(Map<String, Object> parameters) throws Exception;

}
