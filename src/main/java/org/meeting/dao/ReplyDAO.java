package org.meeting.dao;

import java.util.List;

import org.meeting.domain.ReplyVO;

public interface ReplyDAO {

	List<ReplyVO> getParentRelpies(int boardNo);
	List<ReplyVO> getChildRepliesByParentNo(int replyno);
	boolean isExistMyParentReply(int boardNo, String username);
	int addReply(ReplyVO reply);

}
