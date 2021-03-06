package com.ffunding.web.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ffunding.web.service.ApplyService;
import com.ffunding.web.vo.ApplyVO;
import com.ffunding.web.vo.Criteria;
import com.ffunding.web.vo.MemberVO;
import com.ffunding.web.vo.PageMaker;
import com.ffunding.web.vo.SearchCriteria;

@Controller
@RequestMapping("/apply/*")
public class ApplyController {
	
	// 펀딩 신청 Controller
	
	private static final Logger logger = LoggerFactory.getLogger(ApplyController.class);
	
	@Inject
	ApplyService service;

	// 게시판 글 작성 화면
	@RequestMapping(value = "/apply/writeView", method = RequestMethod.GET)
	public String writeView() throws Exception {
		logger.info("writeView");
		
		return "apply/writeView.page";
	}
	
	// 게시판 글 작성
	@RequestMapping(value = "/apply/write", method = RequestMethod.POST)
	public String write(ApplyVO applyVO, MultipartHttpServletRequest mpRequest) throws Exception{
		logger.info("write");
		
		service.write(applyVO, mpRequest);
		
		return "redirect:/";
	}	
	
	// 게시판 목록 조회
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, @ModelAttribute("scri") SearchCriteria scri, HttpServletRequest request, MemberVO memberVO) throws Exception{
		logger.info("list");
		
		HttpSession session = request.getSession();
		
		MemberVO mb = (MemberVO)session.getAttribute("member");
		
		String mid = mb.getMid();

		scri.setMid(mb.getMid());
		
		model.addAttribute("list",service.list(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		
		session.setAttribute("sessionId", mid);
		
		return "apply/list.page";
		
	}
	
	// 게시판 조회
	@RequestMapping(value = "/readView", method = RequestMethod.GET)
	public String read(ApplyVO applyVO, Model model) throws Exception{
		logger.info("read");
		
		model.addAttribute("read", service.read(applyVO.getFid()));
		
		List<Map<String, Object>> fileList = service.selectFileList(applyVO.getFid());
		model.addAttribute("file", fileList);
		
		return "apply/readView.page";
	}
	
	// 게시판 수정뷰
	@RequestMapping(value = "/updateView", method = RequestMethod.GET)
	public String updateView(ApplyVO applyVO, Model model) throws Exception{
		logger.info("updateView");
		
		model.addAttribute("update", service.read(applyVO.getFid()));
		
		return "apply/updateView.page";
	}
	
	// 게시판 수정
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(ApplyVO applyVO) throws Exception{
		logger.info("update");
		
		service.update(applyVO);
		
		return "redirect:/apply/list";
	}

	// 게시판 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(ApplyVO applyVO) throws Exception{
		logger.info("delete");
		
		service.delete(applyVO.getFid());
		
		return "redirect:/apply/list";
	}
	
	// 첨부파일 다운로드
	@RequestMapping(value="/fileDown")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception{
		Map<String, Object> resultMap = service.selectFileInfo(map);
		String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
		String originalFileName = (String) resultMap.get("ORG_FILE_NAME");
		
		// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\a01_javaexp\\workspace\\ffunding\\src\\main\\webapp\\resources\\applyimage\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
		
	}
}
