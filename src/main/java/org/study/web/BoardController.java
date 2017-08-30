package org.study.web;

import javax.inject.Inject;
import org.meeting.domain.BoardVO;
import org.meeting.service.BoardService;
import org.meeting.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Inject
	private BoardService boardService;

	@Inject
	private ReplyService replyService;

	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void boardRead(Model model, int boardno) {
		/* BoardVO vo = service.boardRead(boardno); */
		/* vo.setPhoto(vo.getPhoto().replace("s_","")); */
		/* System.out.println(vo.getPhoto()); */
		model.addAttribute(boardService.boardRead(boardno));
		model.addAttribute("replies", replyService.getRepliesByBoardNo(boardno));
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void boardRegisterGet(Model model) {
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String boardRegisterPost(BoardVO vo) {
		boardService.boardRegister(vo);
		return "redirect:/";
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public void boardModify(int boardno, Model model) {
		model.addAttribute(boardService.boardRead(boardno));
	}

	@RequestMapping(value = "/modifyComplete", method = RequestMethod.POST)
	public String boardModifyComplete(BoardVO vo) {
		boardService.boardModify(vo);
		return "redirect:/";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String boardDelete(int boardno) {
		boardService.boardDelete(boardno);
		return "redirect:/";
	}

	@ResponseBody
	@RequestMapping(value = "/heartClick", method = RequestMethod.POST)
	public ResponseEntity<String> heartClick(int boardno, String username) {

		boardService.heartClick(boardno, username);
		return new ResponseEntity<String>("success", HttpStatus.CREATED);
	}

	@ResponseBody
	@RequestMapping(value = "/heartCancle", method = RequestMethod.POST)
	public ResponseEntity<String> heartCancle(int boardno, String username) {

		boardService.heartCancle(boardno, username);
		return new ResponseEntity<String>("success", HttpStatus.CREATED);

	}

	@ResponseBody
	@RequestMapping(value = "/heartCheck", method = RequestMethod.GET)
	public ResponseEntity<String> heartCheck(int boardno, String username) {

		int heartCheck = boardService.heartCheck(boardno, username);
		
		if (heartCheck > 0)
			return new ResponseEntity<String>("check", HttpStatus.CREATED);
		else
			return new ResponseEntity<String>("noCheck", HttpStatus.CREATED);

	}

}
