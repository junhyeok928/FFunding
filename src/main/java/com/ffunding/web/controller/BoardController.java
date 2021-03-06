package com.ffunding.web.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ffunding.web.service.BoardService;
import com.ffunding.web.vo.BoardVO;
import com.ffunding.web.vo.Criteria;
import com.ffunding.web.vo.PageMaker;
import com.ffunding.web.vo.SearchCriteria;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	// Board Controller (공지사항)
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Inject
	BoardService service;
	
	// 게시판 글 작성 화면
	@RequestMapping(value = "/board/writeView", method = RequestMethod.GET)
	public String writeView() throws Exception {
		logger.info("writeView");

		return "board/writeView.page";
	}

	// 게시판 글 작성
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String write(BoardVO boardVO, MultipartHttpServletRequest mpRequest, MultipartFile file) throws Exception {
		logger.info("write" + boardVO.getTitle());
		logger.info("write" + boardVO.getContent());
		logger.info("write" + boardVO.getWriter());

		service.write(boardVO, mpRequest);

		return "redirect:/board/list";
	}

	// 게시판 목록 조회
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception {
		logger.info("list");

		model.addAttribute("list", service.list(scri));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));

		model.addAttribute("pageMaker", pageMaker);

		return "board/list.page";

	}

	// 게시판 조회
	@RequestMapping(value = "/readView", method = RequestMethod.GET)
	public String read(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
		logger.info("read");

		model.addAttribute("read", service.read(boardVO.getBno()));
		model.addAttribute("scri", scri);

		List<Map<String, Object>> fileList = service.selectFileList(boardVO.getBno());
		model.addAttribute("file", fileList);
		return "board/readView.page";

	}

	// 게시판 수정뷰
	@RequestMapping(value = "/updateView", method = RequestMethod.GET)
	public String updateView(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri, Model model)
			throws Exception {
		logger.info("updateView");

		model.addAttribute("update", service.read(boardVO.getBno()));
		model.addAttribute("scri", scri);

		List<Map<String, Object>> fileList = service.selectFileList(boardVO.getBno());
		model.addAttribute("file", fileList);

		return "board/updateView.page";
	}

	// 게시판 수정
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr,
			@RequestParam(value = "fileNoDel[]") String[] files,
			@RequestParam(value = "fileNameDel[]") String[] fileNames, MultipartHttpServletRequest mpRequest)
			throws Exception {
		logger.info("update");
		service.update(boardVO, files, fileNames, mpRequest);

		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());

		return "redirect:/board/list";
	}

	// 게시판 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr)
			throws Exception {
		logger.info("delete");

		service.delete(boardVO.getBno());

		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());

		return "redirect:/board/list";
	}

	
	// 첨부파일 다운로드
	@RequestMapping(value = "/fileDown")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception {
		Map<String, Object> resultMap = service.selectFileInfo(map);
		String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
		String originalFileName = (String) resultMap.get("ORG_FILE_NAME");

		// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
		byte fileByte[] = org.apache.commons.io.FileUtils
				.readFileToByteArray(new File("C:\\funding\\file\\" + storedFileName));

		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();

	}

}