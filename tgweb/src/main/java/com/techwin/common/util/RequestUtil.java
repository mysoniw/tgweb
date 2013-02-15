package com.techwin.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.parser.ContainerFactory;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;

import com.techwin.common.json.JqGridMapper;
import com.techwin.common.service.Gridable;
import com.techwin.common.util.comparators.MapAlphanumComparator;

public class RequestUtil {
	
	private final static Logger logger = LoggerFactory.getLogger(RequestUtil.class);
	
	public static Map<String, Object> bindParameterToMap(Map<String, String[]> requestParameters) {
		Map<String, Object> bindParameterMap = new LinkedHashMap<String, Object>();

		if (requestParameters != null && !requestParameters.isEmpty()) {
			for (String parameter : requestParameters.keySet()) {
				String[] values = requestParameters.get(parameter);

				if (values.length > 1) {
					bindParameterMap.put(parameter, values);
				} else {
					bindParameterMap.put(parameter, values[0]);
				}
			}
		}

		return bindParameterMap;
	}
	
	public static <T> void responseWithJson(HttpServletResponse response, Map<String, T> map) throws Exception {
		response.setHeader("Content-Type", "text/html; charset=utf-8");
		response.getWriter().print(JSONUtil.toJSON(map));
		response.getWriter().flush();
		response.getWriter().close();
	}
	
	public static <T> void responseWithJson(HttpServletResponse response, List<Map<String, T>> list) throws Exception {
		response.setHeader("Content-Type", "text/html; charset=utf-8");
		response.getWriter().print(JSONUtil.toJSON(list));
		response.getWriter().flush();
		response.getWriter().close();
	}
	
	public static void outputImage(File thumbfile, String type, HttpServletResponse response) throws IOException {
		// fix mime type (jpg format)
		if ("jpg".equals(type))		type = "jpeg";
		
		response.setContentType("image/" + type);
		OutputStream os = response.getOutputStream();
		FileInputStream fin = new FileInputStream(thumbfile);

		byte[] buf = new byte[4096];
		int count = 0;
		while (true) {
			int n = fin.read(buf);
			if (n == -1) {
				break;
			}
			count = count + n;
			os.write(buf, 0, n);
		}
		os.flush();
		os.close();
		fin.close();
		
//		logger.debug("outputImage method finished.....type {}", type);
	}
	
	@SuppressWarnings("unchecked")
	public static <T> Map<String, T> jsonToList(String jsonString) throws Exception {
		
		JSONParser parser = new JSONParser();
		Map<String, T> map = null;
		
		ContainerFactory containerFactory = new ContainerFactory() {
			public List<T> creatArrayContainer() {
				return new LinkedList<T>();
			}
			public Map<String, T> createObjectContainer() {
				return new LinkedHashMap<String, T>();
			}
		};
		map = (Map<String, T>)parser.parse(jsonString, containerFactory);
		
		return map;
	}
	
	/**
	 * 
	 * @param HttpServletRequest request
	 * @param Gridable service
	 * @return JqGridMapper
	 * @throws Exception
	 * 
	 * JqGrid json객체를 만들기 위한 method
	 * 
	 */
	@SuppressWarnings("unchecked")
	public static JqGridMapper generateJqGridResponse(HttpServletRequest request, Gridable service) throws Exception {
		Map<String, Object> requestMap = (Map<String, Object>)RequestUtil.bindParameterToMap(request.getParameterMap());
		
		JqGridMapper mapper = new JqGridMapper();
		
		int page = 1;
		int limit = 1;
		
		int count = 0;
		int totalPage = 0;
		
		List<Map<String, Object>> row = new ArrayList<Map<String, Object>>();

		if (requestMap.containsKey("page"))		page = Integer.parseInt((String)requestMap.get("page"));
		if (requestMap.containsKey("rows"))		limit = Integer.parseInt((String)requestMap.get("rows"));
		
		requestMap.put("page", page);
		requestMap.put("limit", limit);
		
		List<Map<String, Object>> list = service.getGridList(requestMap);
		
		// order by Alphabet, Number Comparator
		if (requestMap.get("sidx") != null && !"ROWNUM".equals(requestMap.get("sidx"))) {
			if (requestMap.get("sord") != null && "asc".equals(requestMap.get("sord"))) {
				Collections.sort(list, new MapAlphanumComparator(requestMap.get("sidx").toString()));
			} else {
				Collections.sort(list, Collections.reverseOrder(new MapAlphanumComparator(requestMap.get("sidx").toString())));
			}
		}
		
		if (list.size() > 0) {
			count = (Integer)list.get(0).get("totalCount");
			
			if (count > 0)	totalPage = (int)Math.ceil(count / (double)limit);
			
			Iterator<Map<String, Object>> it = list.iterator();
			
			while (it.hasNext()) {
				Map<String, Object> map = it.next();
				Map<String, Object> cell = new HashMap<String, Object>();
				Iterator<Entry<String, Object>> entrySet = map.entrySet().iterator();
				while (entrySet.hasNext()) {
					Map.Entry<String, Object> entry = (Map.Entry<String, Object>)entrySet.next();
					
					cell.put(entry.getKey().toString(), entry.getValue());
				}
				
				row.add(cell);
			}
		}
		
		mapper.setPage(page);
		mapper.setTotal(totalPage);
		mapper.setRecords(count);
		mapper.setRows(row);
		
//		ModelAndView modelAndView = new ModelAndView("jsonView");
//		modelAndView.addObject(mapper);
		
		return mapper;
	}
}
