package com.techwin.tg.testItem.web.web;

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
import com.techwin.tg.testItem.web.service.WebMainService;

@Controller
@RequestMapping("/tgWebMain.do")
public class WebMainController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	WebMainService webMainService;

	@RequestMapping(params = RequestConstants.LIST)
	public String getWebMainList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nWeb 메인 리스트\n");
		return "tgWebMain";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getWebMainTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nWeb 메인 리스트(탭)\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return "/tg/testItem/web/WebMain";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getWebMainList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nWeb 메인 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, webMainService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getWebMainExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nWeb 메인 export excel\n");
		
		List<Map<String, Object>> list = webMainService.getWebMainExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
