package com.techwin.security.resultHandler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.util.UrlUtils;
import org.springframework.util.Assert;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
    private String userNotFound;
    private String passwordNotMatch;
    @SuppressWarnings("unused")
	private String passwordRegistration;
    private boolean forwardToDestination = false;
    private boolean allowSessionCreation = true;
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    public CustomAuthenticationFailureHandler() {
    }

    public CustomAuthenticationFailureHandler(String userNotFound, String passwordNotMatch, String passwordRegistration) {
    	this.setUserNotFound(userNotFound);
    	this.setPasswordNotMatch(passwordNotMatch);
    	this.setPasswordRegistration(passwordRegistration);
    }

    /**
     * Performs the redirect or forward to the {@code defaultFailureUrl} if set, otherwise returns a 401 error code.
     * <p>
     * If redirecting or forwarding, {@code saveException} will be called to cache the exception for use in
     * the target view.
     */
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {

        if (userNotFound == null || passwordNotMatch == null) {
            logger.debug("No [userNotFound, passwordNotMatch, accessDenied] URL set, sending 401 Unauthorized error");

            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Authentication Failed: " + exception.getMessage());
        } else {
            saveException(request, exception);
            
            if (forwardToDestination) {
            	if (exception instanceof UsernameNotFoundException) {
            		logger.debug("Forwarding to " + userNotFound);
            		request.getRequestDispatcher(userNotFound).forward(request, response);
            	} else if (exception instanceof BadCredentialsException) {
            		logger.debug("Forwarding to " + passwordNotMatch);
            		request.getRequestDispatcher(passwordNotMatch).forward(request, response);
            	} else {
            		throw new RuntimeException("Unexpected Exception : {}", exception);
            	}
            } else {
            	if (exception instanceof UsernameNotFoundException) {
            		logger.debug("Redirecting to " + userNotFound);
            		redirectStrategy.sendRedirect(request, response, userNotFound);
            	} else if (exception instanceof BadCredentialsException) {
            		logger.debug("Redirecting to " + passwordNotMatch);
            		redirectStrategy.sendRedirect(request, response, passwordNotMatch);
            	} else {
            		throw new RuntimeException("Unexpected Exception : {}", exception);
            	}
            }
        }
    }

    /**
     * Caches the {@code AuthenticationException} for use in view rendering.
     * <p>
     * If {@code forwardToDestination} is set to true, request scope will be used, otherwise it will attempt to store
     * the exception in the session. If there is no session and {@code allowSessionCreation} is {@code true} a session
     * will be created. Otherwise the exception will not be stored.
     */
    protected final void saveException(HttpServletRequest request, AuthenticationException exception) {
        if (forwardToDestination) {
            request.setAttribute(WebAttributes.AUTHENTICATION_EXCEPTION, exception);
        } else {
            HttpSession session = request.getSession(false);

            if (session != null || allowSessionCreation) {
                request.getSession().setAttribute(WebAttributes.AUTHENTICATION_EXCEPTION, exception);
            }
        }
    }

    protected boolean isUseForward() {
        return forwardToDestination;
    }

    /**
     * If set to <tt>true</tt>, performs a forward to the failure destination URL instead of a redirect. Defaults to
     * <tt>false</tt>.
     */
    public void setUseForward(boolean forwardToDestination) {
        this.forwardToDestination = forwardToDestination;
    }

    /**
     * Allows overriding of the behaviour when redirecting to a target URL.
     */
    public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
        this.redirectStrategy = redirectStrategy;
    }

    protected RedirectStrategy getRedirectStrategy() {
        return redirectStrategy;
    }

    protected boolean isAllowSessionCreation() {
        return allowSessionCreation;
    }

    public void setAllowSessionCreation(boolean allowSessionCreation) {
        this.allowSessionCreation = allowSessionCreation;
    }

	public void setUserNotFound(String userNotFound) {
        Assert.isTrue(UrlUtils.isValidRedirectUrl(userNotFound),
                "'" + userNotFound + "' is not a valid redirect URL");
		this.userNotFound = userNotFound;
	}

	public void setPasswordNotMatch(String passwordNotMatch) {
		Assert.isTrue(UrlUtils.isValidRedirectUrl(passwordNotMatch),
				"'" + passwordNotMatch + "' is not a valid redirect URL");
		this.passwordNotMatch = passwordNotMatch;
	}

	public void setPasswordRegistration(String passwordRegistration) {
		Assert.isTrue(UrlUtils.isValidRedirectUrl(passwordRegistration),
				"'" + passwordRegistration + "' is not a valid redirect URL");
		this.passwordRegistration = passwordRegistration;
	}
}
