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
import com.techwin.tg.testItem.PTZ.command.service.PtzMainService;

@Controller
@RequestMapping("/tgPtzMain.do")
public class PtzMainController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	PtzMainService ptzMainService;

	@RequestMapping(params = RequestConstants.LIST)
	public String getPtzMainList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nPTZ 메인 리스트\n");
		return "tgPtzMain";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getPtzMainTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nPTZ 메인 리스트(탭)\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return "/tg/testItem/PTZ/command/PtzMain";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getPtzMainList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nPTZ 메인 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, ptzMainService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getPtzMainExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nPTZ 메인 export excel\n");
		
		List<Map<String, Object>> list = ptzMainService.getPtzMainExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
