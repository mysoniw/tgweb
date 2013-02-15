package com.techwin.tg.testItem.multimedia.searchStream.web;

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
import com.techwin.tg.testItem.multimedia.searchStream.service.SearchStreamMainService;

@Controller
@RequestMapping("/tgSearchStreamMain.do")
public class SearchStreamMainController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	SearchStreamMainService searchStreamMainService;

	@RequestMapping(params = RequestConstants.LIST)
	public String getSearchStreamMainList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nSearchStream 메인 리스트\n");
		return "tgSearchStreamMain";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getSearchStreamMainTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nSearchStream 메인 리스트(탭)\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return "/tg/testItem/multimedia/searchStream/SearchStreamMain";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getSearchStreamMainList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nSearchStream 메인 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, searchStreamMainService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getSearchStreamMainExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nSearchStream 메인 export excel\n");
		
		List<Map<String, Object>> list = searchStreamMainService.getSearchStreamMainExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
