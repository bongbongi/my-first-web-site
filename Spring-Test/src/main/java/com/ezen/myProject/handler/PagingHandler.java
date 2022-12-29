package com.ezen.myProject.handler;

import com.ezen.myProject.domain.PagingVO;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class PagingHandler {
	private int startPage; //현재화면에서 보여줄 시작 페이지네이션 번호
	private int endPage; //현재화면에서 보여줄 마지막 페이지네이션 번호
	private boolean prev, next; // 이전, 다음 페이지 여부
	//총10개씩 출력 ->  1 2 3 4 5 6 7 8 9 10 next
	//				 prev 11 12 13 14 ... 20 next
	//				 prev 21 22
	
	private int totalCount ; // 전체 게시글 수
	private PagingVO pgvo;
	
	public PagingHandler(PagingVO pgvo, int totalCount) {
		this.pgvo=pgvo;
		this.totalCount=totalCount;
		this.endPage= // 1~10까지는 10의 값의 되도록 설정
				(int)(Math.ceil(pgvo.getPageNo()/(pgvo.getQty()*1.0)))*pgvo.getQty(); 
		this.startPage=endPage-9; // 10-9=1페이지 , 20-9=11페이지 
		
		int realEndPage = (int)Math.ceil(totalCount*1.0/pgvo.getQty());
		
		if(realEndPage < this.endPage) {
			this.endPage=realEndPage; // 최종페이지가 22일때 이후 페이지네이션번호가 출력되면 안되기때문에.
		}
		this.prev=this.startPage>1;
		this.next=this.endPage<realEndPage; 
	}
}
