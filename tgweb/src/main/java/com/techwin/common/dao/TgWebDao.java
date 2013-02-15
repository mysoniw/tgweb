package com.techwin.common.dao;

import java.lang.reflect.Field;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.anyframe.pagination.Page;
import org.anyframe.query.QueryService;
import org.anyframe.query.QueryServiceException;
import org.anyframe.query.dao.AbstractDao;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.PropertyUtils;

public class TgWebDao extends AbstractDao {

	private static final String SPECIAL_CHAR = "SPECIAL_CHAR";

	public TgWebDao() {
		super();

		setFindByPkPostfix("");
		setFindListPostfix("");
		setFindPrefix("");
		setCreateId("");
		setRemoveId("");
		setUpdateId("");
	}

	@Inject
	public void setQueryService(QueryService queryService) {
		super.setQueryService(queryService);
	}

	@SuppressWarnings("rawtypes")
	protected Collection findList(String tableName, Object targetObj) throws QueryServiceException {
		return findList(tableName, targetObj, 0, 0);
	}

	@SuppressWarnings("rawtypes")
	protected Collection findList(String tableName, Map targetMap) throws QueryServiceException {
		return findList(tableName, targetMap, 0, 0);
	}

	@SuppressWarnings("rawtypes")
	protected Collection findList(String tableName, List targetObjs) throws QueryServiceException {
		return findList(tableName, targetObjs, 0, 0);
	}

	@SuppressWarnings("rawtypes")
	protected Collection findList(String tableName, Object[] targetObjs) throws QueryServiceException {
		return super.findList(tableName, convertParams(targetObjs));
	}

	@SuppressWarnings("rawtypes")
	protected Collection findList(String tableName, Object targetObj, int pageIndex, int pageSize) throws QueryServiceException {
		Object[] params = convertParams(targetObj);
		return findList(tableName, params, pageIndex, pageSize);
	}

	@SuppressWarnings("rawtypes")
	protected Collection findList(String tableName, Map targetMap, int pageIndex, int pageSize) throws QueryServiceException {
		Object[] params = convertParams(targetMap);
		return findList(tableName, params, pageIndex, pageSize);
	}

	@SuppressWarnings("rawtypes")
	protected Collection findList(String tableName, List targetList, int pageIndex, int pageSize) throws QueryServiceException {
		Object[] params = convertParams(targetList);
		return findList(tableName, params, pageIndex, pageSize);
	}

	@SuppressWarnings("rawtypes")
	private Collection findList(String tableName, Object[] targetObjs, int pageIndex, int pageSize) throws QueryServiceException {
		Object[] params = convertParams(targetObjs);
		QueryService queryService = super.getQueryService();
		return queryService.find(tableName, params, pageIndex, pageSize);
		// return super.findList(tableName, params, pageIndex, pageSize);
	}

	protected Page findListWithPaging(String tableName, Object targetObj, int pageIndex, int pageSize) throws QueryServiceException {
		return findListWithPaging(tableName, targetObj, pageIndex, pageSize, 10);
	}

	protected Page findListWithPaging(String tableName, Object targetObj, int pageIndex, int pageSize, int pageUnit) throws QueryServiceException {
		Object[] params = convertParams(targetObj);
		return findListWithPaging(tableName, params, pageIndex, pageSize, pageUnit);
	}

	@SuppressWarnings("rawtypes")
	protected Page findListWithPaging(String tableName, Map targetMap, int pageIndex, int pageSize) throws QueryServiceException {
		return findListWithPaging(tableName, targetMap, pageIndex, pageSize, 10);
	}

	@SuppressWarnings("rawtypes")
	protected Page findListWithPaging(String tableName, Map targetMap, int pageIndex, int pageSize, int pageUnit) throws QueryServiceException {
		Object[] params = convertParams(targetMap);
		return findListWithPaging(tableName, params, pageIndex, pageSize, pageUnit);
	}

	@SuppressWarnings("rawtypes")
	protected Page findListWithPaging(String tableName, List targetObjs, int pageIndex, int pageSize) throws QueryServiceException {
		return findListWithPaging(tableName, targetObjs, pageIndex, pageSize, 10);
	}

	@SuppressWarnings("rawtypes")
	protected Page findListWithPaging(String tableName, List targetObjs, int pageIndex, int pageSize, int pageUnit) throws QueryServiceException {
		Object[] params = convertParams(targetObjs);
		return findListWithPaging(tableName, params, pageIndex, pageSize, pageUnit);
	}

	protected Page findListWithPaging(String tableName, Object[] targetObjs, int pageIndex, int pageSize) throws QueryServiceException {
		return findListWithPaging(tableName, targetObjs, pageIndex, pageSize, 10);
	}

	protected Page findListWithPaging(String tableName, Object[] targetObjs, int pageIndex, int pageSize, int pageUnit) throws QueryServiceException {
		Object[] params = convertParams(targetObjs);
		return super.findListWithPaging(tableName, params, pageIndex, pageSize, pageUnit);
	}

	private Object[] convertParams(Object targetObj) {
		if ("VO".equals(targetObj.getClass().toString().substring(targetObj.getClass().toString().length() - 2))) {
			Field[] fields = targetObj.getClass().getDeclaredFields();
			for (Field field : fields) {

				try {
					Object fieldValue = PropertyUtils.getProperty(targetObj, field.getName());

					if (fieldValue != null && fieldValue.getClass() == String.class && ((String)fieldValue).contains("%")) {
						BeanUtils.setProperty(targetObj, field.getName(), fieldValue.toString().replaceAll("%", SPECIAL_CHAR));
					}
				} catch (Exception e) {
					return new Object[] { new Object[] { "vo", targetObj } };
				}
			}
		}

		return new Object[] { new Object[] { "vo", targetObj } };
	}

	@SuppressWarnings("rawtypes")
	private Object[] convertParams(Map targetMap) {
		Object[] params = new Object[targetMap.size()];
		Iterator targetMapIterator = targetMap.entrySet().iterator();
		int i = 0;
		while (targetMapIterator.hasNext()) {
			Map.Entry entry = (Map.Entry)targetMapIterator.next();
			if (entry != null && entry.getValue() != null && entry.getValue().getClass() == String.class && entry.getValue().toString().contains("%")) {
				params[i] = new Object[] { entry.getKey(), entry.getValue().toString().replaceAll("%", SPECIAL_CHAR) };
			} else {
				params[i] = new Object[] { entry.getKey(), entry.getValue() };
			}
			i++;
		}
		return params;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	private Object[] convertParams(List targetList) {
		Object[] params = new Object[targetList.size()];
		String processStr = "";
		for (int i = 0, size = targetList.size(); i < size; i++) {
			if (targetList.get(i) != null && targetList.get(i).getClass() == String.class && targetList.get(i).toString().contains("%")) {
				processStr = targetList.get(i).toString().replaceAll("%", SPECIAL_CHAR);
				targetList.remove(i);
				targetList.add(processStr);
			}
			params[i] = new Object[] { "vo" + (i + 1), targetList.get(i) };
		}
		return params;
	}

	private Object[] convertParams(Object[] targetObjArray) {
		for (int i = 0, size = targetObjArray.length; i < size; i++) {
			if (targetObjArray[i] != null && targetObjArray[i].getClass() == String.class && targetObjArray[i].toString().contains("%")) {
				targetObjArray[i] = targetObjArray[i].toString().replaceAll("%", SPECIAL_CHAR);
			}
		}
		return targetObjArray;
	}
}
