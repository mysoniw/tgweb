package com.techwin.preferences.account.service.impl;

import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.stereotype.Service;

import com.techwin.preferences.account.service.AccountService;

@Service("accountService")
public class AccountServiceImpl implements AccountService {

	@Inject
	@Named("accountDao")
	private AccountDao dao;
	
	public void updateAccount(Map<String, Object> parameters) throws Exception {
		dao.updateUserManager(parameters);
	}

	@Override
	public void updatePreferences(Map<String, Object> argsMap) throws Exception {
		dao.updatePreferences(argsMap);
	}
}
