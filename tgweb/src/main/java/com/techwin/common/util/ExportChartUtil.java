package com.techwin.common.util;

import java.io.StringReader;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.batik.transcoder.Transcoder;
import org.apache.batik.transcoder.TranscoderException;
import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.TranscoderOutput;
import org.apache.batik.transcoder.image.JPEGTranscoder;
import org.apache.batik.transcoder.image.PNGTranscoder;
import org.apache.fop.svg.PDFTranscoder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.techwin.common.TgwebException;

@Controller
@RequestMapping("/cmnExportChart.do")
public class ExportChartUtil {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=chart")
	public void export(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map<String, Object> params = RequestUtil.bindParameterToMap(request.getParameterMap());
		String ext = "";
		Transcoder t = null;

		String type = (String)params.get("type");
		String svg = (String)params.get("svg");
		ServletOutputStream out = response.getOutputStream();

		if (type != null && svg != null) {
			// This line is necessary due to a bug in the highcharts SVG generator for IE
			// I'm guessing it wont be needed later.
			svg = svg.replaceAll(":rect", "rect");
			if ("image/png".equals(type)) {
				ext = "png";
				t = new PNGTranscoder();
			}
			if ("image/jpeg".equals(type)) {
				ext = "jpg";
				t = new JPEGTranscoder();
				t.addTranscodingHint(JPEGTranscoder.KEY_QUALITY, new Float(.8));
			}
			if ("application/pdf".equals(type)) {
				ext = "pdf";
				t = new PDFTranscoder();
			}
			if ("image/svg+xml".equals(type)) {
				ext = "svg";
			}

			final SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
			String fileName = "chart_" + sdf.format(new Date()) + "." + ext;

			fileName = getDisposition(fileName, getBrowser(request));
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + fileName + "\"");
			response.setContentType(type);

			if (t != null) {
				TranscoderInput input = new TranscoderInput(new StringReader(svg));
				TranscoderOutput output = new TranscoderOutput(out);
				try {
					t.transcode(input, output);
				} catch (TranscoderException e) {
					logger.error("Error stack trace: Problem transcoding stream.", e);
				}

			} else if (ext == "svg") {
				out.print(svg);
			} else {
				out.print("Invalid type: " + type);
			}
		} else {
			throw new TgwebException("Parameter [type] or [svg] is null");
		}
		
		out.flush();
		out.close();
	}
	
	private String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1) {
			return "MSIE";
		} else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Opera") > -1) { return "Opera"; }
		return "Firefox";
	}

	private String getDisposition(String filename, String browser) throws Exception {
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