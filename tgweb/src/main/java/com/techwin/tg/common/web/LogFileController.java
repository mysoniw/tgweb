package com.techwin.tg.common.web;

import java.io.File;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.techwin.common.util.RequestUtil;
import com.techwin.tg.common.service.LogFileService;

@Controller
public class LogFileController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	LogFileService logFileService;

	@SuppressWarnings("unchecked")
	@RequestMapping("/cmnLogFile.do")
	public ModelAndView getLogFileFullPath(Map<String, Object> map, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		logger.debug("\nLogFile Download\n");
		map = logFileService.getLogFileFullPath(RequestUtil.bindParameterToMap(request.getParameterMap()));
		
		File file = new File((String)map.get("FULL_PATH"));
		return new ModelAndView("download", "downloadFile", file);
	}
}
