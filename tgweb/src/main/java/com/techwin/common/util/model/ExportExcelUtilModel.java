package com.techwin.common.util.model;

import java.io.File;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class ExportExcelUtilModel implements Serializable {

	private static final long serialVersionUID = 349069466061884269L;
	
	public static final int TITLE_ROW_INDEX = 0;
	
	public static final int HEAD_INFO_KEY_CELL_INDEX = 0;
	public static final int HEAD_INFO_VALUE_CELL_INDEX = 1;
	
	private static final int DEFAULT_ROW_POSITION = 2;
	
	private String title;
	private String sheetTitle;
	private int sheetIndex = 0;
	private int rowPos = DEFAULT_ROW_POSITION;
	private int[] hiddenColumn = {};
	private Map<String, String> columnNameMap;
	private Map<String, Object> headInfoData;
	private List<Map<String, Object>> bodyDataList;
	
	private File templateFile;
	private int[][] chartSeries;
	
	private BandwidthReportModel bandwidthReportModel;

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSheetTitle() {
		return sheetTitle;
	}
	public void setSheetTitle(String sheetTitle) {
		this.sheetTitle = sheetTitle;
	}
	public int getSheetIndex() {
		return sheetIndex;
	}
	public void setSheetIndex(int sheetIndex) {
		this.sheetIndex = sheetIndex;
	}
	// auto increment
	public int getRowPos() {
		return rowPos++;
	}
	public void setDefaultRowPos() {
		this.rowPos = DEFAULT_ROW_POSITION;
	}
	public int[] getHiddenColumn() {
		return hiddenColumn;
	}
	public void setHiddenColumn(int[] hiddenColumn) {
		this.hiddenColumn = hiddenColumn;
	}
	public Map<String, String> getColumnNameMap() {
		return columnNameMap;
	}
	public void setColumnNameMap(Map<String, String> columnNameMap) {
		this.columnNameMap = columnNameMap;
	}
	public Map<String, Object> getHeadInfoData() {
		return headInfoData;
	}
	public void setHeadInfoData(Map<String, Object> headInfoData) {
		this.headInfoData = headInfoData;
	}
	public List<Map<String, Object>> getBodyDataList() {
		return bodyDataList;
	}
	public void setBodyDataList(List<Map<String, Object>> bodyDataList) {
		this.bodyDataList = bodyDataList;
	}
	public File getTemplateFile() {
		return templateFile;
	}
	public void setTemplateFile(File templateFile) {
		this.templateFile = templateFile;
	}
	public int[][] getChartSeries() {
		return chartSeries;
	}
	public void setChartSeries(int[][] chartSeries) {
		this.chartSeries = chartSeries;
	}
	public BandwidthReportModel getBandwidthReportModel() {
		return bandwidthReportModel;
	}
	public void setBandwidthReportModel(BandwidthReportModel bandwidthReportModel) {
		this.bandwidthReportModel = bandwidthReportModel;
	}
}
