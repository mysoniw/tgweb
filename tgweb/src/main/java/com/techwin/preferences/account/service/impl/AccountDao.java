package com.techwin.preferences.account.service.impl;

import java.util.Map;

import org.anyframe.query.QueryServiceException;
import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("accountDao")
public class AccountDao extends TgWebDao {

	public void updateUserManager(Map<String, Object> parameters) throws Exception {
		super.update("AccountDao.update", parameters);
	}

	public void updatePreferences(Map<String, Object> argsMap) throws QueryServiceException {
		super.update("AccountDao.updatePreferences", argsMap);
	}
}
