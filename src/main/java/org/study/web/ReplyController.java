package org.study.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.meeting.domain.ReplyVO;
import org.meeting.service.BoardService;
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

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/rest/reply")
public class ReplyController {

	@Inject
	ReplyService replyService;

	@Inject
	BoardService boardService;

	// AJAX에서 요청한 댓글목록 반환
	@RequestMapping(value = "/{boardno}", method = RequestMethod.GET)
	public ResponseEntity<JSONObject> getRepliesByBoardNo(@PathVariable(value = "boardno") int boardNo,
			String boardHolder) {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String loginName = authentication.getName();

		// 해당 게시물에 달린 모든 1차 댓글을 얻어옴
		List<ReplyVO> parentReplies = replyService.getParentReplies(boardNo);

		// 해당 게시물에 댓글이 1개도 없으면 NO_CONTENT(204)
		if (parentReplies.size() == 0)
			return new ResponseEntity<JSONObject>(HttpStatus.NO_CONTENT);

		// 해당 게시물에 댓글이 1개 이상 있으면 아래 수행
		JSONArray replies = new JSONArray();
		int secretReplyCount = 0;
		
		// 모든 1차 댓글을 돌면서
		for (ReplyVO reply : parentReplies) {
			System.out.println("parentReplies사이즈 : " + parentReplies.size());
			JSONObject jsonParentReply = new JSONObject();

			// 2차 댓글 컨테이너
			List<ReplyVO> childReplies = new ArrayList<ReplyVO>();
			// 로그인한 유저(제 1자)가 쓴 글이 아니면
			if (!loginName.equals(boardHolder)) {
				
				// 로그인한 유저가 쓴 댓글이 아니면 (제 3자)
				if (!loginName.equals(reply.getUsername())) {
					// 비밀 댓글 수 증가, 다음 댓글로 넘어감
					secretReplyCount++;
					continue;
				} else { // 로그인한 유저가 쓴 댓글이면(제 2자)
					// 자신의 댓글에 딸린 모든 자식 댓글을 가져옴
					childReplies = replyService.getChildRepliesByParentNo(reply.getReplyno());
				}

			} else {// 로그인한 유저(제 1자)가 쓴글이라면
				// 해당 1차 reply에 딸린 모든 자식 댓글을 가져옴
				childReplies = replyService.getChildRepliesByParentNo(reply.getReplyno());
			}

			jsonParentReply.put("parentReply", reply);
			jsonParentReply.put("childReplies", childReplies);

			replies.add(jsonParentReply);
		}

		JSONObject response = new JSONObject();
		response.put("replies", replies);
		System.out.println("jsp로 보내는 replies : " + replies);
		response.put("secretReplyCount", secretReplyCount);
		System.out.println("jsp로 보내는 response : " + response);
		return new ResponseEntity<JSONObject>(response, HttpStatus.OK);

	}

	// AJAX에서 요청한 댓글등록 처리
	@RequestMapping(value = "/{boardno}", method = RequestMethod.POST)
	public ResponseEntity<Void> addReply(@RequestBody Map<String, Object> data,
			@PathVariable(value = "boardno") int boardNo) throws Exception {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();

		if (username == null)
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);

		System.out.println("jsp에서 온 data : " + data);
		
		JSONObject replyJSON = JSONObject.fromObject(data.get("reply"));

		ReplyVO reply = new ReplyVO();

		int parentno = (int) data.get("parentno");

		// boardNo, username으로 이 게시물에 내가 달은 댓글이 있는지 확인
		if (replyService.isExistMyParentReply(boardNo, username)) {
			
			// 내가 달은 댓글이 있고 지금 요청한게 1차 댓글이라면 댓글을 달 수 없다.
			if (parentno == 0) {
				System.out.println("1차 댓글이 이미 존재한다.");
				return new ResponseEntity<Void>(HttpStatus.CONFLICT);
			}
				
		}
		System.out.println("댓글을 등록할 수 있다.");
		
		reply.setParentno(parentno);
		reply.setBoardno(replyJSON.getInt("boardno"));
		reply.setContent(replyJSON.getString("content"));
		reply.setUsername(replyJSON.getString("username"));
		reply.setReplydate(new Date());

		replyService.addReply(reply);

		return new ResponseEntity<Void>(HttpStatus.OK);
	}
}