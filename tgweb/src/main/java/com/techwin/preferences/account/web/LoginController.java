package com.techwin.preferences.account.web;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.techwin.common.util.RequestUtil;
import com.techwin.preferences.account.service.AccountService;

@Controller
@RequestMapping("/trusted/preLogin.do")
public class LoginController {
//	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	AccountService accountService;
	
	@Inject
	PropertiesFactoryBean prop;

	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=login")
	public String getLoginPage(HttpServletRequest request, Model model) throws IOException {
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		// single 로그인 && 등록되지 않은 사용자일시 epData값 parameter에서 제거
		if (parameterMap.get("userId") != null && ((String)parameterMap.get("userId")).contains(";")) {
			parameterMap.remove("userId");
		}
		
		model.addAttribute("params", parameterMap);
		
		final String COOKIE_NAME = prop.getObject().getProperty("cookie.default.name");
		final String PARAM_NAME = prop.getObject().getProperty("cookie.parameter.name");
		
		Cookie[] cookies = request.getCookies();
		
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (COOKIE_NAME.equals(cookie.getName())) {
					model.addAttribute(PARAM_NAME, URLDecoder.decode(cookie.getValue(), "UTF-8"));
				}
			}
		}
		
		return "/preferences/account/Login";
	}
}
