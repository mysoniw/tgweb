package com.techwin.admin.common.web;

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

import com.techwin.admin.common.service.CommonService;
import com.techwin.common.constants.RequestConstants;
import com.techwin.common.util.RequestUtil;

@Controller("adminCommonController")
@RequestMapping("/adminCommon.do")
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
}
