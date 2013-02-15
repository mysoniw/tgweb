package com.techwin.tg.main.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.tg.main.service.MainFwService;
import com.techwin.tg.testItem.DST.service.impl.DSTTcDao;
import com.techwin.tg.testItem.PTZ.command.service.impl.PtzTcDao;
import com.techwin.tg.testItem.PTZ.protocol.service.impl.Rs485TcDao;
import com.techwin.tg.testItem.bandwidth.service.impl.BandwidthTcDao;
import com.techwin.tg.testItem.image.imageConfirm.service.impl.ImageConfirmTcDao;
import com.techwin.tg.testItem.image.viewLatency.service.impl.ViewLatencyTcDao;
import com.techwin.tg.testItem.multimedia.liveStream.service.impl.LiveStreamTcDao;
import com.techwin.tg.testItem.multimedia.searchStream.service.impl.SearchStreamTcDao;
import com.techwin.tg.testItem.web.service.impl.WebTcDao;

@Service("mainFwService")
public class MainFwServiceImpl implements MainFwService {
	
	@Inject
	@Named("mainFwDao")
	private MainFwDao dao;

	@Inject
	private SearchStreamTcDao searchStreamTcDao;
	@Inject
	private LiveStreamTcDao liveStreamTcDao;
	@Inject
	private BandwidthTcDao bandwidthTcDao;
	@Inject
	private ImageConfirmTcDao imageConfirmTcDao;
	@Inject
	private ViewLatencyTcDao viewLatencyTcDao;
	@Inject
	private WebTcDao webTcDao;
	@Inject
	private Rs485TcDao rs485TcDao;
	@Inject
	private PtzTcDao ptzTcDao;
	@Inject
	private DSTTcDao dstTcDao;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getMainFwList(parameters);
	}
	
	public List<Map<String, Object>> getMainFwExcel(Map<String, Object> parameters) throws Exception {
		return dao.getMainFwExcel(parameters);
	}
	
	public Map<String, List<Map<String, Object>>> getMainFwExcelReport(Map<String, Object> parameters) throws Exception {
		
		List<Map<String, Object>> list = dao.getMainFwExcel(parameters);
		
		Map<String, List<Map<String, Object>>> returnMap = new LinkedHashMap<String, List<Map<String, Object>>>();
		
		returnMap.put("Main", list);
		
		for (Map<String, Object> map : list) {
			String testProjectId = (String)map.get("TEST_PROJECT_ID");
			
			switch(testProjectId) {
			case "SEARCH_STREAM":
				returnMap.put("SEARCH_STREAM", searchStreamTcDao.getSearchStreamTcExcel(parameters));
				break;
			case "LIVE_STREAM":
				if (!returnMap.containsKey("LIVE_STREAM")) {
					returnMap.put("LIVE_STREAM", liveStreamTcDao.getLiveStreamTcExcel(parameters));
				}
				break;
			case "BANDWIDTH":
				returnMap.put("BANDWIDTH", bandwidthTcDao.getBandwidthTcExcel(parameters));
				break;
			case "IMAGE_CONFIRM":
				returnMap.put("IMAGE_CONFIRM", imageConfirmTcDao.getImageConfirmTcExcel(parameters));
				break;
			case "VIEW_LATENCY":
				returnMap.put("VIEW_LATENCY", viewLatencyTcDao.getViewLatencyTcExcel(parameters));
				break;
			case "WEB":
				returnMap.put("WEB", webTcDao.getWebTcExcel(parameters));
				break;
			case "LIVE_STREAM_WEB":
				if (!returnMap.containsKey("LIVE_STREAM")) {
					returnMap.put("LIVE_STREAM", liveStreamTcDao.getLiveStreamTcExcel(parameters));
				}
				break;
			case "RS_485":
				returnMap.put("RS_485", rs485TcDao.getRs485TcExcel(parameters));
				break;
			case "PTZ":
				returnMap.put("PTZ", ptzTcDao.getPtzTcExcel(parameters));
				break;
			case "DST":
				returnMap.put("DST", dstTcDao.getDSTTcExcel(parameters));
				break;
			}
		}
		
		return returnMap;
	}
}
