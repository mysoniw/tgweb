package com.techwin.common.exception;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

public class TgHandlerExceptionResolver implements HandlerExceptionResolver {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
		Map<String, String> map = new HashMap<String, String>();
		
		if (ex instanceof MaxUploadSizeExceededException) {
			logger.debug("Resolving exception from handler [{}]: {}", handler, ex);
			map.put("error_msg", "upload file size exceeded (max 100MB)");
			return new ModelAndView("jsonView", map);
		} else {
			return null;
		}
	}
}
