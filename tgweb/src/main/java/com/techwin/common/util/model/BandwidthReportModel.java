package com.techwin.common.util.model;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.collections.map.MultiKeyMap;

public class BandwidthReportModel implements Serializable {

	private static final long serialVersionUID = -5531367514975672523L;

	public static final int DEFAULT_CELL_INDEX = 3;
	
	private String x;
	private String y;
	private String z;
	
	private List<String> xList;
	private List<String> yList;
	private List<String> zList;
	private MultiKeyMap dataMap;
	
	public String getX() {
		return x;
	}
	public void setX(String x) {
		this.x = x;
	}
	public String getY() {
		return y;
	}
	public void setY(String y) {
		this.y = y;
	}
	public String getZ() {
		return z;
	}
	public void setZ(String z) {
		this.z = z;
	}
	public List<String> getxList() {
		return xList;
	}
	public void setxList(List<String> xList) {
		this.xList = xList;
	}
	public List<String> getyList() {
		return yList;
	}
	public void setyList(List<String> yList) {
		this.yList = yList;
	}
	public List<String> getzList() {
		return zList;
	}
	public void setzList(List<String> zList) {
		this.zList = zList;
	}
	public MultiKeyMap getDataMap() {
		return dataMap;
	}
	public void setDataMap(MultiKeyMap dataMap) {
		this.dataMap = dataMap;
	}
}
