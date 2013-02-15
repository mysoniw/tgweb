package com.techwin.tg.testItem.bandwidth.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.techwin.common.util.comparators.ChainedComparator;
import com.techwin.common.util.comparators.MapAlphanumComparator;
import com.techwin.common.util.model.ExportExcelUtilModel;
import com.techwin.tg.testItem.bandwidth.service.BandwidthMainService;

@Service("bandwidthMainService")
public class BandwidthMainServiceImpl implements BandwidthMainService {
	
//	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	@Named("bandwidthMainDao")
	private BandwidthMainDao dao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getBandwidthMainList(parameters);
	}
	
	public List<Map<String, Object>> getBandwidthMainExcel(Map<String, Object> parameters) throws Exception {
		return dao.getBandwidthMainExcel(parameters);
	}
	
	@Deprecated
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<ExportExcelUtilModel> getBandwidthMainExcelReport(Map<String, Object> parameters) throws Exception {
		
		List<Map<String, Object>> list = dao.getBandwidthMainExcelReport(parameters);
		
		if (list.size() < 1)	return null;

		Map<String, int[]> hiddenColumnMap = new HashMap<String, int[]>();
		hiddenColumnMap.put("NCAM", new int[] {3,4,5,6,7});
		hiddenColumnMap.put("NVR", new int[] {3,4,5,6,7});
		hiddenColumnMap.put("DVR", new int[] {3,4,5,6,7});
		
		Map<String, int[][]> seriesMap = new HashMap<String, int[][]>();
		seriesMap.put("NCAM", new int[][] {{17,2,18,21},{8,3,8,21},{9,3,9,21},{10,3,10,21}});
		seriesMap.put("NVR", new int[][] {{16,2,17,21},{8,3,8,21},{9,3,9,21},{10,3,10,21}});
		seriesMap.put("DVR", new int[][] {{15,2,16,21},{8,3,8,21},{9,3,9,21},{10,3,10,21}});
		
		
		// test suite id별, resolution별, bitrate별 sorting
		Collections.sort(list, new ChainedComparator(new MapAlphanumComparator("TEST_SUITE_ID"), new MapAlphanumComparator("Resolution"), new MapAlphanumComparator("Bitrate"), new MapAlphanumComparator("Framerate")));
		
		List<ExportExcelUtilModel> modelList = new ArrayList<ExportExcelUtilModel>();
		ExportExcelUtilModel model = null;
		
		String previousSuite = null;
		String previousResolution = null;
		
		List<Map<String, Object>> returnList = null;
		
		for (Map<String, Object> map : list) {
			// 이전 suiteId가 null이 아니고 이전 suiteId가 현재 suiteId와 같다면 true (초기값 : false)
			boolean flagSuite = (previousSuite != null ? ((String)map.get("TEST_SUITE_ID")).equals(previousSuite) : false);
			// 이전 resolution이 null이 아니고 이전 resolution이 현재 resolution와 같다면 true (초기값 : false)
			boolean flagRes = (previousResolution != null ? ((String)map.get("Resolution")).equals(previousResolution): false);
			
			// suiteId가 이전과 틀리거나 suiteId는 같으나 resolution이 틀리면 (초기값 : true)
			if (!flagSuite || (flagSuite && !flagRes)) {
				// loop의 처음이 아닌 경우 (초기값 :false)
				if (previousSuite != null) {
					
					model = new ExportExcelUtilModel();
					
					model.setBodyDataList(returnList);
					model.setSheetTitle(makeSheetName((Map<String, Object>)returnList.get(0)));
					model.setHiddenColumn(hiddenColumnMap.get(((Map<String, Object>)returnList.get(0)).get("Category")));					
					model.setChartSeries(seriesMap.get(((Map<String, Object>)returnList.get(0)).get("Category")));
					modelList.add(model);
				}
				returnList = new ArrayList<Map<String, Object>>();
			}
			returnList.add(map);
			
			
			previousSuite = (String)map.get("TEST_SUITE_ID");
			previousResolution = (String)map.get("Resolution");
		}
		
		model = new ExportExcelUtilModel();

		model.setBodyDataList(returnList);
		model.setSheetTitle(makeSheetName((Map<String, Object>)returnList.get(0)));
		model.setHiddenColumn(hiddenColumnMap.get(((Map<String, Object>)returnList.get(0)).get("Category")));					
		model.setChartSeries(seriesMap.get(((Map<String, Object>)returnList.get(0)).get("Category")));
		modelList.add(model);
		
		
		return modelList;
	}

	@Deprecated
	private String makeSheetName(Map<String, Object> resultMap) {
		
		final String SEPARATOR = "_";
		
		String testSuiteId = (String)resultMap.get("TEST_SUITE_ID");
		String[] tempArr = testSuiteId.split(SEPARATOR);
		int taSize = tempArr.length;
		
		if (taSize < 2) {
			throw new RuntimeException("TEST_SUITE_ID is unexpected format : " + testSuiteId);
		}
		
		List<String> list = new ArrayList<String>();
		
		list.add((String)resultMap.get("Encoding"));	// encoding
		if ("profile".contains(testSuiteId.toLowerCase())) {
			list.add((String)resultMap.get("Bit Control"));	// bit control
		}
		list.add(tempArr[taSize - 2]);	// suiteId's piece (1)		e.g. profile, framerate
		list.add(tempArr[taSize - 1]);	// suiteId's piece (2)		e.g. TC version
		list.add((String)resultMap.get("Resolution"));	// resolution
		
		return StringUtils.join(list, SEPARATOR);
	}
}
