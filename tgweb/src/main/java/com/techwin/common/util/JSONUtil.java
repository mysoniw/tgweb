package com.techwin.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.anyframe.util.StringUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

@SuppressWarnings({ "unchecked", "rawtypes" })
public class JSONUtil {
	public static Object toJSON(Object object) {

		Object obj = object;
		if (null == obj) {
			obj = new HashMap();
		}

		if (obj instanceof Map) {
			return toJSON((Map)obj);

		} else if (obj instanceof List) { return toJSONArray((List)obj); }

		return obj;
	}

	public static JSONArray toJSONArray(List list) {

		List lst = list;
		if (null == lst) {
			lst = new ArrayList();
		}

		JSONArray jsonArray = new JSONArray();

		for (Iterator iterator = lst.iterator(); iterator.hasNext();) {
			jsonArray.add(toJSON(iterator.next()));
		}

		return jsonArray;
	}

	public static JSONArray toJSONArrayObjList(Object[] objList) {
		JSONArray jsonArray = new JSONArray();
		List lst = null;
		for (int i = 0; i < objList.length; i++) {
			lst = (List)objList[i];
			if (null == lst) {
				lst = new ArrayList();
			}
			for (Iterator iterator = lst.iterator(); iterator.hasNext();) {
				jsonArray.add(toJSON(iterator.next()));
			}
		}

		return jsonArray;
	}

	public static JSONObject toJSON(Map map) {
		Map paramMap = map;
		if (null == paramMap) {
			paramMap = new HashMap();
		}

		JSONObject json = new JSONObject();

		for (Iterator keys = paramMap.keySet().iterator(); keys.hasNext();) {

			String key = (String)keys.next();

			Object o = paramMap.get(key);
			if (null == o) {
				o = "";
			}
			json.put(key, toJSON(o));
		}
		return json;
	}

	public static List<Map<String, Object>> convertJsonToList(String json) throws Exception {
		List<Map<String, Object>> result = new ArrayList();
		if ("".equals(StringUtil.null2str(json).trim())) { return result; }
		JSONParser parser = new JSONParser();
		List<Map<String, Object>> objList = (ArrayList)parser.parse(json);
		int len = objList.size();

		for (int i = 0; i < len; i++) {
			Map<String, Object> map = (Map)objList.get(i);
			Map<String, Object> resultMap = new LinkedHashMap();
			for (Iterator keys = map.keySet().iterator(); keys.hasNext();) {

				String key = (String)keys.next();

				Object o = map.get(key);
				if (null == o) {
					o = "";
				}
				resultMap.put(key, o);
			}
			result.add(resultMap);
		}

		return result;
	}
}
