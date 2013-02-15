package com.techwin.support.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartRequest;

import com.techwin.common.service.Gridable;

public interface DownloadService extends Gridable {

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception;

	public void updateDownload(Map<String, Object> parameters, MultipartRequest multiRequest) throws Exception;

	public void deleteDownload(Map<String, Object> parameters) throws Exception;

	public void createDownload(Map<String, Object> parameters, MultipartRequest multiRequest) throws Exception;
	
	public Map<String, Object> getFileFullPath(Map<String, Object> parameters) throws Exception;
}
