package com.techwin.tg.common.web;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.techwin.common.util.RequestUtil;

@Controller
@RequestMapping("/cmnForward.do")
public class ForwardController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	private ApplicationContext context;

	@RequestMapping(params = "mode=main")
	public String forwardToMain(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nforwardToUrl\n");
		
		String testProject = request.getParameter("TEST_PROJECT_ID");
		String url = context.getMessage("tgweb.common." + testProject + ".Main.url", null, Locale.getDefault());
		
		logger.debug("forwarding url :: {}", url);
		
		return "forward:" + url;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "mode=tc")
	public String forwardToTc(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		Map<String, Object> map = RequestUtil.bindParameterToMap(request.getParameterMap());
		List<String> list = Arrays.asList(new String[]{"TEST_PROJECT_ID", "TEST_SUITE_ID", "CATEGORY", "MODEL", "FW_VERSION"});
		Iterator<Map.Entry<String, Object>> it = map.entrySet().iterator();
		int requiredCount = 0;
		
		while (it.hasNext()) {
			Map.Entry<String, Object> entry = (Map.Entry<String, Object>)it.next();

			// list에 있는 필수 parameter가 맞는지 value가 null이거나 empty인지 맞으면 count
			if (list.contains(entry.getKey()) && StringUtils.isNotEmpty((String)entry.getValue())) {
				requiredCount++;
			}
		}
		
		if (requiredCount != list.size()) {
			throw new RuntimeException("Not supported request parameter(s) parameter must be " + list.size() + ", but given " + requiredCount);
		}
		
		String url = context.getMessage("tgweb.common." + map.get("TEST_PROJECT_ID") + ".Tc.url", null, Locale.getDefault());
		String addtionalParams = "?method=l";
		
		return "forward:" + url + addtionalParams;
	}
}
