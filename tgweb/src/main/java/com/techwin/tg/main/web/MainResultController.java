package com.techwin.tg.main.web;

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
import com.techwin.tg.main.service.MainResultService;

@Controller
@RequestMapping("/tgMainResult.do")
public class MainResultController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	MainResultService mainResultService;

	@RequestMapping(params = RequestConstants.LIST)
	public String getMainResultList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\n메인 result 리스트\n");
		
		model.addAttribute("pageName", "Main Result");
		
		return "tgMainResult";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getMainResultList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\n메인 result 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, mainResultService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getMainResultExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\n메인 result export excel\n");
		
		List<Map<String, Object>> list = mainResultService.getMainResultExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
