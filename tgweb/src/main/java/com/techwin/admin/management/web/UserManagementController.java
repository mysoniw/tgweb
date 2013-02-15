package com.techwin.admin.management.web;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.techwin.admin.management.service.UserManagementService;
import com.techwin.common.constants.RequestConstants;
import com.techwin.common.json.JqGridMapper;
import com.techwin.common.util.ExportExcelUtil;
import com.techwin.common.util.RequestUtil;

@Controller
@RequestMapping("/adminUserManagement.do")
public class UserManagementController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	UserManagementService userManagementService;

	@RequestMapping(params = RequestConstants.LIST)
	public String getUserManagementList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\n사용자관리 리스트\n");
		
		return "adminUserManagement";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getUserManagementList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\n사용자관리 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, userManagementService);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=checkDuplication")
	public void checkDuplication(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\n사용자관리 중복 email 검사");

		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		Map<String, Object> returnMap = userManagementService.checkDuplication(parameterMap);
		
		RequestUtil.responseWithJson(response, returnMap);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.UPDATE_PROCESS)
	public void updateUserManagement(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\n사용자관리 리스트 수정\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		if ("edit".equals(parameterMap.get("oper"))) {
			userManagementService.updateUserManagement(parameterMap);
		} else if ("del".equals(parameterMap.get("oper"))) {
			userManagementService.deleteUserManagement(parameterMap);
		} else {
			userManagementService.createUserManagement(parameterMap);
		}
		
		//return RequestUtil.generateJqGridResponse(request, userManagementService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getUserManagementExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\n사용자관리 export excel\n");
		
		List<Map<String, Object>> list = userManagementService.getUserManagementExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
