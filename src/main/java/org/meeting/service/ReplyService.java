package org.meeting.service;

import java.util.List;

import org.meeting.domain.ReplyVO;

public interface ReplyService {

	List<ReplyVO> getRepliesByBoardNo(int boardNo);

	boolean isExistMyParentReply(int boardNo, String username);

	int addReply(ReplyVO reply) throws Exception;

	int updateReply(ReplyVO reply);

	int deleteReply(ReplyVO reply);

	ReplyVO getReplyById(int replyno);
}