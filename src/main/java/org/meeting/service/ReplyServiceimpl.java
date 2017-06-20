package org.meeting.service;

import java.util.List;

import javax.inject.Inject;

import org.meeting.dao.ReplyDAO;
import org.meeting.domain.ReplyRelationVO;
import org.meeting.domain.ReplyVO;
import org.springframework.stereotype.Service;

@Service
public class ReplyServiceimpl implements ReplyService {

	@Inject
	ReplyDAO replyDao;

	
	@Override
	 public int getParentNoByBoardNo(int boardNo, String username) {
		return replyDao.getParentNoByBoardNo(boardNo, username);
	}
	
	/*
	 * @Override
	 * public List<ReplyVO> getRepliesByBoardNo(int boardNo) {
		List<ReplyVO> replies = replyDao.getRepliesByBoardNo(boardNo);
		return replies;
	}*/

	@Override
	public int addReply(ReplyVO reply) {
		return replyDao.addReply(reply);
		
	}

	@Override
	public List<ReplyVO> getAllRepliesByParentNo(int parentno) {
		return replyDao.getAllRepliesByParentNo(parentno);
		
	}

	@Override
	public int getRepliesCountByBoardNo(int boardNo, String username) {
		return replyDao.getRepliesCountByBoardNo(boardNo, username);
	}

	@Override
	public boolean isExistMyParentReply(int boardno, String username) {
		return replyDao.isExistMyParentReply(boardno, username);
	}
}
