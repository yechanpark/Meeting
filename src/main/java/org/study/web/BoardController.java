package org.study.web;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.meeting.domain.BoardVO;
import org.meeting.service.BoardService;
import org.meeting.util.UploadFileUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	
	
	@Inject
	private BoardService service;
	

	
	@RequestMapping(value="/read", method = RequestMethod.GET )
	public void boardRead(Model model,int boardno){
		System.out.println("boardRead get..");
		model.addAttribute(service.boardRead(boardno));
	}
	
	@RequestMapping(value="/register", method = RequestMethod.GET)
	public void boardRegisterGet(Model model){
		System.out.println("boardRegister get..");
		
	}
	
	@RequestMapping(value="/register", method= RequestMethod.POST)
	public String boardRegisterPost(BoardVO vo){
		
		System.out.println("boardRegister post..");
		System.out.println(vo);
		service.boardRegister(vo);
		return "redirect:/";
	}
	

}
