package com.techwin.tg.testItem.multimedia.liveStream.web;

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
import com.techwin.tg.testItem.multimedia.liveStream.service.LiveStreamDetailService;

@Controller
@RequestMapping("/tgLiveStreamDetail.do")
public class LiveStreamDetailController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	LiveStreamDetailService liveStreamDetailService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getLiveStreamDetailTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nLiveStream detail 탭\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		List<Map<String, Object>> retList = liveStreamDetailService.getLiveStreamDetailImage(parameterMap);
		
		model.addAttribute("entryList", retList);
		
		return "/tg/testItem/multimedia/liveStream/LiveStreamDetail";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getLiveStreamDetailList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nLiveStream detail 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, liveStreamDetailService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getLiveStreamDetailExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nLiveStream detail export excel\n");
		
		List<Map<String, Object>> list = liveStreamDetailService.getLiveStreamDetailExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
