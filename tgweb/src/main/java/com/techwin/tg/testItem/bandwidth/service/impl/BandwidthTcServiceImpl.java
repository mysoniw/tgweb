package com.techwin.tg.testItem.bandwidth.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.apache.commons.collections.map.LRUMap;
import org.apache.commons.collections.map.MultiKeyMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.techwin.common.util.comparators.AlphanumComparator;
import com.techwin.common.util.model.BandwidthReportModel;
import com.techwin.common.util.model.ExportExcelUtilModel;
import com.techwin.tg.testItem.bandwidth.service.BandwidthTcService;

@Service("bandwidthTcService")
public class BandwidthTcServiceImpl implements BandwidthTcService {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	@Named("bandwidthTcDao")
	private BandwidthTcDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getBandwidthTcList(parameters);
	}
	
	public List<Map<String, Object>> getBandwidthTcExcel(Map<String, Object> parameters) throws Exception {
		return dao.getBandwidthTcExcel(parameters);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ExportExcelUtilModel getBandwidthTcReport(Map<String, Object> parameters) throws Exception {
		List<Map<String, Object>> list = dao.getBandwidthTcReport(parameters);
		
		List<String> xList = new ArrayList<String>();
		List<String> yList = new ArrayList<String>();
		List<String> zList = new ArrayList<String>();
		
		MultiKeyMap mkMap = new MultiKeyMap();
		
		String x = (String)parameters.get("x");
		String y = (String)parameters.get("y");
		String z = (String)parameters.get("z");
		
		for (Map<String, Object> map : list) {
			String xData = (String)map.get(parameters.get("x"));
			String yData = (String)map.get(parameters.get("y"));
			String zData = (String)map.get(parameters.get("z"));
			
			double value = ((Double)map.get("AVG_TRAFFIC")).doubleValue();
			mkMap.put(xData, yData, zData, value);
			
			if (!xList.contains(xData))	xList.add(xData);
			if (!yList.contains(yData))	yList.add(yData);
			if (!zList.contains(zData))	zList.add(zData);
		}
		
		Comparator comparator = new AlphanumComparator() {
			@Override
			public int compare(Object o1, Object o2) {
				return this.compareWithString(o1, o2);
			}
		};
		
		Collections.sort(xList, comparator);
		Collections.sort(yList, comparator);
		Collections.sort(zList, comparator);
		
		ExportExcelUtilModel model = new ExportExcelUtilModel();
		
		BandwidthReportModel bandwidthModel = new BandwidthReportModel();
		
		bandwidthModel.setX(x);
		bandwidthModel.setY(y);
		bandwidthModel.setZ(z);
		bandwidthModel.setxList(xList);
		bandwidthModel.setyList(yList);
		bandwidthModel.setzList(zList);
		
		bandwidthModel.setDataMap(mkMap);
		
		model.setBandwidthReportModel(bandwidthModel);
		model.setBodyDataList(list);
		
		return model;
	}
}
