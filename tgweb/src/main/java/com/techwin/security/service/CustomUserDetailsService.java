package com.techwin.security.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.inject.Inject;
import javax.inject.Named;

import org.anyframe.query.QueryServiceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.techwin.security.dao.CustomUserDetailsDao;
import com.techwin.security.domain.CustomUser;

@Service("customUserDetailService")
public class CustomUserDetailsService implements UserDetailsService {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Inject
	@Named("customUserDetailsDao")
	private CustomUserDetailsDao customUserDetailsDao;

	@Inject
	private PropertiesFactoryBean prop;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException, RuntimeException {

		UserDetails user = null;
		Map<String, Object> map = null;
		Map<String, Object> returnMap = null;

		boolean isSingleLogin = false;
		
		if (username.contains(";")) {
			map = this.getDecryptDataList(username);
			isSingleLogin = true;
		} else {
			map = new HashMap<String, Object>();
			map.put("EP_MAIL", username);
		}
		
		try {
			returnMap = customUserDetailsDao.getEmpAuthority(map);
		} catch (QueryServiceException e) {
			throw new RuntimeException(e);
		}

		if (returnMap == null) { throw new UsernameNotFoundException("User does not exist!"); }
		
		if (isSingleLogin) {
			user = new CustomUser(
					(String)map.get("EP_MAIL")													// username (email)
					, (String)returnMap.get("PASSWORD")											// password
					, this.getAuthorities((String)returnMap.get("USER_AUTH"), isSingleLogin)	// authorities (ROLE_USER, ROLE_ADMIN, SINGLE_ACCESS)
					, (String)map.get("EP_RETURNCODE")											// returnCode
					, (String)map.get("EP_LOGINTIMEFORMIS")										// loginTimeFormIs
					, (String)map.get("EP_MAIL")												// email
					, (String)map.get("EP_USERNAME")											// userName
					, (String)map.get("EP_DEPTNAME")											// deptName
					, (String)returnMap.get("PREFERENCES")
					);
		} else {
			user = new CustomUser(
					username																	// username (email)
					, (String)returnMap.get("PASSWORD")											// password
					, this.getAuthorities("USER", isSingleLogin)								// authorities (ROLE_USER)
					, (String)returnMap.get("USER_NAME")										// userName
					, (String)returnMap.get("DEPTNAME")											// deptName
					, (String)returnMap.get("PREFERENCES")
					);
		}
		
		return user;
	}

	public Collection<GrantedAuthority> getAuthorities(String access, boolean flag) {
		// Create a list of grants for this user
		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>(2);

		// All users are granted with ROLE_USER access
		// Therefore this user gets a ROLE_USER by default
		logger.debug("Grant ROLE_USER to this user");
		authList.add(new GrantedAuthorityImpl("ROLE_USER"));

		// Check if this user has admin access
		// We interpret Integer(1) as an admin user
		if (access.indexOf("ADMIN") > -1) {
			// User has admin access
			logger.debug("Grant ROLE_ADMIN to this user");
			authList.add(new GrantedAuthorityImpl("ROLE_ADMIN"));
		}
		
		if (flag) {
			logger.debug("Grant SINGLE_ACCESS to this user");
			authList.add(new GrantedAuthorityImpl("SINGLE_ACCESS"));
		}
		
		// Return list of granted authorities
		return authList;
	}

	public Map<String, Object> getDecryptDataList(String epData) throws RuntimeException {
		Map<String, Object> map = new HashMap<String, Object>();

		StringTokenizer epToken = new StringTokenizer(epData, ";");

		if (!epToken.hasMoreTokens()) { throw new RuntimeException("invalid epData : " + epData); }

		String strNewDataList = epToken.nextToken();
		String strMD5SecureKey = epToken.nextToken();

		byte[] baPublicKey = null;
		
		try {
			baPublicKey = ep.Utils.getPublicKey((String)prop.getObject().get("strKeyFolder.path"));
		} catch(IOException e) {
			throw new RuntimeException(e);
		}
		
		String userInfo = ep.EpTrayUtil.DecryptDataList(new String(baPublicKey), strMD5SecureKey, strNewDataList);

		String[] userToken = userInfo.split(";");

		for (String token : userToken) {
			if (token.indexOf("=") > -1 && token.split("=").length > 1) {
				map.put(token.split("=")[0], token.split("=")[1]);
			}
		}

		return map;
	}
}
