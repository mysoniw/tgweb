package com.techwin.tg.common.web;

import java.io.File;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.techwin.common.constants.RequestConstants;
import com.techwin.common.util.RequestUtil;
import com.techwin.common.util.comparators.MapAlphanumComparator;
import com.techwin.tg.common.service.CommonService;

@Controller
@RequestMapping("/cmnCommon.do")
public class CommonController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	CommonService commonService;

	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.SELECT)
	public @ResponseBody List<Map<String, Object>> getSelect(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\ngetSelect\n");
		
		return commonService.getSelect(RequestUtil.bindParameterToMap(request.getParameterMap()));
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=testSuiteSelect")
	public @ResponseBody List<Map<String, Object>> getTestSuiteSelect(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\ngetTestSuiteSelect\n");
		
		return commonService.getTestSuiteSelect(RequestUtil.bindParameterToMap(request.getParameterMap()));
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=groupSelect")
	public @ResponseBody List<Map<String, Object>> getGroupSelect(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\ngetGroupSelect\n");
		
		List<Map<String, Object>> list = commonService.getGroupSelect(RequestUtil.bindParameterToMap(request.getParameterMap()));
		Collections.sort(list, new MapAlphanumComparator("id"));

		return list;
	}
	
	@RequestMapping(params = RequestConstants.IMAGE)
	public void vncPathImageTransfer(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String filePath = request.getParameter("filePath");
		
		if ("".equals(filePath)) {
//			filePath = (String)prop.getObject().get("noimage.file.path");
			filePath = request.getSession().getServletContext().getRealPath("/images/NoImageAvailable.jpg");
		}
		
		String type = filePath.substring(filePath.lastIndexOf(".") + 1, filePath.length());
		
		RequestUtil.outputImage(new File(filePath), type, response);
	}
}
