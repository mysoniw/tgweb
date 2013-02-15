package com.techwin.support.web;

import java.io.File;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.techwin.common.constants.RequestConstants;
import com.techwin.common.json.JqGridMapper;
import com.techwin.common.util.RequestUtil;
import com.techwin.support.service.DownloadService;

@Controller
@RequestMapping("/supDownload.do")
public class DownloadController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	DownloadService downloadService;
	
	@Inject
	protected PropertiesFactoryBean prop;

	@RequestMapping(params = RequestConstants.LIST)
	public String getDownloadList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\ndownload 리스트\n");
		
		return "supDownload";
	}

	@RequestMapping(params = RequestConstants.SEARCH)
	public @ResponseBody JqGridMapper getDownloadList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\ndownload 리스트 검색\n");
		
		return RequestUtil.generateJqGridResponse(request, downloadService);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.UPDATE_PROCESS)
	public void updateDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\ndownload 리스트 수정\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
	
		if ("edit".equals(parameterMap.get("oper"))) {
			downloadService.updateDownload(parameterMap, (MultipartHttpServletRequest)request);
		} else if ("del".equals(parameterMap.get("oper"))) {
			downloadService.deleteDownload(parameterMap);
		} else {
			downloadService.createDownload(parameterMap, (MultipartHttpServletRequest)request);
		}
		
		//return RequestUtil.generateJqGridResponse(request, userManagementService);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.FILE)
	public ModelAndView getFileFullPath(Map<String, Object> map, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		logger.debug("\nFile Download\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		map = downloadService.getFileFullPath(parameterMap);
		
		File file = new File(prop.getObject().getProperty("support.file.path") + "/" + (String)map.get("SVR_FILE_NAME"));
		
		ModelAndView mv = new ModelAndView("download", "downloadFile", file);
		mv.addObject("FILE_NAME", map.get("FILE_NAME"));
		
		return mv;
	}
}
