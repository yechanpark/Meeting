package org.study.web;

import java.util.Locale;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.meeting.service.BoardService;
import org.meeting.service.MailService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Inject
	private MailService mailService;
	
	@Inject
	BoardService service;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {

		model.addAttribute("boardList",service.boardList());
		
		return "home";
	}
	@ResponseBody
	@RequestMapping(value = "/sendMail/auth", method = RequestMethod.POST)
    public ResponseEntity<String> sendMailAuth(HttpSession session) {
    	String email = "ehdrylang@naver.com";
		int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
        String joinCode = String.valueOf(ran);
        String subject = "회원가입 인증 코드 발급 안내 입니다.";
        StringBuilder sb = new StringBuilder();
        sb.append("귀하의 인증 코드는 [" + joinCode + "] 입니다.");
        if(mailService.send(subject, sb.toString(), "hansungmeeting@gmail.com", email, null))
		return new ResponseEntity<>(joinCode,HttpStatus.CREATED);
        else{
        	return new ResponseEntity<>("Fail",HttpStatus.BAD_REQUEST);
        }
    }
    
	
}
