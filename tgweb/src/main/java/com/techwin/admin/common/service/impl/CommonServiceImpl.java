package com.techwin.admin.common.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.admin.common.service.CommonService;

@Service("adminCommonService")
public class CommonServiceImpl implements CommonService {
	
	@Inject
	@Named("adminCommonDao")
	private CommonDao dao;
	
	public List<Map<String, Object>> getSelect(Map<String, Object> parameters) throws Exception {
		return dao.getSelect(parameters);
	}
}
