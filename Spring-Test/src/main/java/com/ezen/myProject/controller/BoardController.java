package com.ezen.myProject.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.myProject.domain.BoardDTO;
import com.ezen.myProject.domain.BoardVO;
import com.ezen.myProject.domain.PagingVO;
import com.ezen.myProject.domain.UserVO;
import com.ezen.myProject.domain.fileVO;
import com.ezen.myProject.handler.FileHandler;
import com.ezen.myProject.handler.PagingHandler;
import com.ezen.myProject.repogitory.UserDAO;
import com.ezen.myProject.service.BoardService;
import com.ezen.myProject.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/board/*")
@Controller
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Inject
	private BoardService bsv;
	@Inject
	private UserDAO userDAO;
	@Inject
	private FileHandler fhd;

	@GetMapping("/register")
	public String boardRegisterGet() {
		return "/board/register";
	}

	@PostMapping("/register")
	public String register(BoardVO bvo, RedirectAttributes reAttr,
			@RequestParam(name = "files", required = false) MultipartFile[] files) {
		// 타입이 file이고 name이 files인 것, 만약에 멀티파트의 files의 값이 없어도 에러를 내지말라는 뜻
		/* , @RequestParam(name="bno")int bno */
		/* Logger.info(bvo.toString()); */
		log.info(">>> bvo register : " + bvo.toString());
		log.info(">>> files register : " + files.toString());
		List<fileVO> fList = null; // 파일의 객체를 담을 리스트 준비
		if (files[0].getSize() > 0) {// 파일의 사이즈가 0보다 크다는 것은 파일이 있다는 것
			fList = fhd.uploadFiles(files);
		} else {
			log.info("file null");
		}
		int isOk = bsv.register(new BoardDTO(bvo, fList));
		reAttr.addFlashAttribute("isOk", isOk > 0 ? "1" : "0");
		log.info("board register >> " + (isOk > 0 ? "OK" : "FAIL"));
		return "redirect:/board/list";
	}

	@GetMapping("/list")
	public String list(Model model, PagingVO pgvo) {
		/* int totalCount = bsv.totalCount(); */
		int searchTotalCount = bsv.searchTotalCount(pgvo);
		int qty = pgvo.getQty();
		List<BoardVO> list = bsv.getList(pgvo);

		model.addAttribute("list", list);

		PagingHandler ph = new PagingHandler(pgvo, searchTotalCount);
		model.addAttribute("pgh", ph);
		return "/board/list";
	}

	@GetMapping({ "/detail", "/modify" })
	public void detail(Model model, @RequestParam("bno") int bno) {
		BoardDTO bdto = bsv.getDetailFile(bno);

		log.info(">>> bdto.bvo : " + bdto.getBvo().toString());

		// bdto 객체로 보내게 되면 jsp에서 오류 발생
		model.addAttribute("bvo", bdto.getBvo());
		model.addAttribute("fList", bdto.getFList());
		// 매핑주소와 리턴주소가 일치한다면 리턴이 없어도 됨. 그럴 경우 void로 만들기
	}

	@PostMapping("/modify")
	public String modify(RedirectAttributes reAttr, BoardVO bvo,
			@RequestParam(name = "files", required = false) MultipartFile[] files) {
		log.info("modify >>> :" + bvo.toString());
		UserVO user = userDAO.getUser(bvo.getWriter());
		List<fileVO> fList = null;
		if (files[0].getSize() > 0) {
			fList = fhd.uploadFiles(files);
		}
		int isUp = bsv.modify(new BoardDTO(bvo, fList), user);

		log.info(isUp > 0 ? "ok" : "fail");
		reAttr.addFlashAttribute(isUp > 0 ? "1" : "0");
		return "redirect:/board/list";
	}

	@GetMapping("/remove")
	public String remove(RedirectAttributes reAttr, @RequestParam("bno") int bno, HttpServletRequest req) {
		/*
		 * 1. HttpSession ses = req.getSession(); UserVO user =
		 * (UserVO)ses.getAttribute("ses");
		 */

		/*
		 * 2. UserVO user =
		 * userDAO.getUser((userVO)req.getSession().getAttribute("ses")); UserVO user
		 * =usv.getUser(req);
		 */
		int isOk = bsv.getdelete(bno);
		log.info("delete >>> " + (isOk > 0 ? "성공" : "실패"));
		return "redirect:/board/list";
	}

	@DeleteMapping(value = "/file/{uuid}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> removeFile(@PathVariable("uuid")String uuid){		
		return bsv.deleteFile(uuid) > 0 ? 
				new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}

/*
 * Model은 스프링이 지원하는 기능으로써, key와 value로 이루어져있는 HashMap이다. Model의 .addAttribute()를
 * 통해 view에 전달할 데이터를 저장할 수 있다. Servlet의 request.setAttribute()와 비슷한 역할을 한다.
 */

/*
 * db가 수정사항이 일어나면 (insert, update, delete) 수정이 반영된 것을 보여줘야하는데 그럴때 사용하는것이
 * redirect
 */

/*
 * addAttribute는 GET 방식이며 페이지를 새로고침 한다 해도 값이 유지된다. addFlashAttribute는 POST 방식이며
 * 이름처럼 일회성 데이터라 새로고침 하면 값이 사라진다.
 */