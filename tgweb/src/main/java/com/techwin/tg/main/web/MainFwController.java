package com.techwin.tg.main.web;

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

import com.techwin.common.constants.RequestConstants;
import com.techwin.common.json.JqGridMapper;
import com.techwin.common.util.ExportExcelUtil;
import com.techwin.common.util.RequestUtil;
import com.techwin.tg.main.service.MainFwService;

@Controller
@RequestMapping("/tgMainFw.do")
public class MainFwController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	MainFwService mainFwService;

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getMainFwList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nFirmware 리스트(탭)\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return "/tg/main/MainFw";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getMainFwList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nFirmware 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, mainFwService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getMainFwExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nFirmware export excel\n");
		
		List<Map<String, Object>> list = mainFwService.getMainFwExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.REPORT)
	public void getMainFwExcelReport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nFirmware export excel report\n");
		
		Map<String, List<Map<String, Object>>> map = mainFwService.getMainFwExcelReport(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelMultiSheet(request, response, map);
	}
}
