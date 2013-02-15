package com.techwin.tg.srm.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.techwin.tg.srm.dto.SrmDto;
import com.techwin.tg.srm.service.SrmService;

@Service("srmService")
public class SrmServiceImpl implements SrmService {

	@Inject
	private SrmDao srmDao;

	@Override
	public List<SrmDto> getTestData() {
		return srmDao.getTestData();
	}
	
	@Override
	public Map<String, Object> getSrmExistResult(Map<String, Object> parameters) throws Exception {
		return srmDao.getSrmExistResult(parameters);
	}
	
	@Override
	public List<Map<String, Object>> getSrmCPUData(Map<String, Object> parameters) throws Exception {
		return srmDao.getSrmCPUData(parameters);
	}

	@Override
	public List<Map<String, Object>> getSrmProcessData(Map<String, Object> parameters) throws Exception {
		return srmDao.getSrmProcessData(parameters);
	}

	@Override
	public List<Map<String, Object>> getSrmMemoryData(Map<String, Object> parameters) throws Exception {
		return srmDao.getSrmMemoryData(parameters);
	}

	@Override
	public List<Map<String, Object>> getSrmNetworkData(Map<String, Object> parameters) throws Exception {
		return srmDao.getSrmNetworkData(parameters);
	}

	@Override
	public List<Map<String, Object>> getSrmDiskUsageData(Map<String, Object> parameters) throws Exception {
		return srmDao.getSrmDiskUsageData(parameters);
	}

	@Override
	public List<Map<String, Object>> getSrmDiskIOData(Map<String, Object> parameters) throws Exception {
		return srmDao.getSrmDiskIOData(parameters);
	}
	
	@Override
	public List<Map<String, Object>> getSrmContextSwitchingData(Map<String, Object> parameters) throws Exception {
		return srmDao.getSrmCotnextSwitchingData(parameters);
	}
}
