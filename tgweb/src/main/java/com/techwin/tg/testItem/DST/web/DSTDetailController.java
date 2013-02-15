package com.techwin.tg.testItem.DST.web;

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

import com.techwin.common.constants.RequestConstants;
import com.techwin.common.util.ExportExcelUtil;
import com.techwin.common.util.RequestUtil;
import com.techwin.tg.testItem.DST.service.DSTDetailService;

@Controller
@RequestMapping("/tgDSTDetail.do")
public class DSTDetailController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	DSTDetailService dstDetailService;
	
//	@Inject
//	PropertiesFactoryBean prop;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.TAB)
	public String getDSTDetailTab(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nDST detail 탭\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		model.addAttribute("_wid", request.getParameter("_wid"));
		
		model.addAttribute("results", dstDetailService.getDSTDetailTab(parameterMap));
		
		model.addAttribute("params", parameterMap);
		
		return "/tg/testItem/DST/DSTDetail";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.EXCEL)
	public void getDSTDetailExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nDST detail export excel\n");
		
		List<Map<String, Object>> list = dstDetailService.getDSTDetailExcel(RequestUtil.bindParameterToMap(request.getParameterMap()));
		ExportExcelUtil.exportExcelByKey(request, response, list);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.IMAGE)
	public void vncPathImageTransfer(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		String filePath = (String)parameterMap.get("filePath");
		
		if ("".equals(filePath)) {
//			filePath = (String)prop.getObject().get("noimage.file.path");
			filePath = request.getSession().getServletContext().getRealPath("/" + "images\\NoImageAvailable.jpg");
		}
		
//		logger.debug("filePath {}", filePath);
		
		String type = filePath.substring(filePath.lastIndexOf(".") + 1, filePath.length());
		
		RequestUtil.outputImage(new File(filePath), type, response);
	}
}
