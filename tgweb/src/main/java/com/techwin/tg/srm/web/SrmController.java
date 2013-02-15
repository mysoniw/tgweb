package com.techwin.tg.srm.web;

import java.util.ArrayList;
import java.util.HashMap;
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

import com.techwin.common.util.RequestUtil;
import com.techwin.tg.srm.dto.SrmDto;
import com.techwin.tg.srm.service.SrmService;

@Controller
@RequestMapping("/tgSrm.do")
public class SrmController {
	
	@Inject
	private SrmService srmService;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=l")
	public String getSrmLayout(Model model, HttpServletRequest request) throws Exception {
		
		logger.debug("\nSRM Layout\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);

		return "/tg/srm/Srm";
	}
	
	@RequestMapping(params = "method=data")
	public @ResponseBody List<SrmDto> getSrmData() throws Exception {
		
		logger.debug("\nSRM datai1\n");
		
		return srmService.getTestData();
	}
	
	@RequestMapping(params = "method=test")
	public String test() throws Exception {
		return "/tg/srm/test";
	}
	
	@RequestMapping(params = "method=csLayout")
	public String getContextSwitchingLayout(HttpServletRequest request) throws Exception {
		return "/tg/srm/SrmContextSwitching";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=cs")
	public @ResponseBody List<Map<String, Object>> getContextSwitchingData(HttpServletRequest request) throws Exception {
		
		logger.debug("\nSRM ContextSwitching Data\n");
		
		return srmService.getSrmContextSwitchingData(RequestUtil.bindParameterToMap(request.getParameterMap()));
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=container")
	public String getSrmContainer(Model model, HttpServletRequest request) throws Exception {
		
		logger.debug("\nSRM Container\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("results", srmService.getSrmExistResult(parameterMap));
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return "/tg/srm/SrmContainer";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=layout")
	public String getSrmLayouts(Model model, HttpServletRequest request) throws Exception {
		
		logger.debug("\nSRM Layouts\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return request.getParameter("jsp");
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=CPU")
	public @ResponseBody List<Map<String, Object>> getSrmCPUData(HttpServletRequest request) throws Exception {
		
		logger.debug("\nSRM CPU Data\n");
		
		return srmService.getSrmCPUData(RequestUtil.bindParameterToMap(request.getParameterMap()));
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=process")
	public @ResponseBody List<Map<String, Object>> getSrmProcessData(HttpServletRequest request) throws Exception {
		
		logger.debug("\nSRM Process Data\n");
		
		return srmService.getSrmProcessData(RequestUtil.bindParameterToMap(request.getParameterMap()));
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=memory")
	public @ResponseBody List<Map<String, Object>> getSrmMemoryData(HttpServletRequest request) throws Exception {
		
		logger.debug("\nSRM Memory Data\n");
		
		return srmService.getSrmMemoryData(RequestUtil.bindParameterToMap(request.getParameterMap()));
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=network")
	public @ResponseBody List<Map<String, Object>> getSrmNetworkData(HttpServletRequest request) throws Exception {
		
		logger.debug("\nSRM Network Data\n");
		
		return srmService.getSrmNetworkData(RequestUtil.bindParameterToMap(request.getParameterMap()));
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=diskUsage")
	public @ResponseBody List<Map<String, Object>> getSrmDiskUsageData(HttpServletRequest request) throws Exception {
		
		logger.debug("\nSRM DiskUsage Data\n");
		
		return srmService.getSrmDiskUsageData(RequestUtil.bindParameterToMap(request.getParameterMap()));
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=diskIO")
	public @ResponseBody List<Map<String, Object>> getSrmDiskIOData(HttpServletRequest request) throws Exception {
		
		logger.debug("\nSRM DiskIO Data\n");
		
		return srmService.getSrmDiskIOData(RequestUtil.bindParameterToMap(request.getParameterMap()));
	}
}
