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

	public List<ReplyVO> getRepliesByBoardNo(int boardNo) {
		List<ReplyVO> replies = replyDao.getRepliesByBoardNo(boardNo);
		return replies;
	}

	@Override
	public void addReply(ReplyVO reply) {
		replyDao.addReply(reply);
		
	}
	
	@Override
	public void addReplyRelation(ReplyRelationVO replyRelation){
		replyDao.addReplyRelation(replyRelation);
	}

}
