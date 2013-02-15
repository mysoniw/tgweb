package com.techwin.support.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.techwin.common.util.FileUploadUtil;
import com.techwin.support.service.DownloadService;

@Service("downloadService")
public class DownloadServiceImpl implements DownloadService {
	
	@Inject
	@Named("downloadDao")
	private DownloadDao dao;
	
	@Inject
	protected PropertiesFactoryBean prop;

	public List<Map<String, Object>> getGridList(Map<String, Object> parameters) throws Exception {
		return dao.getDownloadList(parameters);
	}

	public void updateDownload(Map<String, Object> parameters, MultipartRequest multiRequest) throws Exception {

		this.fileUpload(parameters, multiRequest);
		dao.updateDownload(parameters);
	}
	
	public void deleteDownload(Map<String, Object> parameters) throws Exception {
		dao.deleteDownload(parameters);
	}
	
	public void createDownload(Map<String, Object> parameters, MultipartRequest multiRequest) throws Exception {
		this.fileUpload(parameters, multiRequest);
		dao.createDownload(parameters);
	}
	
	public Map<String, Object> getFileFullPath(Map<String, Object> parameters) throws Exception {
		return dao.getFileFullPath(parameters);
	}
	
	private Map<String, Object> fileUpload(Map<String, Object> parameters, MultipartRequest multiRequest) throws Exception {
		MultipartFile file = multiRequest.getFile("FILE");
		
		if (!"".equals(file.getOriginalFilename())) {
			String svrFileName = FileUploadUtil.fileUpload(prop.getObject().getProperty("support.file.path"), file.getOriginalFilename(), file);
			
			parameters.put("FILE_SIZE", file.getSize());
			parameters.put("FILE_NAME", file.getOriginalFilename());
			parameters.put("SVR_FILE_NAME", svrFileName);
		}
		
		return parameters;
	}
}
