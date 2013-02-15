package com.techwin.tg.testItem.bandwidth.service;

import java.util.List;
import java.util.Map;

import com.techwin.common.service.Gridable;
import com.techwin.common.util.model.ExportExcelUtilModel;

public interface BandwidthTcService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getBandwidthTcExcel(Map<String, Object> parameters) throws Exception;

	public ExportExcelUtilModel getBandwidthTcReport(Map<String, Object> parameters) throws Exception;
}
