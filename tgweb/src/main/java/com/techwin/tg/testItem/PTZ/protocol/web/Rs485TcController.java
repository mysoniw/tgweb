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
import com.techwin.tg.testItem.PTZ.protocol.service.Rs485TcService;

@Controller
@RequestMapping("/tgRs485Tc.do")
public class Rs485TcController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	Rs485TcService rs485TcService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.LIST)
	public String getRs485TcList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nrs485 TC 리스트\n");

		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		model.addAttribute("params", parameterMap);
		
		return "tgRs485Tc";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getRs485TcTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nrs485 TC 리스트(탭)\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return "/tg/testItem/PTZ/protocol/Rs485Tc";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getRs485TcList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nrs485 TC 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, rs485TcService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getRs485TcExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nrs485 TC export excel\n");
		
		List<Map<String, Object>> list = rs485TcService.getRs485TcExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
