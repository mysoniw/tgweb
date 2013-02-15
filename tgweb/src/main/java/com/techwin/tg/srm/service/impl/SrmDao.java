package com.techwin.tg.srm.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;
import com.techwin.tg.srm.dto.SrmDto;

@Repository
public class SrmDao extends TgWebDao {

	public List<SrmDto> getTestData() {
		
		
		String[] srmMembers = {"CPU", "memory", "disk"};
		List<SrmDto> retList = new ArrayList<SrmDto>();
		
		
		for (String member : srmMembers) {
			
			SrmDto dto = new SrmDto();
			
			dto.setType(member);
			List<Map<String, String>> list = new ArrayList<Map<String, String>>();
			
			for (int i = 0; i < 10; i++) {
				Map<String, String> map = new HashMap<String, String>();
				
				int ran = (int)(Math.random() * 10 + 1);
				
				map.put("seq", String.valueOf(i));
				map.put("value", String.valueOf(ran));
				list.add(map);
			}
			
			dto.setRows(list);
			
			retList.add(dto);
		}
		
		return retList;
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> getSrmExistResult(Map<String, Object> parameters) throws Exception {
		return (Map<String, Object>)super.findByPk("SrmDao.findExist", parameters);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSrmCPUData(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SrmDao.findCPU", parameters);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSrmProcessData(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SrmDao.findProcess", parameters);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSrmMemoryData(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SrmDao.findMemory", parameters);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSrmNetworkData(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SrmDao.findNetwork", parameters);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSrmDiskUsageData(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SrmDao.findDiskUsage", parameters);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSrmDiskIOData(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SrmDao.findDiskIO", parameters);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getSrmCotnextSwitchingData(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("SrmDao.findContextSwitching", parameters);
	}
}
