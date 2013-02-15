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
import com.techwin.tg.testItem.image.imageConfirm.service.ImageConfirmTcService;

@Controller
@RequestMapping("/tgImageConfirmTc.do")
public class ImageConfirmTcController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	private ImageConfirmTcService imageConfirmTcService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.LIST)
	public String getImageConfirmTcList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nImageConfirm TC 리스트\n");

		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		model.addAttribute("params", parameterMap);
		
		return "tgImageConfirmTc";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getImageConfirmTcTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nImageConfirm TC 리스트(탭)\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);
		
		return "/tg/testItem/image/imageConfirm/ImageConfirmTc";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getImageConfirmTcList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nImageConfirm TC 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, imageConfirmTcService);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getImageConfirmTcExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nImageConfirm TC export excel\n");
		
		List<Map<String, Object>> list = imageConfirmTcService.getImageConfirmTcExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
