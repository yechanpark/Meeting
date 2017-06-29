package org.meeting.service;

import java.util.List;

import org.meeting.domain.ReplyVO;

public interface ReplyService {

	List<ReplyVO> getParentReplies(int boardNo);
	List<ReplyVO> getChildRepliesByParentNo(int replyno);
	boolean isExistMyParentReply(int boardNo, String username);
	void addReply(ReplyVO reply);
}