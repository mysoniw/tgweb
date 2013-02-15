package com.techwin.preferences.account.service;

import java.util.Map;

public interface AccountService {

	public void updateAccount(Map<String, Object> parameters) throws Exception;

	public void updatePreferences(Map<String, Object> argsMap) throws Exception;
}
