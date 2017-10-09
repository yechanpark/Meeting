package org.study.web;

import java.util.Date;

import javax.inject.Inject;

import org.meeting.domain.ReplyVO;
import org.meeting.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rest/reply")
public class ReplyController {

	@Inject
	ReplyService replyService;

	// ��� �߰�
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<?> addReply(@RequestBody ReplyVO addedReply) throws Exception {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();

		if (username == null)
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);

		// boardNo, username���� �� �Խù��� ���� ���� ����� �ִ��� Ȯ��
		if (replyService.isExistMyParentReply(addedReply.getBoardno(), username)) {
			// 1�� ��� 2�� ���� ��� �Ұ�
			if (addedReply.getParentno() == 0)
				return new ResponseEntity<Void>(HttpStatus.CONFLICT);
		}

		addedReply.setReplydate(new Date());
		addedReply.setReplyno(replyService.addReply(addedReply));

		return new ResponseEntity<ReplyVO>(replyService.getReplyById(addedReply.getReplyno()), HttpStatus.OK);
	}

	// ��� ����
	@RequestMapping(value = "", method = RequestMethod.PUT)
	public ResponseEntity<?> updateReply(@RequestBody ReplyVO updatedReply) {

		ReplyVO reply = replyService.getReplyById(updatedReply.getReplyno());
		reply.setContent(updatedReply.getContent());

		if (replyService.updateReply(reply) == 1)
			return new ResponseEntity<ReplyVO>(reply, HttpStatus.OK);
		else
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);

	}

	// ��� ����
	@RequestMapping(value = "", method = RequestMethod.DELETE)
	public ResponseEntity<?> deleteReply(@RequestBody ReplyVO deletedReply) {
		ReplyVO reply = replyService.getReplyById(deletedReply.getReplyno());
		
		if (replyService.deleteReply(reply) >= 1)
			return new ResponseEntity<ReplyVO>(reply, HttpStatus.OK);
		else
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);

	}
}