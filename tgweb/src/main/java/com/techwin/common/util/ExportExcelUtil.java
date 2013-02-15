/*=============================================================================
 * 파일명	: ExportExcelUtil.java
 * 파일설명	: excel export
 * 작성자	: 김수엽
 * 작성일자	: 2011. 03. 16
 ============================================================================*/
package com.techwin.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFChart;
import org.apache.poi.hssf.usermodel.HSSFChart.HSSFSeries;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.PrintSetup;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressBase;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.techwin.common.TgwebException;
import com.techwin.common.util.model.BandwidthReportModel;
import com.techwin.common.util.model.ExportExcelUtilModel;

/**
 * ExportExcelUtil
 * 
 * @author 김수엽
 * @version "$Id: ExportExcelUtil.java 14453 2011-10-07 06:47:32Z adonis750 $
 */
public class ExportExcelUtil {

	private static Logger logger = LoggerFactory.getLogger(ExportExcelUtil.class);

	// singleton class, do not access...
	private ExportExcelUtil() {}

	private enum Style {
		TITLE, HEAD_INFO_KEY, HEAD_INFO_VALUE, BODY_HEAD, BODY_VALUE
	}

	/**
	 * 엑셀 다운로드
	 * 
	 * @param response
	 * @param List<Map<String, Object>>
	 * @throws Exception
	 * 
	 */
	public static void exportExcelByKey(HttpServletRequest request, HttpServletResponse response, List<Map<String, Object>> list) throws Exception {

		String title = request.getParameter("title") != null ? request.getParameter("title") : "제목";
		HSSFWorkbook workbook = new HSSFWorkbook();

		if (list.isEmpty()) {
			createEmptyWorkSheet(workbook);
		} else {
			ExportExcelUtilModel model = new ExportExcelUtilModel();

			model.setTitle(title);
			model.setSheetTitle("Sheet 1");
			model.setBodyDataList(list);

			model.setColumnNameMap(columnNameReplacement(list.get(0)));

			extractionHeadInfo(request, model);

			createSheet(workbook, model);
		}

		responseWithWorkbook(request, response, workbook, title);
	}
	
	public static void exportExcelMultiSheet(HttpServletRequest request, HttpServletResponse response, Map<String, List<Map<String, Object>>> map) throws Exception {
		
		String title = request.getParameter("title") != null ? request.getParameter("title") : "제목";
		
		HSSFWorkbook workbook = new HSSFWorkbook();

		Iterator<Map.Entry<String, List<Map<String, Object>>>> it = map.entrySet().iterator();
		
		int index = 0;
		while(it.hasNext()) {
			Map.Entry<String, List<Map<String, Object>>> entry = it.next();
			
			ExportExcelUtilModel model = new ExportExcelUtilModel();
			
			model.setTitle(title);
			model.setSheetIndex(index++);
			model.setBodyDataList(entry.getValue());
			model.setSheetTitle(entry.getKey());
			model.setColumnNameMap(columnNameReplacement(entry.getValue().get(0)));
			
			extractionHeadInfo(request, model);
			
			createSheet(workbook, model);
		}
		
		responseWithWorkbook(request, response, workbook, title);
	}

	@Deprecated
	public static void bandwidthReport(HttpServletRequest request, HttpServletResponse response, List<ExportExcelUtilModel> list) throws Exception {

		String title = request.getParameter("title") != null ? request.getParameter("title") : "제목";

		HSSFWorkbook workbook = new HSSFWorkbook();

		if (list.isEmpty()) {
			createEmptyWorkSheet(workbook);
		} else {
			workbook = getWorkbookFromExistedFile(list.get(0).getTemplateFile());
			int index = 0;

			for (ExportExcelUtilModel model : list) {
				model.setTitle(title);
				model.setSheetIndex(index++);

				createSheet(workbook, model);
			}
			deleteSheet(workbook, index);
		}

		responseWithWorkbook(request, response, workbook, title);
	}

	public static void bandwidthTcReport(HttpServletRequest request, HttpServletResponse response, ExportExcelUtilModel model) throws Exception {

		final String title = "Bandwidth_Test_Case_Report";

		HSSFWorkbook workbook = new HSSFWorkbook();
		List<Map<String, Object>> list = model.getBodyDataList();
		BandwidthReportModel bandwidthModel = model.getBandwidthReportModel();

		int index = 0;

		if (list.isEmpty()) {
			createEmptyWorkSheet(workbook);
		} else {
			workbook = getWorkbookFromExistedFile(model.getTemplateFile());
			Map<ExportExcelUtil.Style, CellStyle> styles = createStyles(workbook);

			Map<String, String> columnNameMap = columnNameReplacement(list.get(0));

			model.setColumnNameMap(columnNameMap);
			extractionHeadInfo(request, model);

			for (String z : bandwidthModel.getzList()) {
				String xColumn = columnNameMap.get(bandwidthModel.getX());
				String yColumn = columnNameMap.get(bandwidthModel.getY());
				String zColumn = columnNameMap.get(bandwidthModel.getZ());

				Row row = null;
				Cell cell = null;
				CellStyle style = null;

				int xListSize = bandwidthModel.getxList().size();
				int yListSize = bandwidthModel.getyList().size();

				int[][] chartSeries = new int[xListSize + 1][4];

				final int CATEGORY_LABEL_CELL = 3;
				final int CATEGORY_LABEL_ROW = 3;
				final int VALUE_CELL = 4;
				final int VALUE_ROW = 3;

				chartSeries[0] = new int[] { CATEGORY_LABEL_CELL, CATEGORY_LABEL_ROW, CATEGORY_LABEL_CELL, CATEGORY_LABEL_ROW + yListSize - 1 };
				for (int i = 0; i < xListSize; i++) {
					chartSeries[i + 1] = new int[] { VALUE_CELL + i, VALUE_ROW, VALUE_CELL + i, VALUE_ROW + yListSize - 1 };
				}

				model.setChartSeries(chartSeries);

				model.setDefaultRowPos();
				model.setTitle(title);
				model.setSheetIndex(index++);
				model.setSheetTitle((z != null ? z : "Sheet 1"));

				HSSFSheet sheet = createSheet(workbook, model);

				if (z != null) {
					row = sheet.createRow(model.getRowPos());
					
					cell = row.createCell(ExportExcelUtilModel.HEAD_INFO_KEY_CELL_INDEX);
					cell.setCellValue(zColumn);
					style = styles.get(Style.HEAD_INFO_KEY);
					
					style.setFillForegroundColor(workbook.getCustomPalette().findSimilarColor(255, 255, 0).getIndex());
					cell.setCellStyle(style);
					
					cell = row.createCell(ExportExcelUtilModel.HEAD_INFO_VALUE_CELL_INDEX);
					cell.setCellValue(z);
					cell.setCellStyle(styles.get(Style.HEAD_INFO_VALUE));
				}

				int cellIndex = BandwidthReportModel.DEFAULT_CELL_INDEX;
				model.setDefaultRowPos();

				int rowPos = model.getRowPos();
				if (sheet.getRow(rowPos) != null) {
					row = sheet.getRow(rowPos);
				} else {
					row = sheet.createRow(rowPos);
				}

				cell = row.createCell(cellIndex++);
				cell.setCellValue(yColumn + "              " + xColumn);

				style = styles.get(Style.BODY_HEAD);
				style.setBorderBottom(CellStyle.THICK_BACKWARD_DIAG);

				cell.setCellStyle(style);

				for (String x : bandwidthModel.getxList()) {
					cell = row.createCell(cellIndex++);
					cell.setCellValue(x);
					cell.setCellStyle(styles.get(Style.BODY_HEAD));
				}

				for (String y : bandwidthModel.getyList()) {
					cellIndex = BandwidthReportModel.DEFAULT_CELL_INDEX;

					rowPos = model.getRowPos();
					if (sheet.getRow(rowPos) != null) {
						row = sheet.getRow(rowPos);
					} else {
						row = sheet.createRow(rowPos);
					}

					cell = row.createCell(cellIndex++);
					cell.setCellValue(y);
					cell.setCellStyle(styles.get(Style.BODY_HEAD));

					for (String x : bandwidthModel.getxList()) {
						cell = row.createCell(cellIndex++);

						if (bandwidthModel.getDataMap().get(x, y, z) instanceof Double) {
							cell.setCellValue(((Double)bandwidthModel.getDataMap().get(x, y, z)).doubleValue());
						} else {
							cell.setCellValue("");
						}

						cell.setCellStyle(styles.get(Style.BODY_VALUE));
					}
				}
				for (int i = 0; i < cellIndex; i++) {
					sheet.autoSizeColumn(i);
				}
			}
			deleteSheet(workbook, index);
		}

		responseWithWorkbook(request, response, workbook, title);
	}

	private static void createEmptyWorkSheet(HSSFWorkbook workbook) throws Exception {

		HSSFSheet sheet = createSheet(workbook, "Sheet 1");
		String title = "No data available";
		Map<ExportExcelUtil.Style, CellStyle> styles = createStyles(workbook);

		createTitle(sheet, styles, title, 10);
	}
	
	
	private static void createTitle(HSSFSheet sheet, Map<ExportExcelUtil.Style, CellStyle> styles, String title, int lastColumnPos) throws Exception {
		// title row creation
		Row titleRow = sheet.createRow(ExportExcelUtilModel.TITLE_ROW_INDEX);
		
		Cell titleCell = titleRow.createCell(0);
		titleCell.setCellValue(title);
		titleCell.setCellStyle(styles.get(Style.TITLE));
		
		sheet.addMergedRegion(new CellRangeAddress(0, // first row (0-based)
				1, // last row (0-based)
				0, // first column (0-based)
				lastColumnPos // last column (0-based)
		));
	}

	private static HSSFSheet createSheet(HSSFWorkbook workbook, ExportExcelUtilModel model) throws Exception {

		List<Map<String, Object>> list = model.getBodyDataList();

		int numberOfSheet = workbook.getNumberOfSheets();

		HSSFSheet sheet = null;

		if (model.getSheetIndex() < numberOfSheet) {
			sheet = workbook.getSheetAt(model.getSheetIndex());
			workbook.setSheetName(model.getSheetIndex(), model.getSheetTitle());
		} else {
			sheet = createSheet(workbook, model.getSheetTitle());
		}

		// chart cell range modify
		if (model.getChartSeries() != null) {
			HSSFChart[] charts = HSSFChart.getSheetCharts(sheet);

			int[][] chartSeries = model.getChartSeries();

			// chart (1 chart of sheet supported)
			for (HSSFChart chart : charts) {
				HSSFSeries[] serieses = chart.getSeries();

				// serieses of chart
				for (int i = 0, size = serieses.length; i < size; i++) {
					HSSFSeries series = serieses[i];

					if (i < chartSeries.length - 1) {

						CellRangeAddressBase lcr = series.getCategoryLabelsCellRange();
						CellRangeAddressBase vcr = series.getValuesCellRange();

						lcr.setFirstColumn(chartSeries[0][0]);
						lcr.setFirstRow(chartSeries[0][1]);
						lcr.setLastColumn(chartSeries[0][2]);
						lcr.setLastRow(chartSeries[0][3]);
						vcr.setFirstColumn(chartSeries[i + 1][0]);
						vcr.setFirstRow(chartSeries[i + 1][1]);
						vcr.setLastColumn(chartSeries[i + 1][2]);
						vcr.setLastRow(chartSeries[i + 1][3]);

						// lcr.setLastRow(lcr.getFirstRow() + list.size() - 1);
						// vcr.setLastRow(vcr.getFirstRow() + list.size() - 1);

						series.setCategoryLabelsCellRange(lcr);
						series.setValuesCellRange(vcr);

					} else {
						chart.removeSeries(series);
					}
				}
			}
		}

		// Fit sheet to one page
		PrintSetup ps = sheet.getPrintSetup();

		sheet.setAutobreaks(true);
		if (model.getSheetIndex() != 0) ps.setFitHeight((short)1);
		ps.setFitWidth((short)1);

		Map<ExportExcelUtil.Style, CellStyle> styles = createStyles(workbook);

		createTitle(sheet, styles, model.getTitle(), list.get(0).entrySet().size() - 1);

		if (model.getHeadInfoData() != null) {
			createSheetHeadInfo(sheet, model, styles);
		}

		if (model.getBandwidthReportModel() == null) {
			createSheetBody(sheet, model, styles);
		}

		return sheet;
	}

	private static void createSheetHeadInfo(HSSFSheet sheet, ExportExcelUtilModel model, Map<ExportExcelUtil.Style, CellStyle> styles) {
		// head table row creation
		Map<String, Object> map = model.getHeadInfoData();

		Iterator<Map.Entry<String, String>> it = model.getColumnNameMap().entrySet().iterator();

		// head info의 ordering 문제로 json에서 가져온 order대로 표현하기 위해 columnNameMap 기준으로 iteration함
		while (it.hasNext()) {
			Map.Entry<String, String> entry = it.next();

			if (map.get(entry.getKey()) != null) {

				Row row = sheet.createRow(model.getRowPos());

				Cell cell = row.createCell(ExportExcelUtilModel.HEAD_INFO_KEY_CELL_INDEX);

				cell.setCellValue(entry.getValue());
				cell.setCellStyle(styles.get(Style.HEAD_INFO_KEY));

				cell = row.createCell(ExportExcelUtilModel.HEAD_INFO_VALUE_CELL_INDEX);
				cell.setCellStyle(styles.get(Style.HEAD_INFO_VALUE));

				if (map.get(entry.getKey()) instanceof Double) {
					cell.setCellValue(((Double)map.get(entry.getKey())).doubleValue());
				} else if (map.get(entry.getKey()) instanceof Integer) {
					cell.setCellValue(((Integer)map.get(entry.getKey())).intValue());
				} else if (map.get(entry.getKey()) instanceof BigDecimal) {
					cell.setCellValue(((BigDecimal)map.get(entry.getKey())).doubleValue());
				} else {
					cell.setCellValue(map.get(entry.getKey()).toString());
				}
			}
		}

	}

	private static void createSheetBody(HSSFSheet sheet, ExportExcelUtilModel model, Map<ExportExcelUtil.Style, CellStyle> styles) {

		// empty row
		model.getRowPos();

		List<Map<String, Object>> list = model.getBodyDataList();
		Row bhRow = sheet.createRow(model.getRowPos());
		int freezePanePos = bhRow.getRowNum() + 1;

		// column의 alias를 직접 지정해주지 않고 config file을 통해서 replacement 한다
		Map<String, Object> bhDataMap = list.get(0);
		Iterator<Map.Entry<String, Object>> iterator = bhDataMap.entrySet().iterator();

		int bhCellIndex = 0;
		while (iterator.hasNext()) {
			Cell cell = bhRow.createCell(bhCellIndex++);
			cell.setCellValue(model.getColumnNameMap().get(iterator.next().getKey()));
			cell.setCellStyle(styles.get(Style.BODY_HEAD));
		}

		// data row iteration
		int cellIndex = 0;
		for (Map<String, Object> dataMap : list) {
			cellIndex = 0;
			iterator = dataMap.entrySet().iterator();
			Row row = sheet.createRow(model.getRowPos());

			// hidden columns definition
			if (model.getHiddenColumn().length > 0) {
				for (int i : model.getHiddenColumn()) {
					sheet.setColumnHidden(i, true);
				}
			}

			// data cell iteration
			while (iterator.hasNext()) {
				Entry<String, Object> entry = iterator.next();
				Cell cell = row.createCell(cellIndex++);
				cell.setCellStyle(styles.get(Style.BODY_VALUE));

				if (entry.getValue() == null) {
					cell.setCellValue("");
					continue;
				}

				if (entry.getValue() instanceof Double) {
					cell.setCellValue(((Double)entry.getValue()).doubleValue());
				} else if (entry.getValue() instanceof Integer) {
					cell.setCellValue(((Integer)entry.getValue()).intValue());
				} else if (entry.getValue() instanceof BigDecimal) {
					cell.setCellValue(((BigDecimal)entry.getValue()).doubleValue());
				} else {
					cell.setCellValue(entry.getValue().toString());
				}

			}
		}

		sheet.createFreezePane(0, freezePanePos);

		for (int i = 0; i < cellIndex; i++) {
			sheet.autoSizeColumn(i);
		}
	}

	private static HSSFSheet createSheet(HSSFWorkbook workbook, String sheetName) {
		HSSFSheet sheet = workbook.createSheet(sheetName);
		sheet.setDisplayGridlines(true);
		sheet.setPrintGridlines(true);
		sheet.setFitToPage(true);
		sheet.setHorizontallyCenter(true);

		PrintSetup printSetup = sheet.getPrintSetup();
		printSetup.setLandscape(true);

		return sheet;
	}

	private static void deleteSheet(HSSFWorkbook workbook, int sIndex) {
		int numberOfSheet = workbook.getNumberOfSheets();

		for (int i = numberOfSheet - 1; i >= sIndex; i--) {
			workbook.removeSheetAt(i);
		}
	}

	private static void responseWithWorkbook(HttpServletRequest request, HttpServletResponse response, HSSFWorkbook workbook, String title) throws Exception {
		try {

			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
			String fileName = title + "_" + sdf.format(new Date()) + ".xls";

			String browser = getBrowser(request);
			// TODO : tomcat 사용시 아래 주석 해제 (배포시 삭제)
			fileName = getDisposition(fileName, browser);

			// fileName = URLEncoder.encode(fileName, "UTF8").replaceAll("\\+", "%20");

			response.reset();
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
			// response.setContentType("application/vnd.ms-excel");
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

			request.setCharacterEncoding("UTF-8");

			workbook.write(response.getOutputStream());
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	private static Map<ExportExcelUtil.Style, CellStyle> createStyles(HSSFWorkbook workbook) {

		Map<ExportExcelUtil.Style, CellStyle> styles = new HashMap<ExportExcelUtil.Style, CellStyle>();
		CellStyle style;

		// TITLE
		Font titleFont = workbook.createFont();
		titleFont.setFontHeightInPoints(Short.parseShort("16"));
		titleFont.setFontName("맑은 고딕");
		titleFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
		style = workbook.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFont(titleFont);
		styles.put(Style.TITLE, style);

		// HEAD_INFO_KEY
		Font headInfoKeyFont = workbook.createFont();
		headInfoKeyFont.setFontHeightInPoints(Short.parseShort("9"));
		headInfoKeyFont.setFontName("맑은 고딕");
		headInfoKeyFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
		style = workbook.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(workbook.getCustomPalette().findSimilarColor(255, 196, 0).getIndex());
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		style.setBorderTop(CellStyle.BORDER_THIN); // border top
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN); // border left
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_THIN); // border right
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderBottom(CellStyle.BORDER_THIN); // border bottom
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setFont(headInfoKeyFont);
		styles.put(Style.HEAD_INFO_KEY, style);

		// HEAD_INFO_VALUE
		Font headInfoValueFont = workbook.createFont();
		headInfoValueFont.setFontHeightInPoints(Short.parseShort("9"));
		headInfoValueFont.setFontName("맑은 고딕");
		style = workbook.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setBorderTop(CellStyle.BORDER_THIN); // border top
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN); // border left
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_THIN); // border right
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderBottom(CellStyle.BORDER_THIN); // border bottom
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setFont(headInfoValueFont);
		styles.put(Style.HEAD_INFO_VALUE, style);

		// BODY_HEAD
		Font headerFont = workbook.createFont();
		headerFont.setFontHeightInPoints(Short.parseShort("9"));
		headerFont.setFontName("맑은 고딕");
		headerFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
		style = workbook.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(workbook.getCustomPalette().findSimilarColor(180, 180, 180).getIndex());
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		style.setBorderTop(CellStyle.BORDER_MEDIUM); // border top
		// style.setTopBorderColor(workbook.getCustomPalette().findSimilarColor(0, 0, 255).getIndex());
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_MEDIUM); // border left
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_MEDIUM); // border right
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderBottom(CellStyle.BORDER_MEDIUM); // border bottom
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setFont(headerFont);
		styles.put(Style.BODY_HEAD, style);

		// BODY_VALUE
		Font valueFont = workbook.createFont();
		valueFont.setFontHeightInPoints(Short.parseShort("9"));
		valueFont.setFontName("맑은 고딕");
		style = workbook.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(CellStyle.VERTICAL_TOP);
		style.setBorderTop(CellStyle.BORDER_THIN); // border top
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN); // border left
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_THIN); // border right
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderBottom(CellStyle.BORDER_THIN); // border bottom
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setFont(valueFont);
		styles.put(Style.BODY_VALUE, style);

		return styles;
	}


	private static HSSFWorkbook getWorkbookFromExistedFile(File file) {
		FileInputStream fis = null;
		HSSFWorkbook workbook = null;

		try {
			fis = new FileInputStream(file);
			workbook = new HSSFWorkbook(fis);
			// inSheet = inWorkbook.getSheetAt(0);

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return workbook;
	}

	@SuppressWarnings("unchecked")
	private static Map<String, String> columnNameReplacement(Map<String, Object> map) {
		final String TEST_PROJECT_ID = "TEST_PROJECT_ID";
		final String CATEGORY = "CATEGORY";
		final String FILE_NAME = "sql/columnNameDef.json";
		final String CHECK_SYMBOL = "NCAM";

		String testProjectId = (String)map.get(TEST_PROJECT_ID);
		String category = (String)map.get(CATEGORY);

		// keeps insertion order
		Map<String, String> returnMap = new LinkedHashMap<String, String>();

		JSONParser parser = new JSONParser();
		try {
			Object obj = parser.parse(new FileReader(new File(ExportExcelUtil.class.getClassLoader().getResource(FILE_NAME).toURI())));

			JSONObject jsonObj = (JSONObject)obj;

			if (testProjectId != null) {
				JSONObject extraObj = (JSONObject)((JSONObject)jsonObj.get("EXTRA")).get(testProjectId);

				if (extraObj != null) {
					if (extraObj.get(CHECK_SYMBOL) != null) {
						extraObj = (JSONObject)extraObj.get(category);
					}
					
					jsonObj.remove("EXTRA");
					jsonObj.putAll(extraObj);
				}
			}

			Iterator<Map.Entry<String, Object>> it = map.entrySet().iterator();

			while (it.hasNext()) {
				Map.Entry<String, Object> entry = it.next();

				returnMap.put(entry.getKey(), (jsonObj.get(entry.getKey()) != null ? (String)jsonObj.get(entry.getKey()) : entry.getKey()));
			}

		} catch (IOException | ParseException | URISyntaxException e) {
			e.printStackTrace();
		}

		return returnMap;
	}

	@SuppressWarnings("unchecked")
	private static void extractionHeadInfo(HttpServletRequest request, ExportExcelUtilModel model) {
		Map<String, Object> requestMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		Map<String, Object> dataMap = model.getBodyDataList().get(0);
		Map<String, Object> headerInfoMap = new LinkedHashMap<String, Object>();

		Iterator<Map.Entry<String, Object>> it = requestMap.entrySet().iterator();

		while (it.hasNext()) {
			Map.Entry<String, Object> entry = it.next();

			// parameter중 value가 있고, data의 key와 일치하는 항목은 head info를 위해 추출함
			if (!"".equals(entry.getValue()) && dataMap.get(entry.getKey()) != null) {
				headerInfoMap.put(entry.getKey(), dataMap.get(entry.getKey()));
			}
		}

		model.setHeadInfoData(headerInfoMap);

		for (Map<String, Object> map : model.getBodyDataList()) {
			it = headerInfoMap.entrySet().iterator();

			while (it.hasNext()) {
				Map.Entry<String, Object> entry = it.next();

				map.remove(entry.getKey());
			}
		}
	}

	private static String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1) {
			return "MSIE";
		} else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Opera") > -1) { return "Opera"; }
		return "Firefox";
	}

	private static String getDisposition(String filename, String browser) throws Exception {
		String encodedFilename = null;
		if ("MSIE".equals(browser)) {
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if ("Firefox".equals(browser)) {
			// encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
			encodedFilename = filename;
		} else if ("Opera".equals(browser)) {
			// encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
			encodedFilename = filename;
		} else if ("Chrome".equals(browser)) {
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			encodedFilename = sb.toString();
		} else {
			throw new TgwebException("Not supported browser");
		}

		return encodedFilename;
	}
}
