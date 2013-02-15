package com.techwin.tg.testItem.image.imageConfirm.web;

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
import com.techwin.tg.testItem.image.imageConfirm.service.ImageConfirmMainService;

@Controller
@RequestMapping("/tgImageConfirmMain.do")
public class ImageConfirmMainController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	private ImageConfirmMainService imageConfirmMainService;

	@RequestMapping(params = RequestConstants.LIST)
	public String getImageConfirmMainList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nImageConfirm 메인 리스트\n");

		model.addAttribute("isWeb", request.getParameter("isWeb"));

		return "tgImageConfirmMain";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getImageConfirmMainTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nImageConfirm 메인 리스트(탭)\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());

		model.addAttribute("isWeb", request.getParameter("isWeb"));
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return "/tg/testItem/image/imageConfirm/ImageConfirmMain";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getImageConfirmMainList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nImageConfirm 메인 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, imageConfirmMainService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getImageConfirmMainExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nImageConfirm 메인 export excel\n");
		
		List<Map<String, Object>> list = imageConfirmMainService.getImageConfirmMainExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
