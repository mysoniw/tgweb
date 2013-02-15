package com.techwin.support.web;

import java.io.File;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.techwin.common.constants.RequestConstants;
import com.techwin.common.util.RequestUtil;
import com.techwin.security.domain.CustomUser;
import com.techwin.support.service.BoardService;

@Controller
public class BoardController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	BoardService boardService;
	
	@Inject
	protected PropertiesFactoryBean prop;

	@RequestMapping(value = "/supBoard.do", params = RequestConstants.LIST)
	public String getBoardList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nboard 리스트\n");
		
		return "supBoard";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/supBoard.do", params = RequestConstants.SEARCH)
	public void getBoardList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nboard 리스트 검색\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		RequestUtil.responseWithJson(response, boardService.getBoardList(parameterMap));
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/supBoard.do", params = RequestConstants.READ)
	public void getBoardContents(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nboard 본문\n");
		
		RequestUtil.responseWithJson(response, boardService.selectBoard(RequestUtil.bindParameterToMap(request.getParameterMap())));
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/supBoard.do", params = RequestConstants.CREATE)
	public String createBoard(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nboard 새글 작성\n");
	
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		model.addAttribute("params", parameterMap);
		
		return "supBoardWrite";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/supBoard.do", params = RequestConstants.CREATE_PROCESS)
	public void createProcessBoard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nboard 새글 작성 처리\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		Map<String, Object> returnMap = null;
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		parameterMap.put("userId", user.getEmail());
		parameterMap.put("userName", user.getUserName());
		
		if (parameterMap.get("useHtml") == null)	parameterMap.put("useHtml", 0);
		if (parameterMap.get("useAutoBr") == null)	parameterMap.put("useAutoBr", 0);
		
		int thread = Integer.parseInt((String)parameterMap.get("thread"));
		int depth = Integer.parseInt((String)parameterMap.get("depth"));
		
		if (thread > 0) {
			parameterMap.put("prevThread", (thread - 1) / 1000 * 1000);
			parameterMap.put("depth", depth + 1);
			returnMap = boardService.createBoardReply(parameterMap);
		} else {
			returnMap = boardService.createBoard(parameterMap);
		}
		
		RequestUtil.responseWithJson(response, returnMap);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/supBoard.do", params = RequestConstants.UPDATE_PROCESS)
	public void updateBoard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nboard 본문 수정 처리\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		if (parameterMap.get("useHtml") == null)	parameterMap.put("useHtml", 0);
		if (parameterMap.get("useAutoBr") == null)	parameterMap.put("useAutoBr", 0);
		
		boardService.updateBoard(parameterMap);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/supBoard.do", params = RequestConstants.DELETE)
	public void deleteBoard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nboard 본문 삭제 처리\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		boardService.deleteBoard(parameterMap);
	}

// ############ COMMENT #############
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/supBoard.do", params = "method=comment")
	public void getBoardComment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nboard comment 목록\n");
		
		RequestUtil.responseWithJson(response, boardService.selectBoardComment(RequestUtil.bindParameterToMap(request.getParameterMap())));
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/supBoard.do", params = "method=commentCreate")
	public void createProcessBoardComment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nboard comment 신규 등록\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		parameterMap.put("userId", user.getEmail());
		parameterMap.put("userName", user.getUserName());
		
		boardService.createProcessBoardComment(parameterMap);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/supBoard.do", params = "method=commentDelete")
	public void deleteBoardComment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nboard comment 삭제\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		boardService.deleteBoardComment(parameterMap);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/supBoard.do", params = "method=fileList")
	public void getFileList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		logger.debug("\nboard file 목록\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		RequestUtil.responseWithJson(response, boardService.getFileList(parameterMap));
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/trusted/supBoard.do", params = "method=upload")
	public ModelAndView createFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nboard upload\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		boardService.createFile(parameterMap, (MultipartHttpServletRequest)request);
		
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("uploadResult", "aaa");

		return mav;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/supBoard.do", params = "method=fileDelete")
	public void deleteFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("\nboard file 삭제\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		boardService.deleteFile(parameterMap);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/supBoard.do", params = RequestConstants.FILE)
	public ModelAndView getFileFullPath(Map<String, Object> map, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		logger.debug("\nboard download\n");
		
		Map<String, Object> parameterMap = RequestUtil.bindParameterToMap(request.getParameterMap());
		map = boardService.getFileFullPath(parameterMap);
		
		File file = new File(prop.getObject().getProperty("support.board.file.path") + "/" + (String)map.get("svrFileName"));
		
		ModelAndView mv = new ModelAndView("download", "downloadFile", file);
		mv.addObject("FILE_NAME", map.get("fileName"));
		
		return mv;
	}
}
