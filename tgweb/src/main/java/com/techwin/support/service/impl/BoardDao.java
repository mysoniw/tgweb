package com.techwin.support.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.techwin.common.dao.TgWebDao;

@Repository("boardDao")
public class BoardDao extends TgWebDao {

	@SuppressWarnings("unchecked")
	public Map<String, Object> getBoardList(Map<String, Object> parameters) throws Exception {
		return (Map<String, Object>)super.getQueryService().execute("BoardDao.findAll", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoard(Map<String, Object> parameters) throws Exception {
		if ("true".equals(parameters.get("updateReadCount")))	super.update("BoardDao.readCount", parameters);
		return (Map<String, Object>)super.findByPk("BoardDao.find", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> createBoard(Map<String, Object> parameters) throws Exception {
		return super.getQueryService().execute("BoardDao.create", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> createBoardReply(Map<String, Object> parameters) throws Exception {
		return super.getQueryService().execute("BoardDao.createReply", parameters);
	}

	public void updateBoard(Map<String, Object> parameters) throws Exception {
		super.getQueryService().execute("BoardDao.update", parameters);
	}
	
	public void deleteBoard(Map<String, Object> parameters) throws Exception {
		super.update("BoardDao.delete", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardComment(Map<String, Object> parameters) throws Exception {
		return (List<Map<String, Object>>)super.findList("BoardDao.findAllComment", parameters);
	}
	
	public void createProcessBoardComment(Map<String, Object> parameters) throws Exception {
		super.getQueryService().execute("BoardDao.createComment", parameters);
	}
	
	public void deleteBoardComment(Map<String, Object> parameters) throws Exception {
		super.getQueryService().execute("BoardDao.deleteComment", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getFileList(Map<String, Object> paramters) throws Exception {
		return (List<Map<String, Object>>)super.findList("BoardDao.fileList", paramters);
	}
	
	public void createFile(Map<String, Object> parameters) throws Exception {
		super.create("BoardDao.createFile", parameters);
	}
	
	public void deleteFile(Map<String, Object> parameters) throws Exception {
		super.create("BoardDao.deleteFile", parameters);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getFileFullPath(Map<String, Object> parameters) throws Exception {
		return (Map<String, Object>)super.findByPk("BoardDao.findFile", parameters);
	}
}
