package com.techwin.support.service.impl;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.techwin.common.util.FileUploadUtil;
import com.techwin.support.service.BoardService;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	@Inject
	@Named("boardDao")
	private BoardDao dao;
	
//	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	protected PropertiesFactoryBean prop;

	public Map<String, Object> getBoardList(Map<String, Object> parameters) throws Exception {
		return dao.getBoardList(parameters);
	}
	
	public Map<String, Object> selectBoard(Map<String, Object> parameters) throws Exception {
		return dao.selectBoard(parameters);
	}
	
	public Map<String, Object> createBoard(Map<String, Object> parameters) throws Exception {
		return dao.createBoard(parameters);
	}
	
	public Map<String, Object> createBoardReply(Map<String, Object> parameters) throws Exception {
		return dao.createBoardReply(parameters);
	}

	public void updateBoard(Map<String, Object> parameters) throws Exception {
		dao.updateBoard(parameters);
	}
	
	public void deleteBoard(Map<String, Object> parameters) throws Exception {
		dao.deleteBoard(parameters);
	}
	
	public List<Map<String, Object>> selectBoardComment(Map<String, Object> parameters) throws Exception {
		return dao.selectBoardComment(parameters);
	}
	
	public void createProcessBoardComment(Map<String, Object> parameters) throws Exception {
		dao.createProcessBoardComment(parameters);
	}
	
	public void deleteBoardComment(Map<String, Object> parameters) throws Exception {
		dao.deleteBoardComment(parameters);
	}
	
	public List<Map<String, Object>> getFileList(Map<String, Object> parameters) throws Exception {
		return dao.getFileList(parameters);
	}
	
	public void createFile(Map<String, Object> parameters, MultipartRequest multiRequest) throws Exception {
		this.fileUpload(parameters, multiRequest);
		dao.createFile(parameters);
	}
	
	public void deleteFile(Map<String, Object> parameters) throws Exception {
		dao.deleteFile(parameters);
	}
	
	public Map<String, Object> getFileFullPath(Map<String, Object> parameters) throws Exception {
		return dao.getFileFullPath(parameters);
	}
	
	private Map<String, Object> fileUpload(Map<String, Object> parameters, MultipartRequest multiRequest) throws Exception {
		String fileName = null;
		MultipartFile file = null;
		long fileSize = 0L;
		
		Map<String, MultipartFile> fileMap = multiRequest.getFileMap();
		
		Iterator<Map.Entry<String, MultipartFile>> it = fileMap.entrySet().iterator();
		
		while (it.hasNext()) {
			
			Map.Entry<String, MultipartFile> entry = it.next();
			file = entry.getValue();
			
			fileName = file.getOriginalFilename();
			fileSize = file.getSize();
		}
		
		String svrFileName = FileUploadUtil.fileUpload(prop.getObject().getProperty("support.board.file.path"), fileName, file);
		
		parameters.put("fileName", fileName);
		parameters.put("svrFileName", svrFileName);
		parameters.put("fileSize", fileSize);
		
		return parameters;
	}
}
