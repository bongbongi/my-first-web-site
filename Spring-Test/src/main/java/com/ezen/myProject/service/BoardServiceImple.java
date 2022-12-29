package com.ezen.myProject.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.springframework.stereotype.Service;

import com.ezen.myProject.domain.BoardDTO;
import com.ezen.myProject.domain.BoardVO;
import com.ezen.myProject.domain.PagingVO;
import com.ezen.myProject.domain.UserVO;
import com.ezen.myProject.domain.fileVO;
import com.ezen.myProject.handler.PagingHandler;
import com.ezen.myProject.repogitory.BoardDAO;
import com.ezen.myProject.repogitory.FileDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImple implements BoardService {

	@Inject
	private BoardDAO bdao;
	@Inject
	private FileDAO fdao;

	@Override
	public int register(BoardVO bvo) {
		
		return bdao.insertBoard(bvo);
	}

	@Override
	public List<BoardVO> getList() {
		return bdao.selectBoardList();
	}

	@Override
	public BoardVO getDetail(int bno) {
		bdao.readCountUp(bno);
		return bdao.getDetail(bno);
	}

	@Override
	public int modify(BoardVO bvo, UserVO user) {
		log.info(">>> board modify check2");
		BoardVO tmpBoard = bdao.getDetail(bvo.getBno());
		log.info("tmpBoard : "+tmpBoard.toString());
		/* log.info("user : "+user.toString()); */
		if(user ==null || !user.getId().equals(tmpBoard.getWriter())) {
			return 0;
		}
		return bdao.updateBoard(bvo);
	}

	@Override
	public int getdelete(int bno) {
		return bdao.getdelete(bno);
	}

	@Override
	public List<BoardVO> getList(PagingVO pvo) {
		log.info(">>> PagingVO list check2");
		return bdao.selectBoardListPaging(pvo);
	}

	@Override
	public int totalCount() {
		return bdao.totalCount();
	}

	@Override
	public List<BoardVO> getList(PagingHandler ph) {
		return bdao.pageList(ph);
	}

	@Override
	public int searchTotalCount(PagingVO pgvo) {
		return bdao.searchTotalCount(pgvo);
	}

	@Override
	public int register(BoardDTO bDTO) {
		int isOk = bdao.insertBoard(bDTO.getBvo()); //기존 게시글에 대한 내용을 db에 저장 bdao
		//지금 상황에서 bno가 결정되기 전이기때문에 bno를 가져올 수 없음
		if(isOk>0 && bDTO.getFList().size()>0) {
			int bno = bdao.selectOneBno(); //방금 넣었던 bvo 객체가 db에 저장된 후. bno 마지막 번호(큰 번호)를 가져오면 됨
			for(fileVO fvo : bDTO.getFList()) {
				fvo.setBno(bno);
				log.info(" insert file : "+fvo.toString());
				isOk *= fdao.insertFile(fvo);
			}
		}
		return 0;
	}

	@Override
	public BoardDTO getDetailFile(int bno) {
		bdao.readCountUp(bno);  //detail 클릭시 조회수 증가
		BoardDTO bdto = new BoardDTO(bdao.getDetail(bno), fdao.selectFileList(bno));
		return bdto;
	}

	@Override
	public int modify(BoardDTO bdto, UserVO user) {
		log.info(">>> board modify check2");
		//글쓴이와, id가 일치하는지 비교
		BoardVO tmpBoard = bdao.getDetail(bdto.getBvo().getBno());
		log.info("tmpBoard : "+tmpBoard.toString());
		if(user ==null || !user.getId().equals(tmpBoard.getWriter())) {
			return 0;
		}
		//수정
		int isUp = bdao.updateBoard(bdto.getBvo());//bvo의 내용 업데이트
		if(isUp > 0 && bdto.getFList().size()>0) {
			int bno = bdto.getBvo().getBno();
			log.info("board modify bno 확인 : "+ bno);
			for(fileVO fvo : bdto.getFList()) {
				fvo.setBno(bno);
				isUp *= fdao.insertFile(fvo); //추가한 파일을 추가
				//삭제 기능은 별도로 만들 예정임 
			}
		}
		return isUp; 
	}

	@Override
	public int deleteFile(String uuid) {
		return fdao.delete(uuid);
	}
	
	

}
