package com.techwin.security.resultHandler;

import java.io.IOException;
import java.net.URLEncoder;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AbstractAuthenticationTargetUrlRequestHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.techwin.security.domain.CustomUser;

public class CustomAuthenticationSuccessHandler extends AbstractAuthenticationTargetUrlRequestHandler implements AuthenticationSuccessHandler {

//	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Inject
	private PropertiesFactoryBean prop;

	public CustomAuthenticationSuccessHandler() {}

	public CustomAuthenticationSuccessHandler(String defaultTargetUrl) {
		setDefaultTargetUrl(defaultTargetUrl);
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		final String COOKIE_NAME = prop.getObject().getProperty("cookie.default.name");
		final String PARAM_NAME = prop.getObject().getProperty("cookie.parameter.name");
		final int DEFAULT_MAX_AGE = Integer.parseInt(prop.getObject().getProperty("cookie.max.age"));

		String rememberId = request.getParameter(PARAM_NAME);
		
		if (!authentication.getAuthorities().contains(new GrantedAuthorityImpl("SINGLE_ACCESS"))) {
			if (rememberId != null) {
				String userName = ((CustomUser)authentication.getPrincipal()).getUsername();
				Cookie cookie = new Cookie(COOKIE_NAME, URLEncoder.encode(userName, "UTF-8"));
				
				cookie.setMaxAge(DEFAULT_MAX_AGE);
				response.addCookie(cookie);
			} else {
				Cookie cookie = new Cookie(COOKIE_NAME, "");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
		}
		
		request.getSession().setAttribute("preferences", ((CustomUser)authentication.getPrincipal()).getPreferences());

		handle(request, response, authentication);
		clearAuthenticationAttributes(request);
	}

	@Override
	protected void handle(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		String targetUrl = super.determineTargetUrl(request, response);

		if (response.isCommitted()) { return; }

		// password가 등록되지 않은 사용자는 password 등록화면으로 보냄
		if (((CustomUser)authentication.getPrincipal()).getPassword() == null || "".equals(((CustomUser)authentication.getPrincipal()).getPassword())) {
			targetUrl = "/preAccount.do?method=registration&accessMode=auto";
		}

		super.getRedirectStrategy().sendRedirect(request, response, targetUrl);
	}

	protected final void clearAuthenticationAttributes(HttpServletRequest request) {
		HttpSession session = request.getSession(false);

		if (session == null) { return; }

		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
		session.removeAttribute(WebAttributes.LAST_USERNAME);
	}
}
