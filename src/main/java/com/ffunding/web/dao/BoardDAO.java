package com.ffunding.web.dao;

import com.ffunding.web.vo.BoardVO;

public interface BoardDAO {

	// 게시글 작성
	public void write(BoardVO boardVO) throws Exception;
}