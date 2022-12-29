package com.ezen.myProject.repogitory;

import java.util.List;

import com.ezen.myProject.domain.CommentVO;

public interface CommentDAO {

	int insertComment(CommentVO cvo);

	List<CommentVO> list(int bno);

	int update(CommentVO cvo);

	int delete(int cno);

	
}
