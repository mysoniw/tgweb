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

import com.techwin.common.constants.RequestConstants;
import com.techwin.common.util.ExportExcelUtil;
import com.techwin.common.util.RequestUtil;
import com.techwin.tg.testItem.image.imageConfirm.service.ImageConfirmDetailService;

@Controller
@RequestMapping("/tgImageConfirmDetail")
public class ImageConfirmDetailController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	private ImageConfirmDetailService imageConfirmDetailService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getImageConfirmDetailTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nImageConfirm detail 탭\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		model.addAttribute("params", parameterMap);

		List<Map<String, Object>> retList = imageConfirmDetailService.getImageConfirmDetail(parameterMap);

		model.addAttribute("entryList", retList);

		return "/tg/testItem/image/imageConfirm/ImageConfirmDetail";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getImageConfirmDetailExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nImageConfirm detail export excel\n");
		
		List<Map<String, Object>> list = imageConfirmDetailService.getImageConfirmDetailExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
}
