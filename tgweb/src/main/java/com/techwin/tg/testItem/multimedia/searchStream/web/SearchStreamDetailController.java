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
import com.techwin.tg.testItem.multimedia.searchStream.service.SearchStreamDetailService;

@Controller
@RequestMapping("/tgSearchStreamDetail.do")
public class SearchStreamDetailController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	SearchStreamDetailService searchStreamDetailService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getSearchStreamDetailTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nSearchStream detail 탭\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		List<Map<String, Object>> retList = searchStreamDetailService.getSearchStreamDetailImage(parameterMap);
		
		model.addAttribute("entryList", retList);
		
		return "/tg/testItem/multimedia/searchStream/SearchStreamDetail";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getSearchStreamDetailList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nSearchStream detail 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, searchStreamDetailService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getSearchStreamDetailExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nSearchStream detail export excel\n");
		
		List<Map<String, Object>> list = searchStreamDetailService.getSearchStreamDetailExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
