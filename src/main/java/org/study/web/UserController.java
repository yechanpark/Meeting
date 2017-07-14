package org.study.web;

import java.util.List;

import javax.inject.Inject;

import org.meeting.domain.BoardVO;
import org.meeting.domain.UserVO;
import org.meeting.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user/*")
public class UserController {
	@Inject
	private UserService service;
	

	@RequestMapping(value="/signup" ,method=RequestMethod.GET)
	public void registerGET(UserVO vo, Model model)throws Exception{
		
	}
	@RequestMapping(value="/signup", method=RequestMethod.POST)
	public String registPOST(UserVO vo, RedirectAttributes rttr)throws Exception{
		service.regist(vo);	
		rttr.addFlashAttribute("msg","success");
		return "redirect:/";
	}
	
	
	@RequestMapping(value="/mypage",method=RequestMethod.GET)
	   public String mypage(Model model)throws Exception{
	      System.out.println("마이페이지 로드");
	      Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	      String onUser = authentication.getName();
	      System.out.println(service.read(onUser));
	      model.addAttribute("userinfo", service.read(onUser));
	      return "/user/mypage";
	   }
	
	  @ResponseBody
	  @RequestMapping(value="/myImageDatabaseUpload",method=RequestMethod.POST)
	  public ResponseEntity<String> myImageDatabaseUpload(String fileName, String username){
		  System.out.println("user 프로필 사진 교체중 ");
		  service.myImageDatabaseUpload(fileName,username);
		  return new ResponseEntity<String>("success",HttpStatus.CREATED);
	  }
	  
	  @ResponseBody
	  @RequestMapping(value="/myBoardConfirm",method=RequestMethod.POST)
	  public ResponseEntity<List<BoardVO>> myBoardConfirm(String username){
		  
		  System.out.println("내 게시물 확인");
		  System.out.println(username);
		  System.out.println(service.myBoardConfirm(username));
		  return new ResponseEntity<List<BoardVO>>(service.myBoardConfirm(username),HttpStatus.CREATED);
	  }
	  
	  
	  @ResponseBody
	  @RequestMapping(value="/myReplyConfirm",method=RequestMethod.POST)
	  public ResponseEntity<List<BoardVO>> myReplyConfirm(String username){
		  System.out.println("내 게시물 확인");
		  System.out.println(username);
		  return new ResponseEntity<List<BoardVO>>(service.myReplyConfirm(username),HttpStatus.CREATED);
	  }
	
	  
	  
}
