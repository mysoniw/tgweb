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
import com.techwin.tg.testItem.multimedia.searchStream.service.SearchStreamCycleService;

@Controller
@RequestMapping("/tgSearchStreamCycle.do")
public class SearchStreamCycleController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	SearchStreamCycleService searchStreamCycleService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getSearchStreamCycleTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nSearchStream cycle 탭\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return "/tg/testItem/multimedia/searchStream/SearchStreamCycle";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getSearchStreamCycleList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nSearchStream cycle 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, searchStreamCycleService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getSearchStreamCycleExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nSearchStream cycle export excel\n");
		
		List<Map<String, Object>> list = searchStreamCycleService.getSearchStreamCycleExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
