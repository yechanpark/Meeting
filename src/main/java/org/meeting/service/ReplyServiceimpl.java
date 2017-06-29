package org.meeting.service;

import java.util.List;

import javax.inject.Inject;

import org.meeting.dao.ReplyDAO;
import org.meeting.domain.ReplyVO;
import org.springframework.stereotype.Service;

@Service
public class ReplyServiceimpl implements ReplyService {

	@Inject
	ReplyDAO replyDao;

	@Override
	public List<ReplyVO> getParentReplies(int boardNo) {
		return replyDao.getParentRelpies(boardNo);
	}

	@Override
	public List<ReplyVO> getChildRepliesByParentNo(int replyno) {
		return replyDao.getChildRepliesByParentNo(replyno);
	}

	@Override
	public boolean isExistMyParentReply(int boardNo, String username) {
		return replyDao.isExistMyParentReply(boardNo, username);
	}

	@Override
	public void addReply(ReplyVO reply) {
		replyDao.addReply(reply);
	}
}
