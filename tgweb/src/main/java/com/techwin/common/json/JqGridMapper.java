package com.techwin.common.json;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class JqGridMapper implements Serializable {

/*
 	{
		"total":5,
		"page":1,
		"records":5,
		"rows":[
			{"id":1,"cell":[1,"NCAM","NCAM_1","0.5"]},
			{"id":2,"cell":[2,"NCAM","NCAM_1","0.5"]},
			{"id":3,"cell":[3,"NCAM","NCAM_1","0.5"]},
			{"id":4,"cell":[4,"ACAM","ACAM_1","0.4"]},
			{"id":5,"cell":[5,"NCAM","NCAM_1","0.5"]}
		]
	}
*/
	
	private static final long serialVersionUID = -2787156778320431078L;
	private int total;
	private int page;
	private int records;
	private List<Map<String, Object>> rows;
	
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRecords() {
		return records;
	}
	public void setRecords(int records) {
		this.records = records;
	}
	public List<Map<String, Object>> getRows() {
		return rows;
	}
	public void setRows(List<Map<String, Object>> rows) {
		this.rows = rows;
	}
}
