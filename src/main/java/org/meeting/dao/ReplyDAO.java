package org.meeting.dao;

import java.util.List;

import org.meeting.domain.ReplyVO;

public interface ReplyDAO {

	public List<ReplyVO> getRepliesByBoardNo(int boardNo);

}
