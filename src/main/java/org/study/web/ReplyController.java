package org.study.web;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.meeting.domain.ReplyRelationVO;
import org.meeting.domain.ReplyVO;
import org.meeting.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import net.sf.json.JSONObject;

@RestController
@RequestMapping("/rest/reply")
public class ReplyController {

	@Inject
	ReplyService replyService;

	// AJAX에서 요청한 댓글목록 반환
	@RequestMapping(value = "/{boardno}", method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getRepliesByBoardNo(@PathVariable(value = "boardno") int boardNo) {
		System.out.println("GET 호출");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();

		System.out.println("username(로그인유저이름) :" + username);
		System.out.println("boardNo(게시판번호) :" + boardNo);
		
		// 게시판번호, username으로 1차 댓글 번호를 구함
		int parentno = replyService.getParentNoByBoardNo(boardNo, username);
		System.out.println("parentno(1차댓글번호) :" + parentno);

		// 1차 댓글 번호로 여기에 딸린 자식댓글(N개) + 부모댓글(1개)구해옴
		List<ReplyVO> allReplies = replyService.getAllRepliesByParentNo(parentno);
		System.out.println("childReplies(자식댓글들) :" + allReplies.toString());

		// 게시물에 있는 1차 댓글의 총 갯수
		int parentRepliesCount = replyService.getRepliesCountByBoardNo(boardNo, username);
		System.out.println("parentsRepliesCount(1차댓글 총 갯수) :" + parentRepliesCount);

		JSONObject response = new JSONObject();
		response.put("secretReplyCount", parentRepliesCount-1);
		response.put("replies", allReplies);
		System.out.println("response(ajax로 보내는 최종 결과) :" + response.toString());
		
		return new ResponseEntity<JSONObject>(response, HttpStatus.OK);
	}

	// AJAX에서 요청한 댓글등록 처리
	@RequestMapping(value = "/{boardno}", method = RequestMethod.POST)
	public ResponseEntity<Void> addReply(@RequestBody Map<String, Object> data, @PathVariable(value = "boardno") int boardNo) throws Exception {
		System.out.println("POST 호출");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		JSONObject replyJSON = JSONObject.fromObject(data.get("reply"));

		// 이미 내가 단 1차 댓글이 있는 경우 이미 있으므로 오류
		if( replyService.isExistMyParentReply(boardNo, username) ){
			System.out.println("아아 이미 존재한다");
			return new ResponseEntity<Void>(HttpStatus.CONFLICT);
		}
		System.out.println("아아 존재하지 않다");
		ReplyVO reply = new ReplyVO();
		reply.setBoardno(replyJSON.getInt("boardno"));
		reply.setContent(replyJSON.getString("content"));
		reply.setUsername(replyJSON.getString("username"));

		replyService.addReply(reply);

		return new ResponseEntity<Void>(HttpStatus.OK);
	}
}