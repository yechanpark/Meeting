package org.study.web;


import javax.inject.Inject;
import org.meeting.domain.BoardVO;
import org.meeting.service.BoardService;
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
	private BoardService service;
	
	@RequestMapping(value="/read", method = RequestMethod.GET )
	public void boardRead(Model model,int boardno){
		System.out.println("boardRead get..");
		BoardVO vo = service.boardRead(boardno);
		vo.setPhoto(vo.getPhoto().replace("s_",""));
		System.out.println(vo.getPhoto());
		model.addAttribute(vo);
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
	
	@RequestMapping(value="/modify", method= RequestMethod.POST)
	public void boardModify(int boardno,Model model){
		model.addAttribute(service.boardRead(boardno));
	}
	
	@RequestMapping(value="/modifyComplete", method= RequestMethod.POST)
	public String boardModifyComplete(BoardVO vo){
		service.boardModify(vo);
		return "redirect:/";
	}
	
	@RequestMapping(value="/delete", method= RequestMethod.POST)
	public String boardDelete(int boardno){
		service.boardDelete(boardno);
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="/heartClick", method= RequestMethod.POST)
	public ResponseEntity<String> heartClick(int boardno,String username){

		service.heartClick(boardno, username);
		return new ResponseEntity<String>("success",HttpStatus.CREATED);
	}
	
	@ResponseBody
	@RequestMapping(value="/heartCancle", method= RequestMethod.POST)
	public ResponseEntity<String> heartCancle(int boardno,String username){

		service.heartCancle(boardno, username);
		return new ResponseEntity<String>("success",HttpStatus.CREATED);
		
	}
	
	@ResponseBody
	@RequestMapping(value="/heartCheck", method= RequestMethod.GET)
	public ResponseEntity<String> heartCheck(int boardno, String username){
		
		System.out.println("check µé¾î¿È");
		int a =service.heartCheck(boardno,username);
		System.out.println(a);
		
		if(a>0){
			return new ResponseEntity<String>("check",HttpStatus.CREATED);
		}else{
			return new ResponseEntity<String>("noCheck",HttpStatus.CREATED);
		}
		
	}
	
	
	

}
