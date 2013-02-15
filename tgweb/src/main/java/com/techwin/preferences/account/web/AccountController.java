package com.techwin.preferences.account.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.techwin.common.constants.RequestConstants;
import com.techwin.common.util.JSONUtil;
import com.techwin.common.util.RequestUtil;
import com.techwin.preferences.account.service.AccountService;
import com.techwin.security.domain.CustomUser;

@Controller
@RequestMapping("/preAccount.do")
public class AccountController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	AccountService accountService;
	
	@Inject
	PasswordEncoder passwordEncoder;
	
	@Inject
	PropertiesFactoryBean prop;

	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=registration")
	public String getRegistrationPage(HttpServletRequest request, Model model, HttpServletResponse response) throws NumberFormatException, IOException {
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		model.addAttribute("params", parameterMap);
		
		return "preAccountRegistration";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = RequestConstants.UPDATE_PROCESS)
	public ModelAndView updatePassword(HttpServletRequest request, Model model) throws Exception {
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		parameterMap.put("userId", user.getEmail());
		parameterMap.put("password", passwordEncoder.encodePassword((String)parameterMap.get("password"), null));
		accountService.updateAccount(parameterMap);

		logger.debug("parameterMap : {}", parameterMap);
		
		// TODO dialog 띄울것
		parameterMap.put("accessMode", "success");
		model.addAttribute("params", parameterMap);
		
		return new ModelAndView("redirect:/");
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "method=preferences")
	public ModelAndView updatePreferences(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		String[] rowList = (String[])parameterMap.get("rowList");
		List<String> list = new ArrayList<String>(Arrays.asList(rowList));
		list.removeAll(Arrays.asList(""));
		
		Map<String, Object> sourceMap = new HashMap<String, Object>(1);
		sourceMap.put("rowList", JSONUtil.toJSONArray(list));
		
		JSONObject json = JSONUtil.toJSON(sourceMap);
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		Map<String, Object> argsMap = new HashMap<String, Object>();
		argsMap.put("preferences", json.toJSONString());
		argsMap.put("userId", user.getEmail());
		
		accountService.updatePreferences(argsMap);

		session.setAttribute("preferences", json.toJSONString());
		
		return new ModelAndView("redirect:/");
	}
}
