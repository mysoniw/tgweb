package com.techwin.tg.srm.dto;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class SrmDto implements Serializable {

/*
 	[{
		"type": "CPU",	// i.e.: CPU, memory
		"cpu":[
			{"seq": 1, "value": 13},
			{"seq": 2, "value": 15},
			{"seq": 3, "value": 8},
			{"seq": 4, "value": 9},
			{"seq": 5, "value": 11}
		]
	},
	{
		"type": "memory",
		"memory":[
			{"seq": 1, "value": 13},
			{"seq": 2, "value": 15},
			{"seq": 3, "value": 8},
			{"seq": 4, "value": 9},
			{"seq": 5, "value": 11}
		]
	},
	{
		"type": "disk",
		"rows":[
			{"seq": 1, "value": 13},
			{"seq": 2, "value": 15},
			{"seq": 3, "value": 8},
			{"seq": 4, "value": 9},
			{"seq": 5, "value": 11}
		]
	}]
*/
	
	private static final long serialVersionUID = 2175245732832716197L;

	private String type;
	private List<Map<String, String>> rows;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public List<Map<String, String>> getRows() {
		return rows;
	}
	public void setRows(List<Map<String, String>> rows) {
		this.rows = rows;
	}
}
