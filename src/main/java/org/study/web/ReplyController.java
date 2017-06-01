package org.study.web;

import java.util.List;

import javax.inject.Inject;

import org.meeting.domain.ReplyVO;
import org.meeting.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rest/reply")
public class ReplyController {

	@Inject
	ReplyService replyService;
	
	@RequestMapping(value = "/{boardno}", method = RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> getRepliesByBoardNo(@PathVariable(value = "boardno") int boardNo) {
		
		List<ReplyVO> replies = replyService.getRepliesByBoardNo(boardNo);
		
		return new ResponseEntity<List<ReplyVO>>(replies, HttpStatus.OK);
		
	}
}
