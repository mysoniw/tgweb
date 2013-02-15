package com.techwin.tg.testItem.PTZ.protocol.web;

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
import com.techwin.tg.testItem.PTZ.protocol.service.Rs485MainService;

@Controller
@RequestMapping("/tgRs485Main.do")
public class Rs485MainController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	Rs485MainService rs485MainService;

	@RequestMapping(params = RequestConstants.LIST)
	public String getRs485MainList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nRS-485 메인 리스트\n");
		return "tgRs485Main";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getRs485MainTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nRS-485 메인 리스트(탭)\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return "/tg/testItem/PTZ/protocol/Rs485Main";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getRs485MainList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nRS-485 메인 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, rs485MainService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getRs485MainExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nRS-485 메인 export excel\n");
		
		List<Map<String, Object>> list = rs485MainService.getRs485MainExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
