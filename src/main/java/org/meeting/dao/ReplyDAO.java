package org.meeting.dao;

import java.util.List;

import org.meeting.domain.ReplyRelationVO;
import org.meeting.domain.ReplyVO;

public interface ReplyDAO {

	public int getParentNoByBoardNo(int boardNo, String username);
	public int addReply(ReplyVO reply);
	public List<ReplyVO> getAllRepliesByParentNo(int parentno);
	public int getRepliesCountByBoardNo(int boardNo, String username);
	public boolean isExistMyParentReply(int boardNo, String username);

}
