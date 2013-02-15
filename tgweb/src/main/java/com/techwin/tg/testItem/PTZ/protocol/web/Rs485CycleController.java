package com.techwin.tg.testItem.PTZ.protocol.web;

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
import com.techwin.tg.testItem.PTZ.protocol.service.Rs485CycleService;

@Controller
@RequestMapping("/tgRs485Cycle.do")
public class Rs485CycleController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	Rs485CycleService rs485CycleService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getRs485CycleTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nRS-485 cycle 탭\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return "/tg/testItem/PTZ/protocol/Rs485Cycle";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getRs485CycleList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nRS-485 cycle 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, rs485CycleService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getRs485CycleExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nRS-485 cycle export excel\n");
		
		List<Map<String, Object>> list = rs485CycleService.getRs485CycleExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
