package com.ezen.myProject.service;

import java.util.List;

import com.ezen.myProject.domain.BoardDTO;
import com.ezen.myProject.domain.BoardVO;
import com.ezen.myProject.domain.PagingVO;
import com.ezen.myProject.domain.UserVO;
import com.ezen.myProject.handler.PagingHandler;

public interface BoardService {

	int register(BoardVO bvo);

	List<BoardVO> getList();

	BoardVO getDetail(int bno);

	int modify(BoardVO bvo, UserVO user);

	int getdelete(int bno);

	List<BoardVO> getList(PagingVO pvo);

	int totalCount();

	List<BoardVO> getList(PagingHandler ph);

	int searchTotalCount(PagingVO pgvo);

	int register(BoardDTO bDTO);

	BoardDTO getDetailFile(int bno);

	int modify(BoardDTO bdto, UserVO user);

	int deleteFile(String uuid);
}
