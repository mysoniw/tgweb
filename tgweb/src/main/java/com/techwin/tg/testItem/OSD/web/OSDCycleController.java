package com.techwin.tg.testItem.OSD.web;

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
import com.techwin.tg.testItem.OSD.service.OSDCycleService;

@Controller
@RequestMapping("/tgOSDCycle.do")
public class OSDCycleController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	OSDCycleService osdCycleService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getOSDCycleTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nOSD cycle 탭\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return "/tg/testItem/OSD/OSDCycle";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getOSDCycleList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nOSD cycle 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, osdCycleService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getOSDCycleExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nOSD cycle export excel\n");
		
		List<Map<String, Object>> list = osdCycleService.getOSDCycleExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
