package org.study.web;

import javax.inject.Inject;

import org.meeting.domain.UserVO;
import org.meeting.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
}
