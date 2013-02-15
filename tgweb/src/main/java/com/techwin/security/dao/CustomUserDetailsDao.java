package com.techwin.security.dao;

import java.util.Map;

import org.anyframe.query.QueryServiceException;
import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("customUserDetailsDao")
public class CustomUserDetailsDao extends TgWebDao {
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getEmpAuthority(Map<String, Object> map) throws QueryServiceException {
		return (Map<String, Object>)super.findByPk("CustomUserDetailsDao.find", map);
	}
}
