package com.techwin.tg.testItem.PTZ.command.web;

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
import com.techwin.tg.testItem.PTZ.command.service.PtzTcService;

@Controller
@RequestMapping("/tgPtzTc.do")
public class PtzTcController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	PtzTcService ptzTcService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.LIST)
	public String getPtzTcList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nptz TC 리스트\n");

		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		model.addAttribute("params", parameterMap);
		
		return "tgPtzTc";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getPtzTcTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nptz TC 리스트(탭)\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return "/tg/testItem/PTZ/command/PtzTc";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getPtzTcList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nptz TC 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, ptzTcService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getPtzTcExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nptz TC export excel\n");
		
		List<Map<String, Object>> list = ptzTcService.getPtzTcExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
