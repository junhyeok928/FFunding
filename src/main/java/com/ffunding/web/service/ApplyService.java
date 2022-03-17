package com.ffunding.web.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ffunding.web.vo.ApplyVO;

public interface ApplyService {

	// 게시글 작성
	public void write(ApplyVO applyVO, MultipartHttpServletRequest mpRequest) throws Exception;
	
	// 게시물 목록 조회
	public List<ApplyVO> list() throws Exception;
	
	// 게시물 조회
	public ApplyVO read(int fid) throws Exception;
	
	// 게시물 수정
	public void update(ApplyVO applyVO) throws Exception;
	
	// 게시물 삭제
	public void delete(int fid) throws Exception;
}
