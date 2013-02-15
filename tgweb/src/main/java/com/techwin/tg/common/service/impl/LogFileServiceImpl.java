package com.techwin.tg.common.service.impl;

import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.common.service.LogFileService;

@Service("logFileService")
public class LogFileServiceImpl implements LogFileService {
	
	@Inject
	@Named("logFileDao")
	private LogFileDao dao;

	public Map<String, Object> getLogFileFullPath(Map<String, Object> parameters) throws Exception {
		return dao.getLogFileFullPath(parameters);
	}
}
