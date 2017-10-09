package org.meeting.service;

import java.util.List;

import org.meeting.domain.ReplyVO;

public interface ReplyService {

	List<ReplyVO> getRepliesByBoardNo(int boardNo);

	boolean isExistMyParentReply(int boardNo, String username);

	int addReply(ReplyVO addedReply) throws Exception;

	int updateReply(ReplyVO updatedReply);

	int deleteReply(ReplyVO deletedReply);

	ReplyVO getReplyById(int replyno);
}