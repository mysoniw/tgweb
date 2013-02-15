package com.techwin.tg.testItem.bandwidth.web;

import java.io.File;
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
import com.techwin.common.util.model.ExportExcelUtilModel;
import com.techwin.tg.testItem.bandwidth.service.BandwidthTcService;

@Controller
@RequestMapping("/tgBandwidthTc.do")
public class BandwidthTcController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	BandwidthTcService bandwidthTcService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.LIST)
	public String getBandwidthTcList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nBandwidth TC 리스트\n");

		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		model.addAttribute("params", parameterMap);
		
		return "tgBandwidthTc";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getBandwidthTcTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nBandwidth TC 리스트(탭)\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return "/tg/testItem/bandwidth/BandwidthTc";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getBandwidthTcList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nBandwidth TC 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, bandwidthTcService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getBandwidthTcExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nBandwidth TC export excel\n");
		
		List<Map<String, Object>> list = bandwidthTcService.getBandwidthTcExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.REPORT)
	public void getBandWidthTcReport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nBandwidth TC export report\n");
		
		ExportExcelUtilModel model = bandwidthTcService.getBandwidthTcReport(RequestUtil.bindParameterToMap(request.getParameterMap()));
		
		if (model != null) {
			File file = new File(getClass().getResource("/template/Bandwidth_Tc_Report_Template.xls").toURI());
			model.setTemplateFile(file);
		}
		
		ExportExcelUtil.bandwidthTcReport(request, response, model);
	}
}
