package com.techwin.support.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartRequest;

public interface BoardService {

	public Map<String, Object> getBoardList(Map<String, Object> parameters) throws Exception;
	
	public Map<String, Object> selectBoard(Map<String, Object> parameters) throws Exception;

	public Map<String, Object> createBoard(Map<String, Object> parameters) throws Exception;
	
	public Map<String, Object> createBoardReply(Map<String, Object> parameters) throws Exception;

	public void updateBoard(Map<String, Object> parameters) throws Exception;

	public void deleteBoard(Map<String, Object> parameters) throws Exception;

	public List<Map<String, Object>> selectBoardComment(Map<String, Object> parameters) throws Exception;
	
	public void createProcessBoardComment(Map<String, Object> parameters) throws Exception;
	
	public void deleteBoardComment(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> getFileList(Map<String, Object> parameters) throws Exception;
	
	public void createFile(Map<String, Object> parameters, MultipartRequest multiRequest) throws Exception;

	public void deleteFile(Map<String, Object> parameters) throws Exception;
	
	public Map<String, Object> getFileFullPath(Map<String, Object> parameters) throws Exception;
}
