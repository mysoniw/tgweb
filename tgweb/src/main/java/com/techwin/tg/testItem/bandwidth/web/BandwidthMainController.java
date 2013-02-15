package com.techwin.tg.testItem.bandwidth.web;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONValue;
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
import com.techwin.common.util.model.ExportExcelUtilModel;
import com.techwin.tg.testItem.bandwidth.service.BandwidthMainService;

@Controller
@RequestMapping("/tgBandwidthMain.do")
public class BandwidthMainController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	BandwidthMainService bandwidthMainService;

	@RequestMapping(params = RequestConstants.LIST)
	public String getBandwidthMainList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nBandwidth 메인 리스트\n");
		
		return "tgBandwidthMain";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getBandwidthMainTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nBandwidth 메인 리스트(탭)\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		logger.debug(JSONValue.toJSONString(parameterMap).replace("\'", "\""));
		model.addAttribute("params", parameterMap);
		
		return "/tg/testItem/bandwidth/BandwidthMain";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getBandwidthMainList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nBandwidth 메인 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, bandwidthMainService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getBandwidthMainExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nBandwidth 메인 export excel\n");
		
		List<Map<String, Object>> list = bandwidthMainService.getBandwidthMainExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
	
	@Deprecated
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.REPORT)
	public void getBandwidthMainExcelReport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nBandwidth 메인 export excel report\n");
		
		List<ExportExcelUtilModel> list = bandwidthMainService.getBandwidthMainExcelReport(RequestUtil.bindParameterToMap(request.getParameterMap()));
		
		if (list != null) {
			ExportExcelUtilModel model = list.get(0);
			
			File file = new File(getClass().getResource("template/Bandwidth_Report_Template.xls").toURI());
			model.setTemplateFile(file);
		}
		
		ExportExcelUtil.bandwidthReport(request, response, list);
	}
}
